//
//  NetworkService.swift
//  VKp
//
//  Created by  Sergei on 24.04.2021.
//

import Foundation
import Combine

protocol NetworkServiceDelegate: AnyObject {
  func request(from path: String, with parameters: [String: String], completion: @escaping (Data?, Error?) -> Void)
  func requestCombine<T: Decodable>(
    from path: String,
    with parameters: [String: String],
    type: T.Type,
    completion: @escaping (T) -> Void)
}

final class NetworkService {
  var cancellable: AnyCancellable?

  private func url(from path: String, with parameters: [String: String]) -> URL? {
    var urlComponents = URLComponents()
    urlComponents.scheme = API.scheme
    urlComponents.host = API.host
    urlComponents.path = path
    urlComponents.queryItems = parameters.queryItems
    #if DEBUG
    debugPrint(urlComponents)
    #endif
    return urlComponents.url
  }
}

extension NetworkService: NetworkServiceDelegate {
  func request(from path: String, with parameters: [String: String], completion: @escaping (Data?, Error?) -> Void) {
    guard let url = self.url(from: path, with: parameters) else { return }

    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { data, _, error in
      DispatchQueue.main.async {
        completion(data, error)
      }
    }.resume()
  }

  func requestCombine<T: Decodable>(
    from path: String,
    with parameters: [String: String],
    type: T.Type,
    completion: @escaping (T) -> Void) {

    guard let url = self.url(from: path, with: parameters) else { return }

    cancellable = URLSession.shared.dataTaskPublisher(for: url)
      .tryMap { result -> T in
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: result.data)
      }
      .sink(
        receiveCompletion: { result in
          switch result {
          case .failure(let error):
            debugPrint(error)
          case .finished:
            break
          }
        },
        receiveValue: { viewModel in
          completion(viewModel)
        })
  }
}
