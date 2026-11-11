package com.monzo.headlines.domain.usecase

import com.monzo.headlines.domain.model.Article
import com.monzo.headlines.domain.repository.LocalArticlesRepository

interface FetchFavouritesUseCase {
    suspend fun fetchFavourites(): Result<List<Article>>
}

class FetchFavouritesUseCaseImpl(
    private val localRepository: LocalArticlesRepository
) : FetchFavouritesUseCase {
    override suspend fun fetchFavourites(): Result<List<Article>> =
        localRepository.fetchFavourites()
}
