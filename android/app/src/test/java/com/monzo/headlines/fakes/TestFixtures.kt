package com.monzo.headlines.fakes

import com.monzo.headlines.domain.model.Article

object TestFixtures {
    private const val FIXED_PUBLISHED = 1_640_995_200_000L

    val articles: List<Article> = listOf(
        Article(
            id = "1",
            headline = "Headline1",
            body = "Body1",
            published = FIXED_PUBLISHED,
            rawImageUrl = "URL",
            isFavourited = null
        )
    )
}
