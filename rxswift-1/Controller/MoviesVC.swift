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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTV.dataSource = self
        moviesTV.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

