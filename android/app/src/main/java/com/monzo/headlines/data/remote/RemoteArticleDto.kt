package com.monzo.headlines.data.remote

import com.monzo.headlines.util.firstUrl
import com.monzo.headlines.util.strippingTags
import java.time.Instant
import java.time.format.DateTimeParseException

data class RemoteArticleDto(
    val id: String,
    val headline: String,
    val body: String,
    val published: Long?,
    val rawImageUrl: String?
) {
    companion object {
        fun from(dto: GuardianResultDto): RemoteArticleDto {
            val published = dto.webPublicationDate?.let {
                try {
                    Instant.parse(it).toEpochMilli()
                } catch (error: DateTimeParseException) {
                    null
                }
            }
            return RemoteArticleDto(
                id = dto.id.orEmpty(),
                headline = dto.webTitle.orEmpty(),
                body = dto.fields?.body?.strippingTags().orEmpty(),
                published = published,
                rawImageUrl = dto.fields?.main?.firstUrl()
            )
        }
    }
}
