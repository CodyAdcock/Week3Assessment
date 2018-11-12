//
//  SearchTableViewCell.swift
//  Week3Assesment
//
//  Created by Cody on 11/12/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    var movie: MovieDictionary?{
        didSet{
            guard let movie = movie else {return}
            self.titleLabel.text = movie.name
            self.ratingLabel.text = "Rating: \(movie.rating ?? 0)"
            self.summaryLabel.text = movie.description
            self.posterImage.image = nil
            loadFromURL(urlAsString: movie.image ?? "")
            
        }
    }
    func loadFromURL(urlAsString: String){
        let myURL = URL(string: "https://image.tmdb.org/t/p/w500\(urlAsString)")
        print("\(myURL) 🐸🐸🐸")
        URLSession.shared.dataTask(with: myURL!) { (data, _, error) in
            do {
                if let error = error { throw error }
                guard let data = data else { throw NSError() }
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.posterImage.alpha = 0
                    self.posterImage.isHidden = false
                    self.posterImage.image = image
                    UIView.animate(withDuration: 0.5, animations: {
                        self.posterImage.alpha = 1
                    })
                }
            } catch let error {
                print("Error fetcing image \(error) \(error.localizedDescription)")
            }
            
            }.resume()
    }
}
