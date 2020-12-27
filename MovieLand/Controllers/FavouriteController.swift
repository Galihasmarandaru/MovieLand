//
//  FavvouriteController.swift
//  MovieLand
//
//  Created by Galih Asmarandaru on 26/12/20.
//

import UIKit

private let reuseIdentifier = "FavouriteCell"

class FavouriteController: UICollectionViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var dataFavourite = [Favourite]() {
        didSet {
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
    }
    
    let navigationDismiss = NavigationDismiss()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        configureUI()
        configureNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
    }
    
    var emptyFavMovieView = FavouriteCell()
    
    func configureNavigation() {
        navigationDismiss.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        navigationDismiss.delegate = self
        view.addSubview(navigationDismiss)
    }
    
    func configureUI() {
        if (dataFavourite.count == 0) {
            print("KOSONG")
            emptyFavMovieView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            view.addSubview(emptyFavMovieView.emptyFavMovie)
            emptyFavMovieView.emptyFavMovie.centerX(inView: collectionView, topAnchor: collectionView.safeAreaLayoutGuide.topAnchor)
            emptyFavMovieView.emptyFavMovie.centerY(inView: collectionView, leftAnchor: collectionView.safeAreaLayoutGuide.leftAnchor)
            collectionView.backgroundColor = .systemGray6
        } else {
            collectionView.register(FavouriteCell.self, forCellWithReuseIdentifier: reuseIdentifier)
            collectionView.backgroundColor = .systemGray6
        }
    }
    
    func fetchData() {
        do {
            self.dataFavourite = try context.fetch(Favourite.fetchRequest())
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } catch {
            
        }
    }
}

// MARK: UICollectionViewDataSource

extension FavouriteController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataFavourite.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FavouriteCell
        
        cell.dataFav = dataFavourite[indexPath.row]
        
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension FavouriteController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 90)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 220)
    }
}

// MARK: - NavigationDismissalDelegate

extension FavouriteController: NavigationDismissalDelegate {
    func handleDismissal() {
        navigationController?.popViewController(animated: true)
    }
}
