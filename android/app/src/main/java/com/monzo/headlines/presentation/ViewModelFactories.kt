package com.monzo.headlines.presentation

import androidx.compose.runtime.Composable
import androidx.compose.ui.platform.LocalContext
import androidx.lifecycle.viewmodel.initializer
import androidx.lifecycle.viewmodel.viewModelFactory
import com.monzo.headlines.HeadlinesApplication
import com.monzo.headlines.presentation.articlepager.ArticlePagerViewModel
import com.monzo.headlines.presentation.favourites.FavouritesViewModel

@Composable
fun rememberArticlePagerViewModelFactory() = run {
    val container = (LocalContext.current.applicationContext as HeadlinesApplication).container
    viewModelFactory {
        initializer {
            ArticlePagerViewModel(
                fetchRemoteArticlesUseCase = container.fetchRemoteArticlesUseCase,
                saveArticlesInDbUseCase = container.saveArticlesInDbUseCase,
                fetchLocalArticlesUseCase = container.fetchLocalArticlesUseCase,
                favouriteArticleUseCase = container.favouriteArticleUseCase
            )
        }
    }
}

@Composable
fun rememberFavouritesViewModelFactory() = run {
    val container = (LocalContext.current.applicationContext as HeadlinesApplication).container
    viewModelFactory {
        initializer {
            FavouritesViewModel(fetchFavouritesUseCase = container.fetchFavouritesUseCase)
        }
    }
}
