//
//  FavouritesViewModel.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

struct FavouritesViewModel {
    let fetchFavouritesUseCase: FetchFavouritesUseCaseProtocol
    
    init(fetchFavouritesUseCase: FetchFavouritesUseCaseProtocol = FetchFavouritesUseCase()) {
        self.fetchFavouritesUseCase = fetchFavouritesUseCase
    }
    
    func fetchFavourites(completion: @escaping (([Article]?, Error?) -> Void)) {
        fetchFavouritesUseCase.fetchFavourites(completion: completion)
    }
}
