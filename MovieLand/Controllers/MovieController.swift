//
//  MainController.swift
//  MovieLand
//
//  Created by Galih Asmarandaru on 24/12/20.
//

import UIKit

private let reuseIdentifier = "MovieCell"

class MovieController: UICollectionViewController {
//    let slideVC = CategoryViewController()
    
    var endpoint: String?
    
    var listOfMovie = [MovieResult]() {
        didSet {
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }    
    
    let navigationTop = NavigationTop()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        fetchMovie()
    }
    
    // MARK: Function
    
    func fetchMovie() {
        APIAccess(endpoint: endpoint!).getMovie { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let movies):
                self?.listOfMovie = movies
            }
        }
    }
    
    func configureNavigation() {
        navigationTop.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        navigationTop.delegate_navtop = self
        view.addSubview(navigationTop)        
    }
    
    func configureUI() {        
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.backgroundColor = .systemGray6
//        slideVC.delegate = self
    }
}

// MARK: UICollectionViewDataSource

extension MovieController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfMovie.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCell
        
        cell.delegate = self
        cell.movie = listOfMovie[indexPath.row]        
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension MovieController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 220)
    }
}


// MARK: MovieCellDelegate

extension MovieController: MovieCellDelegate {
    func handleMovieTapped(movie: MovieResult) {
        let controller = MovieDetailController()
        controller.dataPass = movie
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension MovieController: NavigationTopDelegate {
    func handleListFavourite() {
        let controller = FavouriteController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }        
}
