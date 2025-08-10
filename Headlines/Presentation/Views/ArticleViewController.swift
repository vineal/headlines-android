import UIKit
import SDWebImage

final class ArticleViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var headlineLabel: UILabel = {
        let label = UILabel()
        label.text = "Headline"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textColor = .white
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 3
        label.layer.shadowOpacity = 0.6
        label.layer.shadowOffset = .zero
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "Body"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addToFavouritesButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .systemYellow
        button.setImage(UIImage(named: "favourite-off"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(addToFavouritesButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var goToFavouritesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Favourites", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToFavouritesButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var article: Article
    let viewModel: ArticleViewModel
    
    init(article: Article, viewModel: ArticleViewModel =  ArticleViewModel()) {
        self.article = article
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        updateUI()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        [scrollView, addToFavouritesButton, goToFavouritesButton].forEach {
            view.addSubview($0)
        }
        
        scrollView.addSubview(contentView)

        [imageView, headlineLabel, bodyLabel].forEach {
            contentView.addSubview($0)
        }
        
        let favouriteButtonImage = (article.isFavourited ?? false) ? UIImage(named: "favourite-on") : UIImage(named: "favourite-off")
        addToFavouritesButton.setImage(favouriteButtonImage, for: .normal)
        
        NSLayoutConstraint.activate([
            // Set main scrollview constraints
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: addToFavouritesButton.topAnchor, constant: -16),
            // Set Constraints for the content view inside scroll view
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            // Set constraints for contents inside content view
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 350),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            headlineLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -16),
            headlineLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16),
            headlineLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -16),
            
            bodyLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            addToFavouritesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addToFavouritesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            goToFavouritesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            goToFavouritesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    private func updateUI() {
        headlineLabel.text = article.headline
        bodyLabel.text = article.body
        imageView.sd_setImage(with: article.imageURL)
    }

    @objc private func goToFavouritesButtonPressed() {
        let vc = FavouritesViewController()
        let nc = UINavigationController(rootViewController: vc)
        present(nc, animated: true, completion: nil)
    }
    
    @objc private func addToFavouritesButtonPressed() {
        if article.isFavourited != nil {
            article.isFavourited?.toggle()
        } else {
            article.isFavourited = true
        }
        let favouriteButtonImage = (article.isFavourited ?? false) ? UIImage(named: "favourite-on") : UIImage(named: "favourite-off")
        addToFavouritesButton.setImage(favouriteButtonImage, for: .normal)
        
        viewModel.favouriteArticle(article: article) { [weak self] error in
           // TODO: Handle error
        }
    }
}
