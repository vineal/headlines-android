//
//  RemoteArticlesRepositoryProtocol.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

protocol RemoteArticlesRepositoryProtocol {
    func fetchArticles(completion: @escaping (([Article]?, Error?) -> Void))
}
