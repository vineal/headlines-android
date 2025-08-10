import UIKit

class Article {
    var headline = ""
    var body = ""
    var published: Date?
    var rawImageURL: String?
    var imageURL: URL? {
        guard let rawImageURL = rawImageURL else { return nil }
        return URL(string: rawImageURL)
    }
    
    init(
        headline: String,
        body: String,
        published: Date?,
        rawImageURL: String?,
    ) {
        self.headline = headline
        self.body = body
        self.published = published
        self.rawImageURL = rawImageURL
    }
}
