package com.monzo.headlines.data.repository

import com.monzo.headlines.data.mapper.toDomain
import com.monzo.headlines.data.remote.RemoteArticlesService
import com.monzo.headlines.domain.model.Article
import com.monzo.headlines.domain.repository.RemoteArticlesRepository

class RemoteArticlesRepositoryImpl(
    private val service: RemoteArticlesService
) : RemoteArticlesRepository {

    override suspend fun fetchArticles(): Result<List<Article>> = runCatching {
        service.fetchArticles().map { it.toDomain() }
    }
}
