//
//  FetchFavouritesUseCase.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

protocol FetchFavouritesUseCaseProtocol {
    func fetchFavourites(completion: @escaping (([Article]?, Error?) -> Void))
}

struct FetchFavouritesUseCase: FetchFavouritesUseCaseProtocol {
    let localRepository: LocalArticlesRepositoryProtocol
   
    init(localRepository: LocalArticlesRepositoryProtocol = LocalArticlesRepository()) {
        self.localRepository = localRepository
    }
    
    func fetchFavourites(completion: @escaping (([Article]?, Error?) -> Void)) {
        localRepository.fetchFavourites(completion: completion)
    }
}
