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
    let fetchLocalArticlesUseCase: FetchLocalArticlesUseCaseProtocol
    var articles = [Article]()
    
    init(
        articleSelected: ((IndexPath) -> Void)? = nil,
        fetchLocalArticlesUseCase: FetchLocalArticlesUseCaseProtocol = FetchLocalArticlesUseCase()
    ) {
        self.articleSelected = articleSelected
        self.fetchLocalArticlesUseCase = fetchLocalArticlesUseCase
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.delegate = self
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: Replace with viewmodel and usecase to fetch only favourites
        fetchLocalArticlesUseCase.fetchArticles { [weak self] articles, error in
            // Handle error
            self?.articles = articles ?? []
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        navigationItem.searchController = searchController
        tableView.register(SubtitleCell.self, forCellReuseIdentifier: "cell")
        
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
