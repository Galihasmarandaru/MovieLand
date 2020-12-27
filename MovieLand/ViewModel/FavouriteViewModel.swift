//
//  FavouriteViewModel.swift
//  MovieLand
//
//  Created by Galih Asmarandaru on 27/12/20.
//

import UIKit

struct FavouriteViewModel {
    let dataFav: Favourite
    
    var titleText: NSAttributedString {
        let subject = NSMutableAttributedString(string: dataFav.title!, attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        
        return subject
    }
    var releaseDateText: NSAttributedString {
        let subject = NSMutableAttributedString(string: dataFav.release_date!, attributes: [.font: UIFont.boldSystemFont(ofSize: 12)])

        return subject
    }

    var overviewText: NSAttributedString {
        let subject = NSMutableAttributedString(string: dataFav.overview!, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])

        return subject
    }
}
