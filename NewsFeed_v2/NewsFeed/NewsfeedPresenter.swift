//
//  NewsfeedPresenter.swift
//  NewsFeed_v2
//
//  Created by Egor on 17.06.2020.
//  Copyright (c) 2020 TASS. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogic {
  func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
  weak var viewController: NewsfeedDisplayLogic?
  
  func presentData(response: Newsfeed.Model.Response.ResponseType) {
    switch response {
    
    case .presentNewdFeed(let feed):
        let cells = feed.items.map { (feedItem) in
            cellViewModel(from: feedItem)
        }
        
        let feedViewModel = FeedViewModel.init(cells: cells)
        viewController?.displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData.displayNewsFeed(feedViewModel: feedViewModel))
    
    }
  }
  
    private func cellViewModel(from feedItem: FeedItems) -> FeedViewModel.Cell {
        return FeedViewModel.Cell.init(
            iconUrlString: "URL",
            name: "future name",
            date: "future date",
            text: feedItem.text,
            likes: String(feedItem.likes?.count ?? 0),
            comments: String(feedItem.comments?.count ?? 0),
            shared: String(feedItem.reposts?.count ?? 0),
            views: String(feedItem.views?.count ?? 0)
        )
    }
}
