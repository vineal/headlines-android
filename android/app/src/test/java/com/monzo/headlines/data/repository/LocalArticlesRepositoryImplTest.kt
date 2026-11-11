package com.monzo.headlines.data.repository

import com.google.common.truth.Truth.assertThat
import com.monzo.headlines.domain.model.HeadlinesException
import com.monzo.headlines.domain.repository.LocalArticlesRepository
import com.monzo.headlines.fakes.LocalArticlesServiceSpy
import com.monzo.headlines.fakes.TestFixtures
import kotlinx.coroutines.test.runTest
import org.junit.Test

class LocalArticlesRepositoryImplTest {

    @Test
    fun `when service fails, returns db operation error`() = runTest {
        val serviceSpy = LocalArticlesServiceSpy(shouldThrowError = true)
        val sut: LocalArticlesRepository = LocalArticlesRepositoryImpl(serviceSpy)

        val result = sut.saveArticles(TestFixtures.articles)

        assertThat(result.isFailure).isTrue()
        assertThat(result.exceptionOrNull()).isEqualTo(HeadlinesException.DbOperationFailure)
        assertThat(result.exceptionOrNull()?.message).isEqualTo(
            "Oh oh! Seems like something is not right. Update your app or try reaching out to support."
        )
    }

    @Test
    fun `when service succeeds, saves articles`() = runTest {
        val serviceSpy = LocalArticlesServiceSpy(shouldThrowError = false)
        val sut: LocalArticlesRepository = LocalArticlesRepositoryImpl(serviceSpy)

        val result = sut.saveArticles(TestFixtures.articles)

        assertThat(result.isSuccess).isTrue()
        assertThat(serviceSpy.saveArticlesCounter).isEqualTo(1)
    }
}
