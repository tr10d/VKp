//
//  WebImageView.swift
//  VKp
//
//  Created by  Sergei on 27.04.2021.
//

import UIKit
import Combine

class WebImageView: UIImageView {
  var cancellable: AnyCancellable?
  func set(imageURL: String?) {
//    isHidden = imageURL == nil

    guard let imageURL = imageURL,
          let url = URL(string: imageURL) else { return }

    cancellable = URLSession.shared
      .dataTaskPublisher(for: url)
      .map { UIImage(data: $0.data) }
      .replaceError(with: nil)
      .receive(on: DispatchQueue.main)
      .assign(to: \.image, on: self)
  }
}
