package com.monzo.headlines.presentation.favourites

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Close
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.unit.dp
import androidx.lifecycle.viewmodel.compose.viewModel
import coil.compose.AsyncImage
import com.monzo.headlines.domain.model.Article
import com.monzo.headlines.presentation.rememberFavouritesViewModelFactory
import java.text.DateFormat
import java.util.Date

/**
 * Compose equivalent of the iOS `FavouritesViewController` (a `UITableViewController`
 * with an unwired `UISearchController`) — here the search box actually filters the list.
 */
@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun FavouritesScreen(
    onDone: () -> Unit,
    modifier: Modifier = Modifier
) {
    val viewModel: FavouritesViewModel = viewModel(factory = rememberFavouritesViewModelFactory())
    val uiState by viewModel.uiState.collectAsState()

    Scaffold(
        modifier = modifier,
        topBar = {
            TopAppBar(
                title = { Text("Favourites") },
                actions = {
                    IconButton(onClick = onDone) {
                        Icon(Icons.Filled.Close, contentDescription = "Done")
                    }
                }
            )
        }
    ) { contentPadding ->
        Column(modifier = Modifier.fillMaxSize().padding(contentPadding)) {
            OutlinedTextField(
                value = uiState.query,
                onValueChange = viewModel::onQueryChanged,
                modifier = Modifier.fillMaxWidth().padding(16.dp),
                placeholder = { Text("Search") },
                leadingIcon = { Icon(Icons.Filled.Search, contentDescription = null) },
                singleLine = true
            )

            when {
                uiState.isLoading && uiState.articles.isEmpty() -> {
                    CircularProgressIndicator(modifier = Modifier.padding(16.dp))
                }
                uiState.filteredArticles.isEmpty() -> {
                    Text("No favourites yet", modifier = Modifier.padding(16.dp))
                }
                else -> {
                    LazyColumn {
                        items(uiState.filteredArticles, key = { it.id }) { article ->
                            FavouriteRow(article)
                        }
                    }
                }
            }
        }
    }
}

@Composable
private fun FavouriteRow(article: Article) {
    Row(
        modifier = Modifier.fillMaxWidth().padding(horizontal = 16.dp, vertical = 8.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        AsyncImage(
            model = article.imageUrl,
            contentDescription = article.headline,
            modifier = Modifier.size(56.dp),
            contentScale = ContentScale.Crop
        )
        Column(modifier = Modifier.padding(start = 12.dp)) {
            Text(text = article.headline)
            article.published?.let {
                Text(text = DateFormat.getDateInstance().format(Date(it)))
            }
        }
    }
}
