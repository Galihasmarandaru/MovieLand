//
//  MovieCell.swift
//  MovieLand
//
//  Created by Galih Asmarandaru on 24/12/20.
//

import UIKit

protocol MovieCellDelegate: class {
    func handleMovieTapped(movie: MovieResult)
}


class MovieCell: UICollectionViewCell {
    var movie: MovieResult? {
        didSet { configure() }
    }
    
    weak var delegate: MovieCellDelegate?
            
    let movieBox = Bundle.main.loadNibNamed("Movie", owner: self, options: nil)?.first as! MovieView
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        movieBox.titleOverviewMovie.isHidden = true
                
        addSubview(movieBox)
        movieBox.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 10, paddingRight: 10)        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCellTapped))
        addGestureRecognizer(tap)
        isUserInteractionEnabled =  true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Function
    @objc func handleCellTapped() {
        delegate?.handleMovieTapped(movie: movie!)
    }    
    
    func configure() {
        guard let movie = movie else { return }

        let viewModel = MovieViewModel(movie: movie)
        
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
        
        movieBox.titleMovie.attributedText = viewModel.titleText
        movieBox.releaseDateMovie.attributedText = viewModel.releaseDateText
        movieBox.overviewMovie.attributedText = viewModel.overviewText
    }
}
