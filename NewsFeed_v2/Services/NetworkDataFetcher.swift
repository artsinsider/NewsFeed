//
//  NetworkDataFetcher.swift
//  NewsFeed_v2
//
//  Created by Egor on 17.06.2020.
//  Copyright © 2020 TASS. All rights reserved.
//

import Foundation


protocol DataFetcher {
    func getFedd(response: @escaping (FeedResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
    let netWorking: Networking
    
    init(netWorking: Networking) {
        self.netWorking =  netWorking
    }
    
    func getFedd(response: @escaping (FeedResponse?) -> Void) {
        let params = ["filters": "post, photo"]
        netWorking.request(path: API.newsFeed, params: params) { (data, error) in
            if let error = error {
                print("Error received riquesting data: \(error)")
                response(nil)
            }
            
            let decoded = self.decoderJson(type: FeedResponseWapped.self, from: data)
            response(decoded?.response)
            
        }
    }
    
    private func decoderJson<T: Decodable> (type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let data = from , let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}




   
