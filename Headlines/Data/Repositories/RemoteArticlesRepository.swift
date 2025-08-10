//
//  RemoteArticlesRepository.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

struct RemoteArticlesRepository: RemoteArticlesRepositoryProtocol {
    func fetchArticles(completion: @escaping ([Article]?, (any Error)?) -> Void) {
        CustomErrors.remoteFetchFailed
    }
}
