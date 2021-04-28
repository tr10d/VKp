//
//  Groups.swift
//  VKp
//
//  Created by  Sergei on 28.04.2021.
//
// swiftlint:disable identifier_name nesting

import Foundation

extension Json {
  struct Groups: Codable {
    struct Item: Codable, ProfileRepresentable {
      let id: Int
      let name, screenName: String
      let type: String
      let photo50, photo100, photo200: String

      var photo: String { photo100 }
    }
  }
}
