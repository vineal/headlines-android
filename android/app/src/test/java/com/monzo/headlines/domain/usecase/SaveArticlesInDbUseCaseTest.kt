package com.monzo.headlines.domain.usecase

import com.google.common.truth.Truth.assertThat
import com.monzo.headlines.domain.model.HeadlinesException
import com.monzo.headlines.fakes.LocalArticlesRepositorySpy
import com.monzo.headlines.fakes.TestFixtures
import kotlinx.coroutines.test.runTest
import org.junit.Test

class SaveArticlesInDbUseCaseTest {

    @Test
    fun `when repository fails, returns db operation error`() = runTest {
        val repositorySpy = LocalArticlesRepositorySpy(shouldThrowError = true)
        val sut: SaveArticlesInDbUseCase = SaveArticlesInDbUseCaseImpl(repositorySpy)

        val result = sut.saveArticles(TestFixtures.articles)

        assertThat(result.isFailure).isTrue()
        assertThat(result.exceptionOrNull()).isEqualTo(HeadlinesException.DbOperationFailure)
        assertThat(result.exceptionOrNull()?.message).isEqualTo(
            "Oh oh! Seems like something is not right. Update your app or try reaching out to support."
        )
    }

    @Test
    fun `when repository succeeds, saves articles`() = runTest {
        val repositorySpy = LocalArticlesRepositorySpy(shouldThrowError = false)
        val sut: SaveArticlesInDbUseCase = SaveArticlesInDbUseCaseImpl(repositorySpy)

        val result = sut.saveArticles(TestFixtures.articles)

        assertThat(result.isSuccess).isTrue()
        assertThat(repositorySpy.saveArticlesCounter).isEqualTo(1)
    }
}
