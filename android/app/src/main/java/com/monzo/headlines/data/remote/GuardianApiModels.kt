package com.monzo.headlines.data.remote

data class GuardianSearchResponse(
    val response: GuardianResponseBody?
)

data class GuardianResponseBody(
    val results: List<GuardianResultDto>?
)

data class GuardianResultDto(
    val id: String?,
    val webTitle: String?,
    val webPublicationDate: String?,
    val fields: GuardianFieldsDto?
)

data class GuardianFieldsDto(
    val body: String?,
    val main: String?
)
