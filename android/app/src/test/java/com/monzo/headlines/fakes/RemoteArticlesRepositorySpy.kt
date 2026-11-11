package com.monzo.headlines.fakes

import com.monzo.headlines.domain.model.Article
import com.monzo.headlines.domain.model.HeadlinesException
import com.monzo.headlines.domain.repository.RemoteArticlesRepository

class RemoteArticlesRepositorySpy(
    private val shouldReturnArticles: Boolean
) : RemoteArticlesRepository {
    var fetchArticlesCounter = 0

    override suspend fun fetchArticles(): Result<List<Article>> {
        fetchArticlesCounter++
        return if (shouldReturnArticles) {
            Result.success(emptyList())
        } else {
            Result.failure(HeadlinesException.RemoteFetchFailed)
        }
    }
}
