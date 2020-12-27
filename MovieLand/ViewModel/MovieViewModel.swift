//
//  MovieViewModel.swift
//  MovieLand
//
//  Created by Galih Asmarandaru on 24/12/20.
//

import UIKit

struct MovieViewModel {
    let movie: MovieResult
    
    var titleText: NSAttributedString {
        let subject = NSMutableAttributedString(string: movie.title, attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        
        return subject
    }
    var releaseDateText: NSAttributedString {
        let subject = NSMutableAttributedString(string: movie.release_date, attributes: [.font: UIFont.boldSystemFont(ofSize: 12)])
        
        return subject
    }
    
    var overviewText: NSAttributedString {
        let subject = NSMutableAttributedString(string: movie.overview, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        
        return subject
    }
}
