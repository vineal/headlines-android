//
//  FetchLocalArticlesUseCase.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

protocol FetchLocalArticlesUseCaseProtocol {
    func fetchArticles(completion: @escaping (([Article]?, Error?) -> Void))
}

struct FetchLocalArticlesUseCase: FetchLocalArticlesUseCaseProtocol {
    let localRepository: LocalArticlesRepositoryProtocol
   
    init(localRepository: LocalArticlesRepositoryProtocol) {
        self.localRepository = localRepository
    }
    
    func fetchArticles(completion: @escaping (([Article]?, Error?) -> Void)) {
        localRepository.fetchArticles(completion: completion)
    }
}
