package com.monzo.headlines.data.remote

import retrofit2.http.GET
import retrofit2.http.Query

interface GuardianApi {
    @GET("search")
    suspend fun search(
        @Query("q") query: String = "fintech",
        @Query("show-fields") showFields: String = "main,body",
        @Query("api-key") apiKey: String
    ): GuardianSearchResponse
}
