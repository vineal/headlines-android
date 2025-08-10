//
//  RemoteArticlesService.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

import Alamofire

protocol RemoteArticlesServiceProtocol {
    func fetchArticles(completion: @escaping (([RemoteArticleDTO]?, Error?) -> Void))
}

struct RemoteArticlesService: RemoteArticlesServiceProtocol {
    
    private let APIKey = Secrets.guardianAPIKey
    
    func fetchArticles(completion: @escaping ([RemoteArticleDTO]?, (any Error)?) -> Void) {
        let url = "https://content.guardianapis.com/search?q=fintech&show-fields=main,body&api-key=\(APIKey)"
        AF.request(url, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success(let value):
                guard let json = value as? [String: Any], let data = json["response"] as? [String: Any], let results = data["results"] as? [[String: Any]] else {
                    completion(nil, response.error)
                    return
                }
                let articles = results.compactMap { RemoteArticleDTO(dictionary: $0) }
                completion(articles, nil)
            case .failure:
                completion(nil, CustomErrors.remoteFetchFailed)
            }
        }
    }
}
