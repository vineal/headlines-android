//
//  RemoteArticlesService.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

protocol RemoteArticlesServiceProtocol {
    func fetchArticles(completion: @escaping (([RemoteArticleDTO]?, Error?) -> Void))
}
