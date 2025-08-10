//
//  ArticleDBToArticleMapper.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

struct ArticleDBToArticleMapper {
    func map(_ article: ArticleDB) -> Article? {
        return Article(
            id: article.id,
            headline: article.headline,
            body: article.body,
            published: article.published,
            rawImageURL: article.rawImageURL,
            isFavourited: article.isFavourited
        )
    }
}
