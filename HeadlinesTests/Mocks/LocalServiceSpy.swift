//
//  LocalServiceSpy.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

@testable import Headlines

class LocalServiceSpy: LocalArticlesServiceProtocol {
    func fetchArticles(completion: @escaping ([Headlines.ArticleDB], (any Error)?) -> Void) {
        // TODO: Needs tests and implementation
    }
    
    func favouriteArticle(article: Headlines.ArticleDB?, completion: @escaping ((any Error)?) -> Void) {
        // TODO: Needs tests and implementation
    }
    
    func fetchFavourites(completion: @escaping ([Headlines.ArticleDB], (any Error)?) -> Void) {
        // TODO: Needs tests and implementation
    }
    
    
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
