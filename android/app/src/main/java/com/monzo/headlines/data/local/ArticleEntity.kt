package com.monzo.headlines.data.local

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "articles")
data class ArticleEntity(
    @PrimaryKey val id: String,
    val headline: String = "",
    val body: String = "",
    val published: Long? = null,
    val rawImageUrl: String? = null,
    val isFavourited: Boolean? = null
)
