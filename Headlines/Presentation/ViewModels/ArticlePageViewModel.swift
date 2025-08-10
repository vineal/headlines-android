//
//  ArticlePageViewModel.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

class ArticlePageViewModel {
    var articles: [Article]?
    var onArticlesChanged: (([ArticleViewController]?, Error?) -> Void)?
    var articlesVCs: [ArticleViewController]? {
        didSet { onArticlesChanged?(articlesVCs, nil) }
    }
    
    func fetchArticles() {
        Article.fetchArticles { [weak self] articles, error in
            // TODO: Handle errors
            self?.articles = articles
            self?.articlesVCs = self?.getListOfArticleVCs()
        }
    }
    
    func getListOfArticleVCs() -> [ArticleViewController] {
        var articleVCs: [ArticleViewController] = []
        if let articles {
            for index in 0..<articles.count {
                let articleVC = ArticleViewController(article: articles[index])
                articleVCs.append(articleVC)
            }
        }
        return articleVCs
    }
}
