package com.monzo.headlines

import android.app.Application
import com.monzo.headlines.di.AppContainer

class HeadlinesApplication : Application() {
    lateinit var container: AppContainer

    override fun onCreate() {
        super.onCreate()
        container = AppContainer(this)
    }
}
