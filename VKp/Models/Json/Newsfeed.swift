//
//  Newsfeed.swift
//  VKp
//
//  Created by  Sergei on 26.04.2021.
//
// swiftlint:disable nesting

import Foundation

extension Json {
  struct Newsfeed: Codable {
    let response: Response?

    // MARK: - Response
    struct Response: Codable {
      var items: [Item]
      let profiles: [Users.Item]
      let groups: [Groups.Item]
    }

    // MARK: - Item
    struct Item: Codable {
      let type: String
      let sourceId: Int
      let date: Double
      let postType: String
      let text: String?
      let comments: Json.Comments?
      let likes: Json.Likes?
      let reposts: Json.Reposts?
      let views: Json.Views?
      let attachments: [Json.Attachment]?
    }
  }
}
