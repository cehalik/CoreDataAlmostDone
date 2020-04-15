//
//  MostViewed.swift
//  Assign4358
//
//  Created by Beverly L Brown on 4/8/20.
//  Copyright © 2020 Chris Halikias. All rights reserved.
//

import UIKit

class MostViewed: UITableViewController {
    
    // MARK: Properties
    
    var filteredCourses: [Course]?
    
    var myIndex = 0 // use the original tableView as the result table
    
    //  If search text is not empty, use the filter method (which takes a closure) to filter out the teams such that only
    //  the teams that contain the search text are included. Else, all teams are included. Lastly, reload the table view.
    func topThree(){
        filteredCourses = CourseHandler.sharedInstance.highView()
    }


    override func viewDidLoad() {
        
        self.topThree()
        super.viewDidLoad()
    }
    
    @IBAction func UpdateTable(_ sender: Any) {
        self.tableView.reloadData()
    }
    
    
    // MARK: - Table view data source

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CourseHandler.sharedInstance.saveView()
        filteredCourses = CourseHandler.sharedInstance.highView()
        self.tableView.reloadData()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let nflTeams = filteredCourses else {

            return 0

        }

        return nflTeams.count

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell2", for: indexPath)

        if let nflTeams = filteredCourses {
            
            let team = nflTeams[indexPath.row].name

            cell.textLabel!.text = "\(team) \(nflTeams[indexPath.row].visit)"

        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        let vc = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController
        vc?.nameD = filteredCourses![myIndex].getCourseName()
        vc?.descriptD = filteredCourses![myIndex].getCourseDescription()
        vc?.views = CourseHandler.sharedInstance.coursesCoreData[indexPath.row].incrementView()
        vc?.courseD = filteredCourses![myIndex]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    /*override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("You picked \(self.unfilteredCourseNames[indexPath.row])")

    }*/

}
