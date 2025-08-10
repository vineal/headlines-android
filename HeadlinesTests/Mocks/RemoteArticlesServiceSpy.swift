//
//  RemoteArticlesServiceSpy.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

@testable import Headlines

class RemoteArticlesServiceSpy : RemoteArticlesServiceProtocol {
    var fetchArticlesCalledCount = 0
    var completeWithError: Bool
    
    init(completeWithError: Bool) {
        self.completeWithError = completeWithError
    }
    
    func fetchArticles(completion: @escaping ([Headlines.RemoteArticleDTO]?, (any Error)?) -> Void) {
        fetchArticlesCalledCount += 1
        completeWithError ? completion(nil, CustomErrors.remoteFetchFailed) : completion([], nil)
    }
}
