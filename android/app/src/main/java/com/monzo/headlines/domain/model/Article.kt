package com.monzo.headlines.domain.model

/**
 * Domain representation of a Guardian headline. Immutable by design — screens hold
 * list state and replace entries via [copy] rather than mutating in place.
 */
data class Article(
    val id: String,
    val headline: String,
    val body: String,
    val published: Long?,
    val rawImageUrl: String?,
    val isFavourited: Boolean?
) {
    val imageUrl: String?
        get() = rawImageUrl
}
