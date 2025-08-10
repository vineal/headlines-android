//
//  LocalArticlesService.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

import RealmSwift
import Foundation

protocol LocalArticlesServiceProtocol {
    func saveArticles(_ articles: [ArticleDB]) throws
    func fetchArticles(completion: @escaping ([ArticleDB], Error?) -> Void)
    func favouriteArticle(article: ArticleDB?, completion: @escaping (Error?) -> Void)
}

struct LocalArticlesService: LocalArticlesServiceProtocol {
    
    func fetchArticles(completion: @escaping ([ArticleDB], (any Error)?) -> Void) {
        do {
            let realm = try Realm()
            let all = realm.objects(ArticleDB.self)
            completion(Array(all), nil)
        } catch {
            completion([], CustomErrors.dbOpertaionFailure)
        }
    }
    
    func saveArticles(_ articles: [ArticleDB]) throws {
        let realm = try Realm()
        let incomingIDs = Set(articles.map(\.id))
        try realm.write {
            for article in articles {
                realm.create(
                    ArticleDB.self,
                    value: [
                        "id": article.id,
                        "headline": article.headline,
                        "body": article.body,
                        "published": article.published as Any,
                        "rawImageURL": article.rawImageURL as Any
                    ],
                    update: .modified
                )
            }
            let stale = realm.objects(ArticleDB.self).where { !$0.id.in(Array(incomingIDs)) }
            realm.delete(stale)
        }
    }
    
    func favouriteArticle(article: ArticleDB?, completion: @escaping (Error?) -> Void) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.create(
                    ArticleDB.self,
                    value: [
                        "id": article?.id ?? UUID().uuidString,
                        "isFavourited": article?.isFavourited ?? true
                    ],
                    update: .modified
                )
            }
        } catch {
            completion(CustomErrors.dbOpertaionFailure)
        }
    }
}
