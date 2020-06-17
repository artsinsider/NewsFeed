//
//  FeedViewController.swift
//  NewsFeed_v2
//
//  Created by Egor on 16.06.2020.
//  Copyright © 2020 TASS. All rights reserved.
//

import Foundation
import UIKit

class FeedViewController: UIViewController {
    
    private var fetcher: DataFetcher = NetworkDataFetcher(netWorking: NetworkService())
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        fetcher.getFedd { (feedResponse) in
            guard let feedResponse = feedResponse else { return }
            feedResponse.items.map { (feedItem) in
                print(feedItem.date)
            }
        }
    }
}

