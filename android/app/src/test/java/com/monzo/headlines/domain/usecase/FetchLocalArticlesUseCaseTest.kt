package com.monzo.headlines.domain.usecase

import com.google.common.truth.Truth.assertThat
import com.monzo.headlines.domain.model.HeadlinesException
import com.monzo.headlines.fakes.LocalArticlesRepositorySpy
import kotlinx.coroutines.test.runTest
import org.junit.Test

class FetchLocalArticlesUseCaseTest {

    @Test
    fun `when repository fails, returns db operation error`() = runTest {
        val repositorySpy = LocalArticlesRepositorySpy(shouldThrowError = true)
        val sut: FetchLocalArticlesUseCase = FetchLocalArticlesUseCaseImpl(repositorySpy)

        val result = sut.fetchArticles()

        assertThat(result.isFailure).isTrue()
        assertThat(result.exceptionOrNull()).isEqualTo(HeadlinesException.DbOperationFailure)
        assertThat(result.exceptionOrNull()?.message).isEqualTo(
            "Oh oh! Seems like something is not right. Update your app or try reaching out to support."
        )
    }

    @Test
    fun `when repository succeeds, returns articles`() = runTest {
        val repositorySpy = LocalArticlesRepositorySpy(shouldThrowError = false)
        val sut: FetchLocalArticlesUseCase = FetchLocalArticlesUseCaseImpl(repositorySpy)

        val result = sut.fetchArticles()

        assertThat(result.isSuccess).isTrue()
        assertThat(repositorySpy.fetchArticlesCounter).isEqualTo(1)
    }
}
