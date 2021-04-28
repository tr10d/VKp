//
//  NewsfeedPresenter.swift
//  VKp
//
//  Created by  Sergei on 26.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogic {
  func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
  weak var viewController: NewsfeedDisplayLogic?
  private var cellLayoutCalculator = NewsfeedCellLayoutCalculator()
  private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ru_RU")
    dateFormatter.timeStyle = .short
    dateFormatter.dateStyle = .long
    dateFormatter.timeZone = .current
    return dateFormatter
  }()

  func presentData(response: Newsfeed.Model.Response.ResponseType) {
    switch response {
    case .newsFeed(let feed):
      let cells = feed.items.map {
        cellViewModel(from: $0,
                      profiles: feed.profiles,
                      groups: feed.groups)

      }
      let viewModel = FeedViewModel(cells: cells)
      viewController?.displayData(viewModel: .newsFeed(viewModel: viewModel))
    }
  }
}

extension NewsfeedPresenter {
  func cellViewModel(
    from item: Json.Newsfeed.Item,
    profiles: [Json.Users.Item],
    groups: [Json.Groups.Item]
  ) -> FeedViewModel.Cell {
    let profile = profile(for: item.sourceId, profiles: profiles, groups: groups)
    let photoAttachment = photoAttachment(item: item)
    let sizes = cellLayoutCalculator.sizes(postText: item.text, postAttachment: photoAttachment)

    return FeedViewModel.Cell(
      image: profile?.photo ?? "",
      name: profile?.name ?? "",
      date: dateFormatter.string(from: Date(timeIntervalSince1970: item.date)),
      text: item.text,
      likes: String(item.likes?.count ?? 0),
      comments: String(item.comments?.count ?? 0),
      shares: String(item.reposts?.count ?? 0),
      views: String(item.views?.count ?? 0),
      photoAttachment: photoAttachment,
      sizes: sizes)
  }

  private func profile(for sourseId: Int,
                       profiles: [Json.Users.Item],
                       groups: [Json.Groups.Item]) -> ProfileRepresentable? {
    let isUser = sourseId > 0
    let absSourseId = abs(sourseId)
    let arrayForSearch: [ProfileRepresentable] = isUser ? profiles : groups
    return arrayForSearch .first { $0.id == absSourseId }
  }

  private func photoAttachment(item: Json.Newsfeed.Item) -> FeedCellPhotoAttachmentViewModel? {
    guard let photos = item.attachments?.compactMap({ attachment in attachment.photo }),
          let first = photos.first else { return nil }

    return FeedViewModel.FeedCellPhotoAttachment(url: first.url, width: first.width, height: first.height)
  }
}
