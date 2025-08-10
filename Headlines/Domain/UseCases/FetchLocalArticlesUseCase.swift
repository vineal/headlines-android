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
    
    func fetchArticles(completion: @escaping (([Article]?, Error?) -> Void)) {
        completion(nil, CustomErrors.dbOpertaionFailure)
    }
}
