//
//  NavigationDismissViewModel.swift
//  MovieLand
//
//  Created by Galih Asmarandaru on 25/12/20.
//

import UIKit

struct NavigationDismissViewModel {
    let movie: MovieResult
    
    var titleText: NSAttributedString {
        let subject = NSMutableAttributedString(string: movie.title, attributes: [.font: UIFont.boldSystemFont(ofSize: 22)])
        
        return subject
    }
}
