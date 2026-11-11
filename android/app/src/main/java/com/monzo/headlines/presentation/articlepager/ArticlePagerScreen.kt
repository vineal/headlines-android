package com.monzo.headlines.presentation.articlepager

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.BoxWithConstraints
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.pager.HorizontalPager
import androidx.compose.foundation.pager.rememberPagerState
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.outlined.FavoriteBorder
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.viewmodel.compose.viewModel
import coil.compose.AsyncImage
import com.monzo.headlines.domain.model.Article
import com.monzo.headlines.presentation.rememberArticlePagerViewModelFactory
import com.monzo.headlines.presentation.theme.FavouriteYellow

/**
 * Swipeable feed of headlines — the Compose equivalent of the iOS
 * `UIPageViewController`-backed `ArticlesPageViewController`.
 */
@Composable
fun ArticlePagerScreen(
    onGoToFavourites: () -> Unit,
    modifier: Modifier = Modifier
) {
    val viewModel: ArticlePagerViewModel = viewModel(factory = rememberArticlePagerViewModelFactory())
    val uiState by viewModel.uiState.collectAsState()

    Box(modifier = modifier.fillMaxSize()) {
        when {
            uiState.isLoading && uiState.articles.isEmpty() -> {
                CircularProgressIndicator(modifier = Modifier.align(Alignment.Center))
            }
            uiState.articles.isEmpty() -> {
                Text(
                    text = uiState.errorMessage ?: "No articles available",
                    modifier = Modifier.align(Alignment.Center).padding(24.dp),
                    textAlign = TextAlign.Center
                )
            }
            else -> {
                val pagerState = rememberPagerState(pageCount = { uiState.articles.size })
                HorizontalPager(state = pagerState, modifier = Modifier.fillMaxSize()) { page ->
                    ArticlePage(
                        article = uiState.articles[page],
                        onToggleFavourite = { viewModel.toggleFavourite(uiState.articles[page]) },
                        onGoToFavourites = onGoToFavourites
                    )
                }
            }
        }
    }
}

@Composable
private fun ArticlePage(
    article: Article,
    onToggleFavourite: () -> Unit,
    onGoToFavourites: () -> Unit
) {
    BoxWithConstraints(modifier = Modifier.fillMaxSize()) {
        Column(modifier = Modifier.fillMaxSize()) {
            Column(
                modifier = Modifier
                    .weight(1f)
                    .fillMaxWidth()
                    .verticalScroll(rememberScrollState())
            ) {
                Box(modifier = Modifier.fillMaxWidth().height(350.dp)) {
                    AsyncImage(
                        model = article.imageUrl,
                        contentDescription = article.headline,
                        modifier = Modifier.fillMaxSize().background(Color.LightGray),
                        contentScale = ContentScale.Crop
                    )
                    Text(
                        text = article.headline,
                        color = Color.White,
                        fontSize = 28.sp,
                        fontWeight = FontWeight.Bold,
                        modifier = Modifier
                            .align(Alignment.BottomStart)
                            .padding(horizontal = 16.dp, vertical = 16.dp)
                            .shadow(3.dp)
                    )
                }
                Text(
                    text = article.body,
                    modifier = Modifier.fillMaxWidth().padding(16.dp)
                )
            }
            Box(modifier = Modifier.fillMaxWidth().padding(16.dp)) {
                IconButton(onClick = onToggleFavourite, modifier = Modifier.align(Alignment.CenterStart)) {
                    val isFavourited = article.isFavourited ?: false
                    Icon(
                        imageVector = if (isFavourited) Icons.Filled.Favorite else Icons.Outlined.FavoriteBorder,
                        contentDescription = "Toggle favourite",
                        tint = FavouriteYellow,
                        modifier = Modifier.size(28.dp)
                    )
                }
                TextButton(onClick = onGoToFavourites, modifier = Modifier.align(Alignment.CenterEnd)) {
                    Text("Favourites")
                }
            }
        }
    }
}
