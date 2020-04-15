//
//  ViewController.swift
//  Assign4358
//
//  Created by Beverly L Brown on 4/8/20.
//  Copyright © 2020 Chris Halikias. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController {
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var name2: UITextField!
    @IBOutlet weak var descript2: UITextField!
    @IBOutlet weak var favButton: UIButton!
    
    var course: Course?
    var favorite: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: Navigation
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func courseFav(_ sender: UIButton) {
        if(favorite == false){
            favorite = true
            favButton.setTitle("Unfavorite", for: .normal)
        }
        else if(favorite == true) {
            favorite = false
            favButton.setTitle("Favorite", for: .normal)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else{
        os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
        return
    }
        
        
        let name = name2.text ?? ""
        let description = descript2.text ?? ""
        
        // Set the Course to be passed to TableViewController after unwind segue
        course = Course(name: name, description: description, views: 0, fav: false)
        course?.setFav(favorite)
    }
    //MARK: Private Methods
    private func updateSaveButtonState() {
        let text = name2.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}
