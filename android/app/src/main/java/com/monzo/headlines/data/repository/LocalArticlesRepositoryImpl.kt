package com.monzo.headlines.data.repository

import com.monzo.headlines.data.local.LocalArticlesService
import com.monzo.headlines.data.mapper.toDomain
import com.monzo.headlines.data.mapper.toEntity
import com.monzo.headlines.domain.model.Article
import com.monzo.headlines.domain.repository.LocalArticlesRepository

class LocalArticlesRepositoryImpl(
    private val service: LocalArticlesService
) : LocalArticlesRepository {

    override suspend fun saveArticles(articles: List<Article>): Result<Unit> = runCatching {
        service.saveArticles(articles.map { it.toEntity() })
    }

    override suspend fun fetchArticles(): Result<List<Article>> = runCatching {
        service.fetchArticles().map { it.toDomain() }
    }

    override suspend fun favouriteArticle(article: Article): Result<Unit> = runCatching {
        service.favouriteArticle(article.toEntity())
    }

    override suspend fun fetchFavourites(): Result<List<Article>> = runCatching {
        service.fetchFavourites().map { it.toDomain() }
    }
}
