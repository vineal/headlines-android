package com.monzo.headlines.domain.usecase

import com.monzo.headlines.domain.model.Article
import com.monzo.headlines.domain.repository.RemoteArticlesRepository

interface FetchRemoteArticlesUseCase {
    suspend fun fetchArticles(): Result<List<Article>>
}

class FetchRemoteArticlesUseCaseImpl(
    private val remoteRepository: RemoteArticlesRepository
) : FetchRemoteArticlesUseCase {
    override suspend fun fetchArticles(): Result<List<Article>> =
        remoteRepository.fetchArticles()
}
