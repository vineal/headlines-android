//
//  RemoteArticleToArticleMapper.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

struct RemoteArticleToArticleMapper {
    func map(_ remoteArticle: RemoteArticleDTO) -> Article {
        Article(
            id: remoteArticle.id,
            headline: remoteArticle.headline,
            body: remoteArticle.body,
            published: remoteArticle.published,
            rawImageURL: remoteArticle.rawImageURL,
            isFavourited: nil
        )
    }
}
