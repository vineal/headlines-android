//
//  LocalArticlesRepositoryProtocol.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

protocol LocalArticlesRepositoryProtocol {
    func saveArticles(_ articles: [Article]) throws
    func fetchArticles(completion: @escaping ([Article], Error?) -> Void)
    func favouriteArticle(article: Article, completion: @escaping (Error?) -> Void)
    func fetchFavourites(completion: @escaping (([Article]?, Error?) -> Void))
}
