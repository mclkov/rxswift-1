//
//  FavoriteMoviesVC.swift
//  rxswift-1
//
//  Created by McL on 10/10/18.
//  Copyright © 2018 McL. All rights reserved.
//

import UIKit
import Firebase

class FavoriteMoviesVC: UIViewController {

    // Outlets
    @IBOutlet weak var favoritesTV: UITableView!
    
    var dbref: DatabaseReference!
    var favoriteMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoritesTV.delegate = self
        favoritesTV.dataSource = self

        dbref = Database.database().reference()
        dbref.child("favorites").observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot]
            {
                let favoriteMovieList = child.value as? [String: String] ?? [:]
                if let movieTitle = favoriteMovieList["movie-title"]
                {
                    let movie = Movie(title: movieTitle)
                    self.favoriteMovies.append(movie)
                }
            }
            self.favoritesTV.reloadData()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoriteMoviesVC:
    UITableViewDataSource,
    UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = favoritesTV.dequeueReusableCell(withIdentifier: FAVORITE_MOVIE_CELL, for: indexPath) as? MovieCell
        {
            let movie = favoriteMovies[indexPath.row]
            print(movie.title)
            cell.configureCell(movie: movie)
            return cell
        }
        return MovieCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.favoriteMovies.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
}
