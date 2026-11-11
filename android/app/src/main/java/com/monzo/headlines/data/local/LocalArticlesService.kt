package com.monzo.headlines.data.local

import com.monzo.headlines.domain.model.HeadlinesException

interface LocalArticlesService {
    suspend fun saveArticles(articles: List<ArticleEntity>)
    suspend fun fetchArticles(): List<ArticleEntity>
    suspend fun favouriteArticle(article: ArticleEntity?)
    suspend fun fetchFavourites(): List<ArticleEntity>
}

class RoomLocalArticlesService(
    private val dao: ArticleDao
) : LocalArticlesService {

    override suspend fun saveArticles(articles: List<ArticleEntity>) {
        try {
            dao.syncArticles(articles)
        } catch (error: Exception) {
            throw HeadlinesException.DbOperationFailure
        }
    }

    override suspend fun fetchArticles(): List<ArticleEntity> {
        return try {
            dao.getAll()
        } catch (error: Exception) {
            throw HeadlinesException.DbOperationFailure
        }
    }

    override suspend fun favouriteArticle(article: ArticleEntity?) {
        try {
            dao.setFavourite(
                id = article?.id ?: return,
                isFavourited = article.isFavourited ?: true
            )
        } catch (error: Exception) {
            throw HeadlinesException.DbOperationFailure
        }
    }

    override suspend fun fetchFavourites(): List<ArticleEntity> {
        return try {
            dao.getFavourites()
        } catch (error: Exception) {
            throw HeadlinesException.DbOperationFailure
        }
    }
}
