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
    @Persisted var headline = ""
    @Persisted dynamic var body = ""
    @Persisted dynamic var published: Date?
    @Persisted private dynamic var rawImageURL: String?
    var imageURL: URL? {
        guard let rawImageURL = rawImageURL else { return nil }
        return URL(string: rawImageURL)
    }
    convenience init?(
        headline: String,
        body: String,
        published: Date?,
        rawImageURL: String?
    ) {
        self.init()
        self.headline = headline
        self.body = body
        self.published = published
        self.rawImageURL = rawImageURL
    }
}
