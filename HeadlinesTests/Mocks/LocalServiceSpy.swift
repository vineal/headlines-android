//
//  LocalServiceSpy.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

@testable import Headlines

class LocalServiceSpy: LocalArticlesServiceProtocol {
    
    let shouldThrowError: Bool
    var saveArticlesCounter = 0
    
    init(shouldThrowError: Bool) {
        self.shouldThrowError = shouldThrowError
    }
    
    func saveArticles(_ articles: [ArticleDB]) throws {
        saveArticlesCounter += 1
        if shouldThrowError {
            throw CustomErrors.dbOpertaionFailure
        }
    }
}
