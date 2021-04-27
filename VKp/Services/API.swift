//
//  API.swift
//  VKp
//
//  Created by  Sergei on 15.04.2021.
//

import Foundation

//// https://api.vk.com/method/users.get?
/// user_ids=210700286
/// &fields=bdate
/// &access_token=533bacf01e11f55b536a565b57531ac114461ae8736d6506a3
/// &v=5.130
struct API {
  static let appId = "7816753"
  static let version = "5.130"
  static let scope = ["offline", "friends", "photos", "groups", "wall"]
  static let scheme = "https"
  static let host = "api.vk.com"
  static let path = "/method/"
  static let requiredParameters = [
    "access_token": SceneDelegate.shared.authService.token,
    "v": API.version
  ]

  struct Methods {
    static let newsfeed = Newsfeed()
  }
}

extension API {
  struct Newsfeed {
    let path = API.path + "newsfeed.get"
    let parameters = API.requiredParameters + [
      "filters": "post,photo"
    ]
  }
}

extension Dictionary where Key == String, Value == String {
  var queryItems: [URLQueryItem] {
    self.map { URLQueryItem(name: $0, value: $1) }
  }

  static func + <K, V>(left: [K: V], right: [K: V]) -> [K: V] {
    var map = [K: V]()
      for (key, value) in left {
          map[key] = value
      }
      for (key, value) in right {
          map[key] = value
      }
      return map
  }
}
