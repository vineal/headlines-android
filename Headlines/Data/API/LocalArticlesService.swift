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
        do {
            let realm = try Realm()
            let all = realm.objects(ArticleDB.self)
            _ = try realm.write {
                realm.delete(Array(all))
                realm.add(articles)
            }
        } catch {
            throw CustomErrors.dbOpertaionFailure
        }
    }
}
