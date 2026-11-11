package com.monzo.headlines.data.mapper

import com.monzo.headlines.data.local.ArticleEntity
import com.monzo.headlines.data.remote.RemoteArticleDto
import com.monzo.headlines.domain.model.Article

fun ArticleEntity.toDomain(): Article = Article(
    id = id,
    headline = headline,
    body = body,
    published = published,
    rawImageUrl = rawImageUrl,
    isFavourited = isFavourited
)

fun Article.toEntity(): ArticleEntity = ArticleEntity(
    id = id,
    headline = headline,
    body = body,
    published = published,
    rawImageUrl = rawImageUrl,
    isFavourited = isFavourited
)

fun RemoteArticleDto.toDomain(): Article = Article(
    id = id,
    headline = headline,
    body = body,
    published = published,
    rawImageUrl = rawImageUrl,
    isFavourited = null
)
