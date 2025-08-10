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
    
    init(articles: [Article]? = nil, onArticlesChanged: (([ArticleViewController]?, Error?) -> Void)? = nil, articlesVCs: [ArticleViewController]? = nil, remoteArticleFetchUseCase: FetchRemoteArticlesUseCaseProtocol = FetchRemoteArticlesUseCase()) {
        self.articles = articles
        self.onArticlesChanged = onArticlesChanged
        self.articlesVCs = articlesVCs
        self.remoteArticleFetchUseCase = remoteArticleFetchUseCase
    }
    
    func fetchArticles() {
        remoteArticleFetchUseCase.fetchArticles { [weak self] articles, error in
            // TODO: Handle errors
            self?.saveArticlesInDB(articles: articles, completeion: { [weak self] error in
                self?.onArticlesChanged?(nil, error)
            })
            self?.articles = articles
            self?.getListOfArticleVCs()
        }
    }
    
    private func saveArticlesInDB(articles: [Article]?, completeion: ((Error?) -> Void)?) {
        // TODO: Move to it's own usecase
        guard let articles else { return }
        do {
            let realm = try Realm()
            _ = try realm.write {
                realm.delete(Article.all)
                realm.add(articles)
            }
        } catch {
            completeion?(error)
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
