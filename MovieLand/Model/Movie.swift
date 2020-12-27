//
//  Movie.swift
//  MovieLand
//
//  Created by Galih Asmarandaru on 24/12/20.
//

import UIKit

struct Movie: Decodable {
    var page: Int
    var results: [MovieResult]
    var total_pages: Int
    var total_results: Int
}

struct MovieResult: Decodable {
    var poster_path: String
    var title: String
    var release_date: String
    var overview: String
}

enum MovieError: Error {
    case noDataAvailable
    case cannotProcessData
}


