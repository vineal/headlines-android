import UIKit
import SDWebImage

class SubtitleCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

final class FavouritesViewController: UITableViewController {
    var articleSelected: ((IndexPath) -> Void)?
    let articles = Article.all
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        navigationItem.searchController = searchController
        tableView.register(SubtitleCell.self, forCellReuseIdentifier: "cell")
        
        Article.fetchArticles { _, _ in }
    }
    
    @objc func doneButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}

extension FavouritesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // TODO: Perform search
    }
}

extension FavouritesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let article = articles[indexPath.row]
        cell.textLabel?.text = article.headline
        cell.detailTextLabel?.text = article.published?.description
        cell.imageView?.sd_setImage(with: article.imageURL)
        
        return cell
    }
}
