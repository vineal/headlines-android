//
//  RemoteArticlesRepository.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

struct RemoteArticlesRepository: RemoteArticlesRepositoryProtocol {
    let service: RemoteArticlesServiceProtocol
    
    init(service: RemoteArticlesServiceProtocol) {
        self.service = service
    }
    
    func fetchArticles(completion: @escaping ([Article]?, (any Error)?) -> Void) {
        service.fetchArticles { articles, error in
            completion(articles?.compactMap({RemoteArticleToArticleMapper().map($0)}), error)
        }
    }
}
