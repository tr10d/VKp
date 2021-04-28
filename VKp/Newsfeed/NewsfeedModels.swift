//
//  NewsfeedModels.swift
//  VKp
//
//  Created by  Sergei on 26.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
// swiftlint:disable nesting

import UIKit

enum Newsfeed {
  enum Model {
    struct Request {
      enum RequestType {
        case newsFeed
      }
    }

    struct Response {
      enum ResponseType {
        case newsFeed(feed: Json.Newsfeed.Response)
     }
    }

    struct ViewModel {
      enum ViewModelData {
        case newsFeed(viewModel: FeedViewModel)
      }
    }
  }
}

struct FeedViewModel {
  let cells: [Cell]

  struct Cell: FeedCellViewModel {
    var image: String
    var name: String
    var date: String
    var text: String?
    var likes: String?
    var comments: String?
    var shares: String?
    var views: String?
    var photoAttachment: FeedCellPhotoAttachmentViewModel?
  }

  struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
    var url: String?
    var width: Int
    var height: Int
  }
}
