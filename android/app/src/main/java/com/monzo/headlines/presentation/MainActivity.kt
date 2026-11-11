package com.monzo.headlines.presentation

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.Surface
import androidx.compose.ui.Modifier
import com.monzo.headlines.presentation.navigation.HeadlinesNavHost
import com.monzo.headlines.presentation.theme.HeadlinesTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            HeadlinesTheme {
                Surface(modifier = Modifier.fillMaxSize()) {
                    HeadlinesNavHost()
                }
            }
        }
    }
}
