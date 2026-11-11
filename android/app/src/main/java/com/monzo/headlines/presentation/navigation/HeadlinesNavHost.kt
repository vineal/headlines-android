package com.monzo.headlines.presentation.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.NavHostController
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.monzo.headlines.presentation.articlepager.ArticlePagerScreen
import com.monzo.headlines.presentation.favourites.FavouritesScreen

private object Routes {
    const val PAGER = "pager"
    const val FAVOURITES = "favourites"
}

@Composable
fun HeadlinesNavHost(navController: NavHostController = rememberNavController()) {
    NavHost(navController = navController, startDestination = Routes.PAGER) {
        composable(Routes.PAGER) {
            ArticlePagerScreen(onGoToFavourites = { navController.navigate(Routes.FAVOURITES) })
        }
        composable(Routes.FAVOURITES) {
            FavouritesScreen(onDone = { navController.popBackStack() })
        }
    }
}
