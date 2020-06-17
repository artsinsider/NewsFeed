//
//  NetworkService.swift
//  NewsFeed_v2
//
//  Created by Egor on 16.06.2020.
//  Copyright © 2020 TASS. All rights reserved.
//

import Foundation

protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

class NetworkService: Networking {
    
    private let authService: AuthServices
    
    init(authService: AuthServices = SceneDelegate.shared().authService) {
        self.authService = authService
    }
    
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        print(#function)
        guard let token = authService.token else { return }
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        let url = self.url(from: path, params: allParams)
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        
        task.resume()
        print("<URL> - \(url)")
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        print(#function)
        return URLSession.shared.dataTask(with: request, completionHandler: {(data, response, error) in
            DispatchQueue.main.async {
               completion(data, error)
           }
        })
    }
    
    private func url(from path: String, params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = API.newsFeed
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        print(#function)
        return components.url!
        
    }
}
