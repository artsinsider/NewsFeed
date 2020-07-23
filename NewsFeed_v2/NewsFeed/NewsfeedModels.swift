//
//  NewsfeedModels.swift
//  NewsFeed_v2
//
//  Created by Egor on 17.06.2020.
//  Copyright (c) 2020 TASS. All rights reserved.
//

import UIKit

enum Newsfeed {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getNewsFeed
      }
    }
    struct Response {
      enum ResponseType {
        case presentNewdFeed(feed: FeedResponse)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayNewsFeed(feedViewModel: FeedViewModel)
      }
    }
  }
}

struct FeedViewModel {
    struct Cell: FeedCellViewModel {
        var iconUrlString: String
        var name: String
        var date: String
        var text: String?
        var likes: String?
        var comments: String?
        var shared: String?
        var views: String?
    }
    let cells: [Cell]
}
