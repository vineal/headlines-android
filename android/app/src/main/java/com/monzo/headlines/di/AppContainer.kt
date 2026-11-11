package com.monzo.headlines.di

import android.content.Context
import androidx.room.Room
import com.monzo.headlines.BuildConfig
import com.monzo.headlines.data.local.AppDatabase
import com.monzo.headlines.data.local.LocalArticlesService
import com.monzo.headlines.data.local.RoomLocalArticlesService
import com.monzo.headlines.data.remote.GuardianApi
import com.monzo.headlines.data.remote.GuardianRemoteArticlesService
import com.monzo.headlines.data.remote.RemoteArticlesService
import com.monzo.headlines.data.repository.LocalArticlesRepositoryImpl
import com.monzo.headlines.data.repository.RemoteArticlesRepositoryImpl
import com.monzo.headlines.domain.repository.LocalArticlesRepository
import com.monzo.headlines.domain.repository.RemoteArticlesRepository
import com.monzo.headlines.domain.usecase.FavouriteArticleUseCase
import com.monzo.headlines.domain.usecase.FavouriteArticleUseCaseImpl
import com.monzo.headlines.domain.usecase.FetchFavouritesUseCase
import com.monzo.headlines.domain.usecase.FetchFavouritesUseCaseImpl
import com.monzo.headlines.domain.usecase.FetchLocalArticlesUseCase
import com.monzo.headlines.domain.usecase.FetchLocalArticlesUseCaseImpl
import com.monzo.headlines.domain.usecase.FetchRemoteArticlesUseCase
import com.monzo.headlines.domain.usecase.FetchRemoteArticlesUseCaseImpl
import com.monzo.headlines.domain.usecase.SaveArticlesInDbUseCase
import com.monzo.headlines.domain.usecase.SaveArticlesInDbUseCaseImpl
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

/**
 * Lightweight, hand-rolled DI container — mirrors the default-argument constructor
 * injection used throughout the iOS codebase rather than pulling in a DI framework.
 */
class AppContainer(context: Context) {

    private val database: AppDatabase = Room.databaseBuilder(
        context,
        AppDatabase::class.java,
        "headlines.db"
    ).build()

    private val okHttpClient: OkHttpClient = OkHttpClient.Builder()
        .addInterceptor(HttpLoggingInterceptor().apply { level = HttpLoggingInterceptor.Level.BASIC })
        .build()

    private val guardianApi: GuardianApi = Retrofit.Builder()
        .baseUrl("https://content.guardianapis.com/")
        .client(okHttpClient)
        .addConverterFactory(GsonConverterFactory.create())
        .build()
        .create(GuardianApi::class.java)

    private val localArticlesService: LocalArticlesService = RoomLocalArticlesService(database.articleDao())
    private val remoteArticlesService: RemoteArticlesService =
        GuardianRemoteArticlesService(guardianApi, BuildConfig.GUARDIAN_API_KEY)

    private val localArticlesRepository: LocalArticlesRepository = LocalArticlesRepositoryImpl(localArticlesService)
    private val remoteArticlesRepository: RemoteArticlesRepository = RemoteArticlesRepositoryImpl(remoteArticlesService)

    val fetchRemoteArticlesUseCase: FetchRemoteArticlesUseCase = FetchRemoteArticlesUseCaseImpl(remoteArticlesRepository)
    val saveArticlesInDbUseCase: SaveArticlesInDbUseCase = SaveArticlesInDbUseCaseImpl(localArticlesRepository)
    val fetchLocalArticlesUseCase: FetchLocalArticlesUseCase = FetchLocalArticlesUseCaseImpl(localArticlesRepository)
    val favouriteArticleUseCase: FavouriteArticleUseCase = FavouriteArticleUseCaseImpl(localArticlesRepository)
    val fetchFavouritesUseCase: FetchFavouritesUseCase = FetchFavouritesUseCaseImpl(localArticlesRepository)
}
