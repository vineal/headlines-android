package com.monzo.headlines.domain.usecase

import com.monzo.headlines.domain.model.Article
import com.monzo.headlines.domain.repository.LocalArticlesRepository

interface FetchLocalArticlesUseCase {
    suspend fun fetchArticles(): Result<List<Article>>
}

class FetchLocalArticlesUseCaseImpl(
    private val localRepository: LocalArticlesRepository
) : FetchLocalArticlesUseCase {
    override suspend fun fetchArticles(): Result<List<Article>> =
        localRepository.fetchArticles()
}
