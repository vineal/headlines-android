//
//  FetchRemoteArticlesUseCase.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

protocol FetchRemoteArticlesUseCaseProtocol {
    func fetchArticles(completion: @escaping (([Article]?, Error?) -> Void))
}

struct FetchRemoteArticlesUseCase: FetchRemoteArticlesUseCaseProtocol {
    let remoteRepository: RemoteArticlesRepositoryProtocol
    
    init(remoteRepository: RemoteArticlesRepositoryProtocol ) {
        self.remoteRepository = remoteRepository
    }
    
    func fetchArticles(completion: @escaping (([Article]?, Error?) -> Void)) {
        CustomErrors.remoteFetchFailed
    }
}
