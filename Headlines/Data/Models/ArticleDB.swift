//
//  ArticleDB.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

import Foundation
import RealmSwift

class ArticleDB: Object {
    @Persisted(primaryKey: true) var id = ""
    @Persisted var headline = ""
    @Persisted var body = ""
    @Persisted var published: Date?
    @Persisted var rawImageURL: String?
    @Persisted var isFavourited: Bool?

    var imageURL: URL? {
        guard let rawImageURL = rawImageURL else { return nil }
        return URL(string: rawImageURL)
    }
    
    convenience init?(
        id: String,
        headline: String,
        body: String,
        published: Date?,
        rawImageURL: String?,
        isFavourited: Bool?
    ) {
        self.init()
        self.id = id
        self.headline = headline
        self.body = body
        self.published = published
        self.rawImageURL = rawImageURL
        self.isFavourited = isFavourited
    }
}
