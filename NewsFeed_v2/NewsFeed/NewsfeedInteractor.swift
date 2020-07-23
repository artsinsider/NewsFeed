//
//  NewsfeedInteractor.swift
//  NewsFeed_v2
//
//  Created by Egor on 17.06.2020.
//  Copyright (c) 2020 TASS. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
  func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {

  var presenter: NewsfeedPresentationLogic?
  var service: NewsfeedService?
    
  private var fetcher: DataFetcher = NetworkDataFetcher(netWorking: NetworkService())
  
  func makeRequest(request: Newsfeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsfeedService()
    }
    
    switch request {
    
    case .getNewsFeed:
        fetcher.getFedd { [weak self](feedResponse) in
            guard let feedResponse = feedResponse else { return }
            self?.presenter?.presentData(response: Newsfeed.Model.Response.ResponseType.presentNewdFeed(feed: feedResponse))
        }
    
    }
  }
  
}
