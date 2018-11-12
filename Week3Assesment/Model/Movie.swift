//
//  Movie.swift
//  Week3Assesment
//
//  Created by Cody on 11/12/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import Foundation

struct Movies: Decodable{
    let movieDictionary: [MovieDictionary]?
    private enum CodingKeys: String, CodingKey{
        case movieDictionary = "results"
    }
}

struct MovieDictionary: Decodable{
    let name: String?
    let rating: Double?
    let description: String?
    let image: String?
    private enum CodingKeys: String, CodingKey{
        case name = "title"
        case rating = "vote_average"
        case description = "overview"
        case image = "poster_path"
    }
}
