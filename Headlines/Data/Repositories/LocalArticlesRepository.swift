//
//  LocalArticlesRepository.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

struct LocalArticlesRepository: LocalArticlesRepositoryProtocol{
    let service: LocalArticlesServiceProtocol
    let articleToDBMapper: ArticleToArticleDBMapper

    init(
        service: LocalArticlesServiceProtocol = LocalArticlesService(),
        articleToDBMapper: ArticleToArticleDBMapper = ArticleToArticleDBMapper()
    ) {
        self.service = service
        self.articleToDBMapper = articleToDBMapper
    }
    
    func saveArticles(_ articles: [Article]) throws {
        try service.saveArticles(articles.compactMap { articleToDBMapper.map($0) })
    }
    
    func fetchArticles(completion: @escaping ([Article], (any Error)?) -> Void) {
        
    }
}
