//
//  ArticlePageViewModel.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

class ArticlePageViewModel {
    var articles: [Article]?
    var onArticlesChanged: (([ViewController]?, Error?) -> Void)?
    var articlesVCs: [ViewController]? {
        didSet { onArticlesChanged?(articlesVCs, nil) }
    }
    
    func fetchArticles() {
        Article.fetchArticles { [weak self] articles, error in
            // TODO: Handle errors
            self?.articles = articles
            self?.articlesVCs = self?.getListOfArticleVCs()
        }
    }
    
    func getListOfArticleVCs() -> [ViewController] {
        var articleVCs: [ViewController] = []
        if let articles {
            for index in 0..<articles.count {
                let articleVC = ViewController(article: articles[index])
                articleVCs.append(articleVC)
            }
        }
        return articleVCs
    }
}
