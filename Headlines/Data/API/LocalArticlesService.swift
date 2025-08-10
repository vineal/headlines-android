//
//  LocalArticlesService.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

protocol LocalArticlesServiceProtocol {
    func saveArticles(_ articles: [ArticleDB]) throws
}

struct LocalArticlesService: LocalArticlesServiceProtocol {
    func saveArticles(_ articles: [ArticleDB]) throws {
        throw CustomErrors.dbOpertaionFailure
    }
}
