package com.monzo.headlines.fakes

import com.monzo.headlines.data.remote.RemoteArticleDto
import com.monzo.headlines.data.remote.RemoteArticlesService
import com.monzo.headlines.domain.model.HeadlinesException

class RemoteArticlesServiceSpy(
    private val completeWithError: Boolean
) : RemoteArticlesService {
    var fetchArticlesCalledCount = 0

    override suspend fun fetchArticles(): List<RemoteArticleDto> {
        fetchArticlesCalledCount++
        if (completeWithError) throw HeadlinesException.RemoteFetchFailed
        return emptyList()
    }
}
