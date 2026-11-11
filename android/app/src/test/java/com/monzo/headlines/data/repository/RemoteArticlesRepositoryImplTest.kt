package com.monzo.headlines.data.repository

import com.google.common.truth.Truth.assertThat
import com.monzo.headlines.domain.model.HeadlinesException
import com.monzo.headlines.domain.repository.RemoteArticlesRepository
import com.monzo.headlines.fakes.RemoteArticlesServiceSpy
import kotlinx.coroutines.test.runTest
import org.junit.Test

class RemoteArticlesRepositoryImplTest {

    @Test
    fun `when service fails, returns remote fetch error`() = runTest {
        val serviceSpy = RemoteArticlesServiceSpy(completeWithError = true)
        val sut: RemoteArticlesRepository = RemoteArticlesRepositoryImpl(serviceSpy)

        val result = sut.fetchArticles()

        assertThat(result.isFailure).isTrue()
        assertThat(result.exceptionOrNull()).isEqualTo(HeadlinesException.RemoteFetchFailed)
        assertThat(result.exceptionOrNull()?.message).isEqualTo(
            "Oh oh! Seems like something is not right. Check your internet connection or try again later."
        )
    }

    @Test
    fun `when service succeeds, returns articles`() = runTest {
        val serviceSpy = RemoteArticlesServiceSpy(completeWithError = false)
        val sut: RemoteArticlesRepository = RemoteArticlesRepositoryImpl(serviceSpy)

        val result = sut.fetchArticles()

        assertThat(result.isSuccess).isTrue()
        assertThat(serviceSpy.fetchArticlesCalledCount).isEqualTo(1)
    }
}
