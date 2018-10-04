//
//  ViewController.swift
//  rxswift-1
//
//  Created by McL on 9/26/18.
//  Copyright © 2018 McL. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

class MoviesVC:
    UIViewController
{
    // Outlets
    @IBOutlet weak var moviesTV: UITableView!
    @IBOutlet weak var movieSearch: UISearchBar!
    
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTV.dataSource = self
        moviesTV.delegate = self
        
        movieSearch.rx.text
            .orEmpty
            .distinctUntilChanged()
            .filter{ !$0.isEmpty }
            .debounce(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { (query) in
                guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
                    //Invalid URL
                    return
                }
                
                let url = "https://www.omdbapi.com/?apikey=89fe8236&s=" + encodedQuery
                Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                    self.movies.removeAll()
                    guard let data = response.data else
                    {
                        return
                    }
                    
                    do
                    {
                        let json = try JSON(data: data)
                        for movie in json["Search"]
                        {
                            let title = movie.1["Title"].stringValue
                            let newMovie = Movie(title: title)
                            
                            self.movies.append(newMovie)
                        }
                    } catch {
                        print(error)
                    }
                    self.moviesTV.reloadData()
                })
            })
        
//        movieSearch.rx.text.throttle(5, scheduler: MainScheduler.instance).subscribe(onNext: { (element) in
//            print(element)
//        }, onError: <#T##((Error) -> Void)?##((Error) -> Void)?##(Error) -> Void#>, onCompleted: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>, onDisposed: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension MoviesVC:
    UITableViewDataSource,
    UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = moviesTV.dequeueReusableCell(withIdentifier: MOVIE_CELL, for: indexPath) as? MovieCell
        {
            let movie = movies[indexPath.row]
            cell.configureCell(movie: movie)
            return cell
        }
        return MovieCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
}

