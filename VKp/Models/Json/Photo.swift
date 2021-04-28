//
//  Photo.swift
//  VKp
//
//  Created by  Sergei on 28.04.2021.
//
// swiftlint:disable identifier_name nesting

import Foundation

extension Json {
  struct Photo: Codable {
    // MARK: - Item
    struct Item: Codable {
      let id: Int
      let sizes: [Size]
    }
  }
}

extension Json.Photo.Item {
  var width: Int { getSize().width }
  var height: Int { getSize().height }
  var url: String { getSize().url }
//  var size: Json.Size { getSize() }

  private func getSize() -> Json.Size {
    if let size = sizes.first(where: { $0.type == "x" }) {
      return size
    }
    if let size = sizes.last {
      return size
    }
    return Json.Size(type: "No size", url: "", width: 0, height: 0)
  }
}
