package com.monzo.headlines.fakes

import com.monzo.headlines.data.local.ArticleEntity
import com.monzo.headlines.data.local.LocalArticlesService
import com.monzo.headlines.domain.model.HeadlinesException

class LocalArticlesServiceSpy(
    private val shouldThrowError: Boolean
) : LocalArticlesService {
    var saveArticlesCounter = 0

    override suspend fun saveArticles(articles: List<ArticleEntity>) {
        saveArticlesCounter++
        if (shouldThrowError) throw HeadlinesException.DbOperationFailure
    }

    override suspend fun fetchArticles(): List<ArticleEntity> {
        // Not under test here, mirrors the iOS spy's TODO.
        return emptyList()
    }

    override suspend fun favouriteArticle(article: ArticleEntity?) {
        // Not under test here, mirrors the iOS spy's TODO.
    }

    override suspend fun fetchFavourites(): List<ArticleEntity> {
        // Not under test here, mirrors the iOS spy's TODO.
        return emptyList()
    }
}
