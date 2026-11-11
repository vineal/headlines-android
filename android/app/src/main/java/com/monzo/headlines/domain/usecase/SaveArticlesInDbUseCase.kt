package com.monzo.headlines.domain.usecase

import com.monzo.headlines.domain.model.Article
import com.monzo.headlines.domain.repository.LocalArticlesRepository

interface SaveArticlesInDbUseCase {
    suspend fun saveArticles(articles: List<Article>): Result<Unit>
}

class SaveArticlesInDbUseCaseImpl(
    private val localRepository: LocalArticlesRepository
) : SaveArticlesInDbUseCase {
    override suspend fun saveArticles(articles: List<Article>): Result<Unit> =
        localRepository.saveArticles(articles)
}
