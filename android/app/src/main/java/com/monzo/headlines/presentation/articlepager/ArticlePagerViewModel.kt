package com.monzo.headlines.presentation.articlepager

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.monzo.headlines.domain.model.Article
import com.monzo.headlines.domain.usecase.FavouriteArticleUseCase
import com.monzo.headlines.domain.usecase.FetchLocalArticlesUseCase
import com.monzo.headlines.domain.usecase.FetchRemoteArticlesUseCase
import com.monzo.headlines.domain.usecase.SaveArticlesInDbUseCase
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch

data class ArticlePagerUiState(
    val articles: List<Article> = emptyList(),
    val isLoading: Boolean = true,
    val errorMessage: String? = null
)

/**
 * Combines what the iOS app splits across `ArticlePageViewModel` (fetch/save/reload)
 * and `ArticleViewModel` (favourite toggle) — Compose screens read a single state
 * stream instead of a per-page view controller hierarchy.
 */
class ArticlePagerViewModel(
    private val fetchRemoteArticlesUseCase: FetchRemoteArticlesUseCase,
    private val saveArticlesInDbUseCase: SaveArticlesInDbUseCase,
    private val fetchLocalArticlesUseCase: FetchLocalArticlesUseCase,
    private val favouriteArticleUseCase: FavouriteArticleUseCase
) : ViewModel() {

    private val _uiState = MutableStateFlow(ArticlePagerUiState())
    val uiState: StateFlow<ArticlePagerUiState> = _uiState.asStateFlow()

    init {
        fetchArticles()
    }

    fun fetchArticles() {
        viewModelScope.launch {
            _uiState.update { it.copy(isLoading = true, errorMessage = null) }
            val remoteResult = fetchRemoteArticlesUseCase.fetchArticles()
            remoteResult.onSuccess { articles -> saveArticlesInDbUseCase.saveArticles(articles) }
            reload(remoteError = remoteResult.exceptionOrNull())
        }
    }

    /**
     * [remoteError] is only surfaced when the local cache is also empty — a failed
     * refresh with a non-empty cache should keep showing what's already there.
     */
    private suspend fun reload(remoteError: Throwable? = null) {
        fetchLocalArticlesUseCase.fetchArticles()
            .onSuccess { articles ->
                _uiState.update {
                    it.copy(
                        articles = articles,
                        isLoading = false,
                        errorMessage = if (articles.isEmpty()) remoteError?.message else null
                    )
                }
            }
            .onFailure { error ->
                _uiState.update { it.copy(isLoading = false, errorMessage = error.message) }
            }
    }

    fun toggleFavourite(article: Article) {
        val updated = article.copy(isFavourited = !(article.isFavourited ?: false))
        _uiState.update { state ->
            state.copy(articles = state.articles.map { if (it.id == updated.id) updated else it })
        }
        viewModelScope.launch {
            favouriteArticleUseCase.favouriteArticle(updated)
        }
    }
}
