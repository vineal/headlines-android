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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "Body"
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
    
    let article: Article?
    
    init(article: Article? =  nil) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        [imageView, headlineLabel, bodyLabel, addToFavouritesButton, goToFavouritesButton].forEach {
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            headlineLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            headlineLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headlineLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            bodyLabel.topAnchor.constraint(equalTo: headlineLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            addToFavouritesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addToFavouritesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            goToFavouritesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            goToFavouritesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
        updatedUI()
    }
    
    private func updatedUI() {
        guard let article else { return }
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
        // TODO: Handle favouriting
    }
}
