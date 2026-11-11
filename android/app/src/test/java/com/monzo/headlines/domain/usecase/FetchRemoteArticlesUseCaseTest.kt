package com.monzo.headlines.domain.usecase

import com.google.common.truth.Truth.assertThat
import com.monzo.headlines.domain.model.HeadlinesException
import com.monzo.headlines.fakes.RemoteArticlesRepositorySpy
import kotlinx.coroutines.test.runTest
import org.junit.Test

class FetchRemoteArticlesUseCaseTest {

    @Test
    fun `when repository fails, returns remote fetch error`() = runTest {
        val repositorySpy = RemoteArticlesRepositorySpy(shouldReturnArticles = false)
        val sut: FetchRemoteArticlesUseCase = FetchRemoteArticlesUseCaseImpl(repositorySpy)

        val result = sut.fetchArticles()

        assertThat(result.isFailure).isTrue()
        assertThat(result.exceptionOrNull()).isEqualTo(HeadlinesException.RemoteFetchFailed)
        assertThat(result.exceptionOrNull()?.message).isEqualTo(
            "Oh oh! Seems like something is not right. Check your internet connection or try again later."
        )
    }

    @Test
    fun `when repository succeeds, returns articles`() = runTest {
        val repositorySpy = RemoteArticlesRepositorySpy(shouldReturnArticles = true)
        val sut: FetchRemoteArticlesUseCase = FetchRemoteArticlesUseCaseImpl(repositorySpy)

        val result = sut.fetchArticles()

        assertThat(result.isSuccess).isTrue()
        assertThat(repositorySpy.fetchArticlesCounter).isEqualTo(1)
    }
}
