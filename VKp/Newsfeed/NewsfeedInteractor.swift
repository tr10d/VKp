//
//  NewsfeedInteractor.swift
//  VKp
//
//  Created by  Sergei on 26.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
  func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {
  var presenter: NewsfeedPresentationLogic?
  var service: NewsfeedService?

  private var fetcher: NetworkDataFetcher = NetworkDataFetcher(networking: NetworkService())

  func makeRequest(request: Newsfeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsfeedService()
    }

    switch request {
    case .newsFeed:
      fetcher.getNewsfeed { [weak self] response in
        guard let response = response else { return }
        self?.presenter?.presentData(response: .newsFeed(feed: response))
      }
    }
  }
}
