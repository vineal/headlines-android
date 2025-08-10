//
//  ArticlePageViewController.swift
//  Headlines
//
//  Created by Vineal Varghese on 10/08/2025.
//  Copyright © 2025 Example. All rights reserved.
//

import UIKit

class ArticlesPageViewController: UIPageViewController, UIPageViewControllerDelegate {
    
    let viewModel: ArticlePageViewModel = ArticlePageViewModel()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate   = self
        viewModel.fetchArticles()
        viewModel.onArticlesChanged = { [weak self] article, _ in
            // TODO: Handle Errors
            if let firstVC = self?.viewModel.articlesVCs?.first {
                self?.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            }
        }
    }
}

extension ArticlesPageViewController: UIPageViewControllerDataSource
{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewModel.articlesVCs?.firstIndex(
            of: viewController as! ArticleViewController
        ) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else { return viewModel.articlesVCs?.last }
        
        guard viewModel.articlesVCs?.count ?? 0 > previousIndex else { return nil }
        
        return viewModel.articlesVCs?[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?
    {
        guard let viewControllerIndex = viewModel.articlesVCs?.firstIndex(of: viewController as! ArticleViewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < viewModel.articlesVCs?.count ?? 0 else { return viewModel.articlesVCs?.first }
        
        guard viewModel.articlesVCs?.count ?? 0 > nextIndex else { return nil }
        
        return viewModel.articlesVCs?[nextIndex]
    }
}
