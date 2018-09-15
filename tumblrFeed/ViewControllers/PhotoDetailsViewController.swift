//
//  PhotoDetailsViewController.swift
//  tumblrFeed
//
//  Created by Julie Bao on 9/8/18.
//  Copyright © 2018 Julie Bao. All rights reserved.
//

import UIKit
//import AlamofireImage

class PhotoDetailsViewController: UIViewController {
    
    var photosviewcontroller: PhotosViewController?
    @IBOutlet weak var photoDetailView: UIImageView!
    var imgurl: URL! //will store the URL
    //var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        photoDetailView.af_setImage(withURL: imgurl!)
        //photoDetailView.image = image
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
