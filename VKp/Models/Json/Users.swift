//
//  Users.swift
//  VKp
//
//  Created by  Sergei on 28.04.2021.
//
// swiftlint:disable identifier_name nesting

import Foundation

extension Json {
  struct Users: Codable {
    struct Item: Codable, ProfileRepresentable {
      let id: Int
      let firstName, lastName: String
      let photo50, photo100, photo200: String?

      var name: String { "\(firstName) \(lastName)" }
      var photo: String { photo100 ?? "" }
    }
  }
}
