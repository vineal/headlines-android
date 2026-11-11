package com.monzo.headlines.fakes

import com.monzo.headlines.domain.model.Article
import com.monzo.headlines.domain.model.HeadlinesException
import com.monzo.headlines.domain.repository.LocalArticlesRepository

class LocalArticlesRepositorySpy(
    private val shouldThrowError: Boolean
) : LocalArticlesRepository {
    var saveArticlesCounter = 0
    var fetchArticlesCounter = 0

    override suspend fun saveArticles(articles: List<Article>): Result<Unit> {
        saveArticlesCounter++
        return if (shouldThrowError) Result.failure(HeadlinesException.DbOperationFailure) else Result.success(Unit)
    }

    override suspend fun fetchArticles(): Result<List<Article>> {
        fetchArticlesCounter++
        return if (shouldThrowError) {
            Result.failure(HeadlinesException.DbOperationFailure)
        } else {
            Result.success(emptyList())
        }
    }

    override suspend fun favouriteArticle(article: Article): Result<Unit> {
        // Not under test here, mirrors the iOS spy's TODO.
        return Result.success(Unit)
    }

    override suspend fun fetchFavourites(): Result<List<Article>> {
        // Not under test here, mirrors the iOS spy's TODO.
        return Result.success(emptyList())
    }
}
