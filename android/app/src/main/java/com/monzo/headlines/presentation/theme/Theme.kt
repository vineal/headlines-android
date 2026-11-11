package com.monzo.headlines.presentation.theme

import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.darkColorScheme
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color

val FavouriteYellow = Color(0xFFFFCC00)

private val LightColors = lightColorScheme(
    primary = Color(0xFF1A1A1A),
    secondary = FavouriteYellow
)

private val DarkColors = darkColorScheme(
    primary = Color(0xFFEDEDED),
    secondary = FavouriteYellow
)

@Composable
fun HeadlinesTheme(
    darkTheme: Boolean = isSystemInDarkTheme(),
    content: @Composable () -> Unit
) {
    val colors = if (darkTheme) DarkColors else LightColors
    MaterialTheme(colorScheme = colors, content = content)
}
