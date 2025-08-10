//
//  ArticleToArticleDBMapper.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

struct ArticleToArticleDBMapper {
    func map(_ article: Article) -> ArticleDB? {
        return ArticleDB(
            headline: article.headline,
            body: article.body,
            published: article.published,
            rawImageURL: article.rawImageURL
        )
    }
}
