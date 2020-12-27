//
//  MovieDetailContent.swift
//  MovieLand
//
//  Created by Galih Asmarandaru on 25/12/20.
//

import UIKit
import CoreData

protocol FavouriteDelegate: class {
    func handleFavouriteTapped()
}

class MovieDetailContent: UIView {
    var movie: MovieResult?{
        didSet { configure() }
    }    
    
    var delegateFavourite: FavouriteDelegate!
    
    var delegate: NavigationDismissalDelegate!
    
    var NavigationDissmisalView: NavigationDismiss!
    
    
    let favouriteButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "fav_love").withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .systemGray5
        btn.imageEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        btn.addTarget(self, action: #selector(handleFavourite), for: .touchUpInside)
        
       return btn
    }()
    
    let movieBox = Bundle.main.loadNibNamed("Movie", owner: self, options: nil)?.first as! MovieView
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
            for subview in subviews {
                if !subview.isHidden && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                    return true
                }
            }
            return false
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        movieBox.layer.shadowOpacity = 0.4
        movieBox.layer.shadowColor = UIColor.gray.cgColor
        movieBox.layer.shadowRadius = 6
        movieBox.layer.shadowOffset = CGSize(width: 2, height: 4)
        movieBox.layer.cornerRadius = 8
        movieBox.layer.backgroundColor = UIColor.white.cgColor
        
        movieBox.overviewMovie.numberOfLines = 0
        movieBox.titleMovie.numberOfLines = 0
        movieBox.stackFirst.anchor(right: movieBox.rightAnchor, paddingRight: 70)
        movieBox.titleOverviewMovie.text = "Overview"
        
        NavigationDissmisalView = NavigationDismiss(frame: CGRect(x: 0, y: 0, width: frame.width, height: 100))
        NavigationDissmisalView.delegate = self
        
        addSubview(NavigationDissmisalView)
                
        addSubview(movieBox)
        movieBox.anchor(top: NavigationDissmisalView.bottomAnchor, left: NavigationDissmisalView.leftAnchor, right: NavigationDissmisalView.rightAnchor, paddingTop: 25, paddingLeft: 10, paddingRight: 10)
        
        movieBox.addSubview(favouriteButton)
        favouriteButton.anchor(top: movieBox.topAnchor, right: movieBox.rightAnchor, paddingTop: 25, paddingRight: 25)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func handleFavourite() {
        delegateFavourite?.handleFavouriteTapped()
//        favouriteButton.isSelected = !favouriteButton.isSelected
////        let favourite = Favourite(title: movie!.title, hasFavorited: favouriteButton.isSelected)
//        let favourite = Favourite(context: self.context)
//        favourite.hasFavourited = favouriteButton.isSelected
//        favouriteButton.tintColor = favourite.hasFavourited ? UIColor.red : .systemGray6
//
//        if (favouriteButton.isSelected) {
////            dataFavourite.append(favourite)
//            do {
//                try self.context.save()
//            } catch {
//
//            }
//
//
//        } else if(!favouriteButton.isSelected) {
////            dataFavourite = dataFavourite.filter {$0.title == movie!.title}
////            dataFavourite.remove(at: 0)
//        }
//
//        print(dataFavourite?.count)
////        print(dataFavourite.count)
////
    }
    
    func configure() {
        guard let movie = movie else { return }

        let viewModel = MovieViewModel(movie: movie)
        let viewModel_nav = NavigationDismissViewModel(movie: movie)
        
        let imageURL = "\(APIAccess(endpoint: "").URL_IMAGE)" + "\(movie.poster_path)"
        guard let url = URL(string: imageURL) else { return }
        let getTaskImage = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.movieBox.imageMovie.image = image
            }
        }
        getTaskImage.resume()
        
        NavigationDissmisalView.movieTitle.attributedText = viewModel_nav.titleText
        movieBox.titleMovie.attributedText = viewModel.titleText
        movieBox.releaseDateMovie.attributedText = viewModel.releaseDateText
        movieBox.overviewMovie.attributedText = viewModel.overviewText
    }
}

extension MovieDetailContent: NavigationDismissalDelegate {
    func handleDismissal() {
        delegate.handleDismissal()
    }
}
