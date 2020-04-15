//
//  SettingsViewController.swift
//  Assign4358
//
//  Created by Beverly L Brown on 4/15/20.
//  Copyright © 2020 Chris Halikias. All rights reserved.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController{
    var pushSetting: Bool = CourseHandler.sharedInstance.pushNotify
    var colorSetting: Bool = CourseHandler.sharedInstance.color
    @IBOutlet weak var notifyButton: UIButton!
    @IBOutlet weak var colorButton: UIButton!
    
    override func viewDidLoad() {
        pushSetting = CourseHandler.sharedInstance.pushNotify
        colorSetting = CourseHandler.sharedInstance.color
        if(pushSetting == false){
            notifyButton.setTitle("Push notifications Enabled", for: .normal)
        }
        else{
            notifyButton.setTitle("Push notifications Disabled", for: .normal)
        }
        
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewDidLoad()
    }
    
    @IBAction func pushChange(_ sender: Any) {
        if(pushSetting == false){
            pushSetting = true
            CourseHandler.sharedInstance.savePush(newPush: pushSetting)
            notifyButton.setTitle("Push notifications Disabled", for: .normal)
        }
        else if(pushSetting == true) {
            pushSetting = false
            CourseHandler.sharedInstance.savePush(newPush: pushSetting)
            notifyButton.setTitle("Push notifications Enabled", for: .normal)
        }
        viewDidLoad()
    }
    @IBAction func colorChange(_ sender: Any) {
        self.view.backgroundColor = UIColor.systemGray
        
    }
    
    @IBAction func clearFavs(_ sender: Any) {
        CourseHandler.sharedInstance.noFavs()
    }
}
