package com.monzo.headlines.domain.model

/**
 * Mirrors the iOS `CustomErrors` enum: a small, fixed set of user-facing error
 * messages rather than exposing raw network/DB exceptions to the UI layer.
 */
sealed class HeadlinesException(message: String) : Exception(message) {
    object RemoteFetchFailed : HeadlinesException(
        "Oh oh! Seems like something is not right. Check your internet connection or try again later."
    )

    object DbOperationFailure : HeadlinesException(
        "Oh oh! Seems like something is not right. Update your app or try reaching out to support."
    )
}
