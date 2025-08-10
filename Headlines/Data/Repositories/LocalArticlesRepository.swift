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
    let dBtoArticleMapper: ArticleDBToArticleMapper

    init(
        service: LocalArticlesServiceProtocol = LocalArticlesService(),
        articleToDBMapper: ArticleToArticleDBMapper = ArticleToArticleDBMapper(),
        dBtoArticleMapper: ArticleDBToArticleMapper = ArticleDBToArticleMapper()
    ) {
        self.service = service
        self.articleToDBMapper = articleToDBMapper
        self.dBtoArticleMapper = dBtoArticleMapper
    }
    
    func saveArticles(_ articles: [Article]) throws {
        try service.saveArticles(articles.compactMap { articleToDBMapper.map($0) })
    }
    
    func fetchArticles(completion: @escaping ([Article], (any Error)?) -> Void) {
        service.fetchArticles { articles, error in
            completion(articles.compactMap({ dBtoArticleMapper.map($0)}), error)
        }
    }
}
