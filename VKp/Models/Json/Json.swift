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
    let type: String
    let url: String
    let width: Int
    let height: Int
  }

  // MARK: - Size
  struct Attachment: Codable {
      let type: String
      let photo: Photo.Item?
  }
}
