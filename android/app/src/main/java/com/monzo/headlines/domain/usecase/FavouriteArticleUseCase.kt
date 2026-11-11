package com.monzo.headlines.domain.usecase

import com.monzo.headlines.domain.model.Article
import com.monzo.headlines.domain.repository.LocalArticlesRepository

interface FavouriteArticleUseCase {
    suspend fun favouriteArticle(article: Article): Result<Unit>
}

class FavouriteArticleUseCaseImpl(
    private val repository: LocalArticlesRepository
) : FavouriteArticleUseCase {
    override suspend fun favouriteArticle(article: Article): Result<Unit> =
        repository.favouriteArticle(article)
}
