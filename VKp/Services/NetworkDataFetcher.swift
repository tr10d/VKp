//
//  NetworkDataFetcher.swift
//  VKp
//
//  Created by  Sergei on 26.04.2021.
//
// swiftlint:disable class_delegate_protocol

import Foundation

protocol NetworkDataFetcherDelegate {
  func getNewsfeed(response: @escaping (Json.Newsfeed.Response?) -> Void)
}

struct NetworkDataFetcher: NetworkDataFetcherDelegate {
  let networking: NetworkServiceDelegate

  init(networking: NetworkServiceDelegate) {
    self.networking = networking
  }

  private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
    guard let data = from else { return nil }

    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return try? decoder.decode(type, from: data)
  }

  func getNewsfeed(response: @escaping (Json.Newsfeed.Response?) -> Void) {
    networking.request(from: API.Methods.newsfeed.path,
                       with: API.Methods.newsfeed.parameters) { data, error in
       if let error = error {
        debugPrint(error.localizedDescription)
        response(nil)
      }
      let json = decodeJSON(type: Json.Newsfeed.self, from: data)
      #if DEBUG
      debugPrint(json!)
      #endif
      response(json?.response)
    }
//    networking.requestCombine(from: API.Methods.newsfeed.path,
//                              with: API.Methods.newsfeed.parameters,
//                              type: Json.Newsfeed.self) { json in
//      #if DEBUG
//      debugPrint(json)
//      #endif
//      response(json.response)
//    }
  }
}
