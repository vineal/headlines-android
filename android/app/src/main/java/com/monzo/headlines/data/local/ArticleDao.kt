package com.monzo.headlines.data.local

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Transaction

@Dao
interface ArticleDao {

    @Query("SELECT * FROM articles")
    suspend fun getAll(): List<ArticleEntity>

    @Query("SELECT * FROM articles WHERE isFavourited = 1")
    suspend fun getFavourites(): List<ArticleEntity>

    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insert(entity: ArticleEntity)

    @Query(
        """
        UPDATE articles
        SET headline = :headline, body = :body, published = :published, rawImageUrl = :rawImageUrl
        WHERE id = :id
        """
    )
    suspend fun updateContent(
        id: String,
        headline: String,
        body: String,
        published: Long?,
        rawImageUrl: String?
    ): Int

    @Query("UPDATE articles SET isFavourited = :isFavourited WHERE id = :id")
    suspend fun updateFavourite(id: String, isFavourited: Boolean): Int

    @Query("DELETE FROM articles WHERE id NOT IN (:keepIds)")
    suspend fun deleteNotIn(keepIds: List<String>)

    /**
     * Content-only upsert: updates headline/body/published/image for an existing row
     * without touching `isFavourited`, or inserts a fresh row when none exists yet.
     * Mirrors the iOS Realm sync, which omits `isFavourited` from its partial-update
     * dictionary so a remote refresh never clobbers a locally saved favourite.
     */
    @Transaction
    suspend fun upsertContent(entity: ArticleEntity) {
        val rowsUpdated = updateContent(
            id = entity.id,
            headline = entity.headline,
            body = entity.body,
            published = entity.published,
            rawImageUrl = entity.rawImageUrl
        )
        if (rowsUpdated == 0) {
            insert(entity)
        }
    }

    @Transaction
    suspend fun syncArticles(entities: List<ArticleEntity>) {
        entities.forEach { upsertContent(it) }
        deleteNotIn(entities.map { it.id })
    }

    /**
     * Mirrors the iOS service: toggling a favourite only ever touches the
     * `isFavourited` column, creating a sparse row (id + flag only) if the
     * article hasn't been synced locally yet.
     */
    @Transaction
    suspend fun setFavourite(id: String, isFavourited: Boolean) {
        val rowsUpdated = updateFavourite(id, isFavourited)
        if (rowsUpdated == 0) {
            insert(ArticleEntity(id = id, isFavourited = isFavourited))
        }
    }
}
