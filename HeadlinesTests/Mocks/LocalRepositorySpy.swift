//
//  LocalRepositorySpy.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//
@testable import Headlines

class LocalRepositorySpy: LocalArticlesRepositoryProtocol {
    func favouriteArticle(article: Headlines.Article, completion: @escaping ((any Error)?) -> Void) {
        // TODO: Needs tests and implementation
    }
    
    func fetchFavourites(completion: @escaping ([Headlines.Article]?, (any Error)?) -> Void) {
        // TODO: Needs tests and implementation
    }
    
    
    let shouldThrowError: Bool
    var saveArticlesCounter = 0
    var fetchArticlesCounter = 0

    init(shouldThrowError: Bool) {
        self.shouldThrowError = shouldThrowError
    }
    
    func saveArticles(_ articles: [Headlines.Article]) throws {
        saveArticlesCounter += 1
        if shouldThrowError {
            throw CustomErrors.dbOpertaionFailure
        }
    }
    
    func fetchArticles(completion: @escaping ([Article], (any Error)?) -> Void) {
        fetchArticlesCounter += 1
        shouldThrowError ? completion([], CustomErrors.dbOpertaionFailure) : completion([], nil)
    }
}
