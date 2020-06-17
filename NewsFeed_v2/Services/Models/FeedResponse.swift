//
//  FeedResponse.swift
//  NewsFeed_v2
//
//  Created by Egor on 17.06.2020.
//  Copyright © 2020 TASS. All rights reserved.
//

import Foundation

struct FeedResponseWapped: Decodable {
    let response: FeedResponse
}

struct FeedResponse: Decodable {
    var items: [FeedItems]
}

struct FeedItems: Decodable {
    let sourceId: Int
    let postId: Int
    let text: String?
    let date: Double
    let comments: CountableItem?
    let likes: CountableItem?
    let reposts: CountableItem?
    let views: CountableItem?
}

struct CountableItem: Decodable {
    let count: Int
}
