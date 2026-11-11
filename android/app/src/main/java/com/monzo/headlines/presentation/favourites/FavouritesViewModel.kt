package com.monzo.headlines.presentation.favourites

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.monzo.headlines.domain.model.Article
import com.monzo.headlines.domain.usecase.FetchFavouritesUseCase
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch

data class FavouritesUiState(
    val articles: List<Article> = emptyList(),
    val query: String = "",
    val isLoading: Boolean = true,
    val errorMessage: String? = null
) {
    val filteredArticles: List<Article>
        get() = if (query.isBlank()) {
            articles
        } else {
            articles.filter { it.headline.contains(query, ignoreCase = true) }
        }
}

class FavouritesViewModel(
    private val fetchFavouritesUseCase: FetchFavouritesUseCase
) : ViewModel() {

    private val _uiState = MutableStateFlow(FavouritesUiState())
    val uiState: StateFlow<FavouritesUiState> = _uiState.asStateFlow()

    init {
        fetchFavourites()
    }

    fun fetchFavourites() {
        viewModelScope.launch {
            _uiState.update { it.copy(isLoading = true) }
            fetchFavouritesUseCase.fetchFavourites()
                .onSuccess { articles -> _uiState.update { it.copy(articles = articles, isLoading = false, errorMessage = null) } }
                .onFailure { error -> _uiState.update { it.copy(isLoading = false, errorMessage = error.message) } }
        }
    }

    fun onQueryChanged(query: String) {
        _uiState.update { it.copy(query = query) }
    }
}
