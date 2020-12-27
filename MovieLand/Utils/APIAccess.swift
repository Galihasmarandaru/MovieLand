//
//  APIAccess.swift
//  MovieLand
//
//  Created by Galih Asmarandaru on 24/12/20.
//

import UIKit

//enum Endpoint {
//    case popular
//    case upcoming
//    case top_rated
//    case now_playing
//}

struct APIAccess {
    let endpoint: String
    let API_KEY = "7b894093d89bc567e11fc09f309842c7"
    let URL_MOVIE = "https://api.themoviedb.org/3/movie/"
    let URL_IMAGE = "https://image.tmdb.org/t/p/w500"
    
    init(endpoint: String) {
        self.endpoint = endpoint
    }
    
    func getMovie(completion: @escaping(Result<[MovieResult], MovieError>) -> Void) {
        let urlString = "\(URL_MOVIE)" + "\(endpoint)" + "?api_key=\(API_KEY)"
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, _, _) in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let moviesResponse = try decoder.decode(Movie.self, from: jsonData)
                let moviesDetail = moviesResponse.results
                completion(.success(moviesDetail))
            } catch {
                completion(.failure(.cannotProcessData))
            }
        }
        
        dataTask.resume()
    }
}
