//
//  MovieDetailController.swift
//  MovieLand
//
//  Created by Galih Asmarandaru on 25/12/20.
//

import UIKit
import CoreData

class MovieDetailController: UIViewController {
    
    var detailView: MovieDetailContent!
    var dataPass: MovieResult!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var dataFavourite: [Favourite]?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        configureUI()
        fechData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for i in 0..<dataFavourite!.count {
            if (dataPass.title == self.dataFavourite![i].title) {
                detailView.favouriteButton.isSelected = !detailView.favouriteButton.isSelected
                detailView.favouriteButton.tintColor = self.dataFavourite![i].hasFavourited ? UIColor.red : .systemGray6
            }
        }
    }
    
    // MARK: Function
    func configureUI() {
        detailView = MovieDetailContent(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 100))
        detailView.movie = dataPass
        detailView.delegate = self
        detailView.delegateFavourite = self
        view.addSubview(detailView)
    }
    
    func fechData() {
        do {
            self.dataFavourite = try context.fetch(Favourite.fetchRequest())
        } catch {

        }
    }
    
    func createData(hasFavBool: Bool) {
        let favourite = Favourite(context: self.context)
        favourite.hasFavourited = hasFavBool
        favourite.title = detailView.movie?.title
        favourite.poster_path = detailView.movie?.poster_path
        favourite.overview = detailView.movie?.overview
        favourite.release_date = detailView.movie?.release_date
        detailView.favouriteButton.tintColor = favourite.hasFavourited ? UIColor.red : .systemGray6
        
        do {
            try self.context.save()
        } catch {

        }
        
        self.fechData()
    }
    
    func deleteData(hasFavBool: Bool) {
        detailView.favouriteButton.tintColor = hasFavBool ? UIColor.red : .systemGray6
        self.context.delete(self.dataFavourite![0])
        
        do {
            try self.context.save()
        } catch {

        }
        
        self.fechData()
    }
}

// MARK: - NavigationDismissalDelegate

extension MovieDetailController: NavigationDismissalDelegate {
    func handleDismissal() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: MovieCellDelegate

extension MovieDetailController: FavouriteDelegate {
    func handleFavouriteTapped() {
        detailView.favouriteButton.isSelected = !detailView.favouriteButton.isSelected
        
        if (detailView.favouriteButton.isSelected) {
            createData(hasFavBool: detailView.favouriteButton.isSelected)
        } else if(!detailView.favouriteButton.isSelected) {
            deleteData(hasFavBool: detailView.favouriteButton.isSelected)
        }
    }
}
