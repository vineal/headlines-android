//
//  ArticleViewModel.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

class ArticleViewModel {
    init(favouriteUsecase: FavouriteArticleUseCaseProtocol = FavouriteArticleUseCase()) {
        self.favouriteUsecase = favouriteUsecase
    }
    
    let favouriteUsecase: FavouriteArticleUseCaseProtocol
    
    func favouriteArticle(article: Article, completion: @escaping (Error?) -> Void) {
        favouriteUsecase.favouriteArticle(article: article, completion: completion)
    }
}
