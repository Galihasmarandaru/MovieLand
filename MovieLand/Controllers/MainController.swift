//
//  MainController.swift
//  MovieLand
//
//  Created by Galih Asmarandaru on 25/12/20.
//

import UIKit

enum Endpoint {
    case popular
    case upcoming
    case top_rated
    case now_playing
}

class MainController: UITabBarController {
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.barTintColor = .themeColor
//
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.barStyle = .black
//        navigationController?.navigationBar.tintColor = .white
//        configureView(endpoint: endpoint)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureView(endpoint: "\(Endpoint.popular)")
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        showModal()
    }
    
    // MARK: Function
    func configureView(endpoint: String) {
                
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 0
        
        let feed = MovieController(collectionViewLayout: layout)
        feed.endpoint = endpoint
        
        let nav = templateNavigationController(rootViewController: feed)
        
        viewControllers = [nav]
//        navigationController?.addChild(nav)
    }
    
    @objc func showModal() {
        let slideVC = CategoryViewController(nibName: "Category", bundle: nil)
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        slideVC.delegate = self
        self.present(slideVC, animated: true, completion: nil)
    }

    func templateNavigationController(rootViewController: UIViewController) -> UINavigationController {

        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.title = "Category"
        nav.navigationBar.prefersLargeTitles = true
        nav.navigationItem.title = "Moview Land"

        let font: UIFont = UIFont(name: "Helvetica", size: 18)!
        nav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        return nav
    }
}

extension MainController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension MainController: CategoryDelegate {
    func handlePopularMovieTapped() {
        presentedViewController?.dismiss(animated: true, completion: nil)
        configureView(endpoint: "\(Endpoint.popular)")
    }
    
    func handleUpCommingMovieTapped() {
        presentedViewController?.dismiss(animated: true, completion: nil)
        configureView(endpoint: "\(Endpoint.upcoming)")
    }
    
    func handleTopRatedMovieTapped() {
        presentedViewController?.dismiss(animated: true, completion: nil)
        configureView(endpoint: "\(Endpoint.top_rated)")
    }
    
    func handleNowPlayingMovieTapped() {
        presentedViewController?.dismiss(animated: true, completion: nil)
        configureView(endpoint: "\(Endpoint.now_playing)")
    }
}
