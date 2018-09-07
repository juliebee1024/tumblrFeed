//
//  PhotosViewController.swift
//  tumblrFeed
//
//  Created by Julie Bao on 8/31/18.
//  Copyright © 2018 Julie Bao. All rights reserved.
//

import UIKit
import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts: [[String: Any]] = [] //will store the data returned from the network request
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        
        // Network request snippet
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(dataDictionary)
                // TODO: Get the posts and store in posts property
                // Get the dictionary from the response key
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                // Store the returned array of dictionaries in our posts property
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                
                // TODO: Reload the table view
                self.tableView.reloadData()
            }
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count //so that # of rows in table = # of posts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let post = posts[indexPath.row] //pulls a single post from our posts array

        // 1.            // 2.          // 3.
        if let photos = post["photos"] as? [[String: Any]] {
            // photos is NOT nil, we can use it!
            // 1. possible that we may get a 'nil' value for an element in the 'photos' array
            // 2. access 'photos' array of a post
            // 3. photos contains an array of dictionaries -> casted as String
            
            // TODO: Get the photo url
            // 1. get 1st photo in photos array
            let photo = photos[0]
            // 2. get original_size from the photo
            let originalSize = photo["original_size"] as! [String: Any]
            // 3. get the url from the original_size dictionary
            let urlString = originalSize["url"] as! String
            // 4. create a URL using the urlString
            let url = URL(string: urlString)
            
             cell.photoView.af_setImage(withURL: url!) //passes in the url where the Alamofire method will retrieve the image
        }
        return cell
    }
}
