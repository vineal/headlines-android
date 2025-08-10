import UIKit
import RealmSwift

class Article: Object {
    @objc dynamic var headline = ""
    @objc dynamic var body = ""
    @objc dynamic var published: Date?
    @objc private dynamic var rawImageURL: String?
    var imageURL: URL? {
        guard let rawImageURL = rawImageURL else { return nil }
        return URL(string: rawImageURL)
    }

    static let formatter = ISO8601DateFormatter()
    
    static var all: [Article] {
        let realm = try! Realm()
        let all = realm.objects(Article.self)
        return Array(all)
    }
    
    convenience init?(dictionary: [String : Any]) {
        self.init()
        
        headline = dictionary["webTitle"] as? String ?? ""
        
        if let publicationDate = dictionary["webPublicationDate"] as? String {
            published = Self.formatter.date(from: publicationDate)
        }
        
        guard let fields = dictionary["fields"] as? [String: String] else { return }
        body = fields["body"]?.strippingTags ?? ""
        rawImageURL = fields["main"]?.url?.absoluteString
    }
    
    convenience init?(
        headline: String,
        body: String,
        published: Date?,
        rawImageURL: String?,
    ) {
        self.init()
        self.headline = headline
        self.body = body
        self.published = published
        self.rawImageURL = rawImageURL
    }
}
