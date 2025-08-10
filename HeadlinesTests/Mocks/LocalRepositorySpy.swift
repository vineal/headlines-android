//
//  LocalRepositorySpy.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//
@testable import Headlines

class LocalRepositorySpy: LocalArticlesRepositoryProtocol {
    let shouldThrowError: Bool
    var saveArticlesCounter = 0
    
    init(shouldThrowError: Bool) {
        self.shouldThrowError = shouldThrowError
    }
    
    func saveArticles(_ articles: [Headlines.Article]) throws {
        saveArticlesCounter += 1
        if shouldThrowError {
            throw CustomErrors.dbOpertaionFailure
        }
    }
}
