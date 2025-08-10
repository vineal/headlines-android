//
//  LocalArticlesService.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

import RealmSwift

protocol LocalArticlesServiceProtocol {
    func saveArticles(_ articles: [ArticleDB]) throws
    func fetchArticles(completion: @escaping ([ArticleDB], Error?) -> Void)
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
}
