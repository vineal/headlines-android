package com.monzo.headlines.domain.repository

import com.monzo.headlines.domain.model.Article

interface LocalArticlesRepository {
    suspend fun saveArticles(articles: List<Article>): Result<Unit>
    suspend fun fetchArticles(): Result<List<Article>>
    suspend fun favouriteArticle(article: Article): Result<Unit>
    suspend fun fetchFavourites(): Result<List<Article>>
}
