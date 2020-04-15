//
//  SecondViewController.swift
//  Assign4358
//
//  Created by Beverly L Brown on 4/8/20.
//  Copyright © 2020 Chris Halikias. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController {

    
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var descriptLabel: UILabel!
    @IBOutlet weak var viewCount: UILabel!
    @IBOutlet weak var favButton: UIButton!
    var nameD = ""
    var descriptD = ""
    var views = 0
    var courseD: Course?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        courseLabel.text = nameD
        descriptLabel.text = descriptD
        viewCount.text = String(views)
        if(courseD!.fav == true){
            favButton.setTitle("Unfavorite", for: .normal)
        }
        else{
            favButton.setTitle("Favorite", for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func favChange(_ sender: UIButton) {
        //courseD = CourseHandler.sharedInstance.favFind(detailName: nameD)
        if(courseD!.fav == false){
            courseD!.setFav(true)
            CourseHandler.sharedInstance.favSet(course: courseD!)
            favButton.setTitle("Unfavorite", for: .normal)
        }
        else if(courseD!.fav == true) {
            //favorite = false
            courseD!.setFav(false)
            favButton.setTitle("Favorite", for: .normal)
        }
    }
    
    
}

