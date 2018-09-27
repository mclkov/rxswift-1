//
//  ViewController.swift
//  rxswift-1
//
//  Created by McL on 9/26/18.
//  Copyright © 2018 McL. All rights reserved.
//

import UIKit

class MoviesVC:
    UITableViewController
{
    
    // Outlets
    @IBOutlet weak var moviesTV: UITableView!
    
    let movies = [
        Movie(title: "Harry Pottr"),
        Movie(title: "Matrix")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTV.dataSource = self
        moviesTV.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = moviesTV.dequeueReusableCell(withIdentifier: MOVIE_CELL, for: indexPath) as? MovieCell
        {
            let movie = movies[indexPath.row]
            cell.configureCell(movie: movie)
        }
        return MovieCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

