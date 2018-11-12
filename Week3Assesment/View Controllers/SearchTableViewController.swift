//
//  SearchTableViewController.swift
//  Week3Assesment
//
//  Created by Cody on 11/12/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    var movies: [MovieDictionary]?{
        didSet{
            updateViews()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {return}
        TMDBClient.shared.searchMovies(searchTerm: searchText) { (movies) in
            self.movies = movies
        }
        searchBar.resignFirstResponder()
    }
    
    func updateViews(){
        DispatchQueue.main.async {
        self.tableView.reloadData()}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let movies = movies else {return 0}
        return movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? SearchTableViewCell
        guard let movies = movies else {return UITableViewCell()}

        cell?.movie = movies[indexPath.row]

        return cell ?? UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
