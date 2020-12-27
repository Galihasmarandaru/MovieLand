//
//  FavouriteCell.swift
//  MovieLand
//
//  Created by Galih Asmarandaru on 27/12/20.
//

import UIKit

class FavouriteCell: UICollectionViewCell {
    var dataFav: Favourite? {
        didSet { configure() }
    }    
    
    let emptyFavMovie: UILabel = {
        let user = UILabel()
        user.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        user.textColor = .lightGray
        user.numberOfLines = 0
        user.text = "No Favourite Movie"
        
       return user
    }()
            
    let movieBox = Bundle.main.loadNibNamed("Movie", owner: self, options: nil)?.first as! MovieView
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        movieBox.titleOverviewMovie.isHidden = true        
                
        addSubview(movieBox)
        movieBox.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingRight: 10)        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure() {
        guard let movie = dataFav else { return }

        let viewModel = FavouriteViewModel(dataFav: movie)
        
        print(movie.poster_path!)
        let imageURL = "\(APIAccess(endpoint: "").URL_IMAGE)" + "\(movie.poster_path!)"
        guard let url = URL(string: imageURL) else { return }
        let getTaskImage = URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.movieBox.imageMovie.image = image
            }
        }
        getTaskImage.resume()
        
        movieBox.titleMovie.attributedText = viewModel.titleText
        movieBox.releaseDateMovie.attributedText = viewModel.releaseDateText
        movieBox.overviewMovie.attributedText = viewModel.overviewText
    }
}
