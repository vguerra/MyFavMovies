//
//  MovieDetailViewController.swift
//  MyFavoriteMovies
//
//  Created by Jarrod Parkes on 1/23/15.
//  Copyright (c) 2015 Udacity. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var unFavoriteButton: UIButton!

    var appDelegate: AppDelegate!
    var session: NSURLSession!
    
    var movie: Movie?
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Get the app delegate */
        appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        
        /* Get the shared URL session */
        session = NSURLSession.sharedSession()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        /* TASK A: Get favorite movies, then update the favorite buttons */
        /* 1A. Set the parameters */
        let methodParemeters = [
            "api_key": appDelegate.apiKey,
            "session_id": appDelegate.sessionID!,
            "page": "1"
        ]
        /* 2A. Build the URL */
        let urlString = appDelegate.baseURLSecureString + "account/\(appDelegate.userID)/favorite/movies" + appDelegate.escapedParameters(methodParemeters)
        let url = NSURL(string: urlString)!
        
        /* 3A. Configure the request */
        let request = NSMutableURLRequest(URL: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        /* 4A. Make the request */
        let task = session.dataTaskWithRequest(request) { data, request, downloadError in
            if let error = downloadError {
                println("Error with request: \(error)")
            } else {
                var parseError: NSError? = nil
                let parsedResult = NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments, error: &parseError) as! NSDictionary
                
                println(parsedResult)
                if let results = parsedResult["results"] as? [[String: AnyObject]] {
                    let movies = Movie.moviesFromResults(results)
                    var isFavorite = false
                    
                    for movie in movies {
                        if movie.id == self.movie!.id {
                            isFavorite == true
                        }
                    }

                    dispatch_async(dispatch_get_main_queue()) {
                        if isFavorite {
                            self.movieIsFavorite()
                        } else {
                            self.movieIsNotFavorite()
                        }
                    }
                } else {
                    println("No favorites")
                    dispatch_async(dispatch_get_main_queue()) {
                        self.movieIsNotFavorite()
                    }
                }
            }
        }

        /* 7A. Start the request */
        task.resume()
        
        /* TASK B: Get the poster image, then populate the image view */
        if let posterPath = movie!.posterPath {
            
            /* 1B. Set the parameters */
            // There are none...
            
            /* 2B. Build the URL */
            let baseURL = NSURL(string: appDelegate.config.baseImageURLString)!
            let url = baseURL.URLByAppendingPathComponent("w342").URLByAppendingPathComponent(posterPath)
            
            /* 3B. Configure the request */
            let request = NSURLRequest(URL: url)
            
            /* 4B. Make the request */
            let task = session.dataTaskWithRequest(request) {data, response, downloadError in
                
                if let error = downloadError {
                    println(error)
                } else {
                    
                    /* 5B. Parse the data */
                    // No need, the data is already raw image data.
                    
                    /* 6B. Use the data! */
                    if let image = UIImage(data: data!) {
                        dispatch_async(dispatch_get_main_queue()) {
                            self.posterImageView!.image = image
                        }
                    }
                }
            }
        
            /* 7B. Start the request */
            task.resume()
        }
    }
    
    // MARK: - Favorite Actions
    
    @IBAction func unFavoriteButtonTouchUpInside(sender: AnyObject) {
        
        /* TASK: Remove movie as favorite, then update favorite buttons */
        /* 1. Set the parameters */
        /* 2. Build the URL */
        /* 3. Configure the request */
        /* 4. Make the request */
        /* 5. Parse the data */
        /* 6. Use the data! */
        /* 7. Start the request */
    }
    
    @IBAction func favoriteButtonTouchUpInside(sender: AnyObject) {
        
        /* TASK: Add movie as favorite, then update favorite buttons */
        /* 1. Set the parameters */
        /* 2. Build the URL */
        /* 3. Configure the request */
        /* 4. Make the request */
        /* 5. Parse the data */
        /* 6. Use the data! */
        /* 7. Start the request */
    }
    
    // MARK: Utilities
    func movieIsFavorite() {
        favoriteButton.hidden = true
        unFavoriteButton.hidden = false
    }
    
    func movieIsNotFavorite() {
        favoriteButton.hidden = false
        unFavoriteButton.hidden = true
    }
}