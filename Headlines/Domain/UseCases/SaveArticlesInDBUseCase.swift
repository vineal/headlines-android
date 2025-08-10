//
//  SaveArticlesInDBUseCase.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//
protocol SaveArticlesInDBUseCaseProtocol {
    func saveArticles(_ articles: [Article]) throws
}

struct SaveArticlesInDBUseCase: SaveArticlesInDBUseCaseProtocol {
    let localRepository: LocalArticlesRepositoryProtocol
    
    init(localRepository: LocalArticlesRepositoryProtocol = LocalArticlesRepository()) {
        self.localRepository = localRepository
    }
    
    func saveArticles(_ articles: [Article]) throws {
        try localRepository.saveArticles(articles)
    }
}

