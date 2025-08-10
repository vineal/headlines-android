import UIKit

class Article {
    var id = ""
    var headline = ""
    var body = ""
    var published: Date?
    var rawImageURL: String?
    var imageURL: URL? {
        guard let rawImageURL = rawImageURL else { return nil }
        return URL(string: rawImageURL)
    }
    
    init(
        id: String,
        headline: String,
        body: String,
        published: Date?,
        rawImageURL: String?,
    ) {
        self.id = id
        self.headline = headline
        self.body = body
        self.published = published
        self.rawImageURL = rawImageURL
    }
}
