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

  func cellViewModel(
    from item: Json.Newsfeed.Item,
    profiles: [Users.Item],
    groups: [Groups.Item]
  ) -> FeedViewModel.Cell {
    let profile = profile(for: item.sourceId, profiles: profiles, groups: groups)
    return FeedViewModel.Cell(image: profile?.photo ?? "",
                       name: profile?.name ?? "",
                       date: dateFormatter.string(from: Date(timeIntervalSince1970: item.date)),
                       text: item.text,
                       likes: String(item.likes?.count ?? 0),
                       comments: String(item.comments?.count ?? 0),
                       shares: String(item.reposts?.count ?? 0),
                       views: String(item.views?.count ?? 0)
    )
  }

  private func profile(for sourseId: Int, profiles: [Users.Item], groups: [Groups.Item]) -> ProfileRepresentable? {
    let isUser = sourseId > 0
    let absSourseId = abs(sourseId)
    let arrayForSearch: [ProfileRepresentable] = isUser ? profiles : groups
    return arrayForSearch .first { $0.id == absSourseId }
  }
}
