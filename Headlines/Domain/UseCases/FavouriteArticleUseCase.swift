//
//  FavouriteArticleUseCase.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

protocol FavouriteArticleUseCaseProtocol {
    func favouriteArticle(article: Article, completion: @escaping (Error?) -> Void)
}

struct FavouriteArticleUseCase: FavouriteArticleUseCaseProtocol {
    let repository: LocalArticlesRepositoryProtocol
    
    init(repository: LocalArticlesRepositoryProtocol = LocalArticlesRepository()) {
        self.repository = repository
    }
    
    func favouriteArticle(article: Article, completion: @escaping (Error?) -> Void) {
        repository.favouriteArticle(article: article, completion: completion)
    }
}
