//
//  NetworkClient.swift
//  Week3Assesment
//
//  Created by Cody on 11/12/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation

class TMDBClient{
    static let shared = TMDBClient()
    private init(){}
        
    func searchMovies(searchTerm: String = "Star Trek",completion: @escaping ([MovieDictionary]?) -> Void){
        let cheatingURL = "https://api.themoviedb.org/3/search/movie?api_key=4367e8dd70236bd264e4b7a48d9abfdf&query="
        let searchedTerm = searchTerm.lowercased().replacingOccurrences(of: " ", with: "+")
        let searchURL = URL(string: cheatingURL+searchedTerm)
        print (searchURL)
        URLSession.shared.dataTask(with: searchURL!) { (data, _, error) in
            if let error = error {
                print ("Error with dataTask: \(#function) \(error) \(error.localizedDescription)")
                completion(nil);return
            }
            guard let data = data else {completion(nil); return}
            do{
                let movies = try JSONDecoder().decode(Movies.self, from: data).movieDictionary
                completion(movies)
            }catch let error{
                print("Error with our JSONDecoder:  \(error) \(error.localizedDescription)")
                completion(nil);return
            }
        }.resume()
    }
}
