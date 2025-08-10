//
//  RemoteRepositorySpy.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

@testable import Headlines

class RemoteRepositorySpy: RemoteArticlesRepositoryProtocol {
    var fetchArticlesCounter = 0
    let shouldReturnArticles: Bool
    
    init(shouldReturnArticles: Bool) {
        self.shouldReturnArticles = shouldReturnArticles
    }
    
    func fetchArticles(completion: @escaping ([Headlines.Article]?, (any Error)?) -> Void) {
        fetchArticlesCounter += 1
        shouldReturnArticles ? completion([], nil) : completion(nil, CustomErrors.remoteFetchFailed)
    }
}
