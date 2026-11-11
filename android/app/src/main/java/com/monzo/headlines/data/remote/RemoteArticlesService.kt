package com.monzo.headlines.data.remote

import com.monzo.headlines.domain.model.HeadlinesException
import java.io.IOException

interface RemoteArticlesService {
    suspend fun fetchArticles(): List<RemoteArticleDto>
}

class GuardianRemoteArticlesService(
    private val api: GuardianApi,
    private val apiKey: String
) : RemoteArticlesService {

    override suspend fun fetchArticles(): List<RemoteArticleDto> {
        val results = try {
            api.search(apiKey = apiKey).response?.results
        } catch (error: IOException) {
            throw HeadlinesException.RemoteFetchFailed
        } catch (error: retrofit2.HttpException) {
            throw HeadlinesException.RemoteFetchFailed
        }
        return results?.map { RemoteArticleDto.from(it) } ?: throw HeadlinesException.RemoteFetchFailed
    }
}
