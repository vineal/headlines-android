//
//  ArticlePageViewModel.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

// TODO: Remove import after moving to usecase
import RealmSwift

class ArticlePageViewModel {
    var articles: [Article]?
    var onArticlesChanged: (([ArticleViewController]?, Error?) -> Void)?
    var articlesVCs: [ArticleViewController]? {
        didSet { onArticlesChanged?(articlesVCs, nil) }
    }
    
    let remoteArticleFetchUseCase: FetchRemoteArticlesUseCaseProtocol
    let saveArticlesUseCase: SaveArticlesInDBUseCaseProtocol
    let fetchLocalArticlesUseCase: FetchLocalArticlesUseCaseProtocol
    init(
        articles: [Article]? = nil,
        onArticlesChanged: (([ArticleViewController]?, Error?) -> Void)? = nil,
        articlesVCs: [ArticleViewController]? = nil,
        remoteArticleFetchUseCase: FetchRemoteArticlesUseCaseProtocol = FetchRemoteArticlesUseCase(),
        saveArticlesUseCase: SaveArticlesInDBUseCaseProtocol = SaveArticlesInDBUseCase(),
        fetchLocalArticlesUseCase: FetchLocalArticlesUseCaseProtocol = FetchLocalArticlesUseCase()
    ) {
        self.articles = articles
        self.onArticlesChanged = onArticlesChanged
        self.articlesVCs = articlesVCs
        self.remoteArticleFetchUseCase = remoteArticleFetchUseCase
        self.saveArticlesUseCase = saveArticlesUseCase
        self.fetchLocalArticlesUseCase = fetchLocalArticlesUseCase
    }
    
    func fetchArticles() {
        remoteArticleFetchUseCase.fetchArticles { [weak self] articles, error in
            guard let articles else { return }
            do {
                try self?.saveArticlesUseCase.saveArticles(articles)
            } catch {
                // TODO: Handle errors
            }
            self?.reload()
        }
    }
    
    func reload() {
        fetchLocalArticlesUseCase.fetchArticles { [weak self] articles, error in
            self?.articles = articles
            self?.getListOfArticleVCs()
        }
    }
    
    func getListOfArticleVCs(){
        var articleVCs: [ArticleViewController] = []
        if let articles {
            for index in 0..<articles.count {
                let articleVC = ArticleViewController(article: articles[index])
                articleVCs.append(articleVC)
            }
        }
        self.articlesVCs = articleVCs
    }
}
