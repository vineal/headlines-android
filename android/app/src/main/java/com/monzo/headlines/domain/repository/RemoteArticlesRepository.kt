package com.monzo.headlines.domain.repository

import com.monzo.headlines.domain.model.Article

interface RemoteArticlesRepository {
    suspend fun fetchArticles(): Result<List<Article>>
}
