//
//  Json.swift
//  VKp
//
//  Created by  Sergei on 26.04.2021.
//
// swiftlint:disable identifier_name

import Foundation

protocol ProfileRepresentable {
  var id: Int { get }
  var name: String { get }
  var photo: String { get }
}

struct Json {
  // MARK: - Comments
  struct Comments: Codable {
    let count: Int
  }

  // MARK: - Likes
  struct Likes: Codable {
    let count: Int
  }

  // MARK: - Reposts
  struct Reposts: Codable {
    let count: Int
  }

  // MARK: - Views
  struct Views: Codable {
    let count: Int
  }

  // MARK: - Size
  struct Size: Codable {
    let height: Int
    let url: String
    let type: String
    let width: Int
  }
}

struct Groups: Codable {
  struct Item: Codable, ProfileRepresentable {
    let id: Int
    let name, screenName: String
    let type: String
    let photo50, photo100, photo200: String

    var photo: String { photo100 }
  }
}

struct Users: Codable {
  struct Item: Codable, ProfileRepresentable {
    let id: Int
    let firstName, lastName: String
    let photo50, photo100, photo200: String?

    var name: String { "\(firstName) \(lastName)" }
    var photo: String { photo100 ?? "" }
  }
}
