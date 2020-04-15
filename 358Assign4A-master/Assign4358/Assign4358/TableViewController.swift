//
//  TableViewController.swift
//  Assign4358
//
//  Created by Beverly L Brown on 4/8/20.
//  Copyright © 2020 Chris Halikias. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, UISearchResultsUpdating {
    // Ref: https://spin.atomicobject.com/2016/11/14/uisearchcontroller-add-search-uitableviews/
    
    // MARK: Properties
    
    var courses = [Course]()
    var filteredCourses: [Course]?
    
    //var unfilteredCourseName = [course]
    //"IT 358-Mobile and Cloud Computing"

    var unfilteredCourseNames = ["IT 191-Introduction to Professional Practice",
                              "IT 276-Data Communications",
                              "IT 382-Distributed Systems",
                              "IT 225-Computer Organization",
                              "IT 180- C++ Programming",
                              "IT 178-Computer Application Programming",
                              "IT 179-Introduction To Data Structures",
                              "IT 353-Introduction to Web Development",
                              "IT 254-Hardware and Software Concepts",
                              "IT 354-Advanced Web Development"].sorted()
    
    var filteredCourseNames: [String]?
    var myIndex = 0
    let searchController = UISearchController(searchResultsController: nil) // use the original tableView as the result table
    
    //  If search text is not empty, use the filter method (which takes a closure) to filter out the teams such that only
    //  the teams that contain the search text are included. Else, all teams are included. Lastly, reload the table view.

        func updateSearchResults(for searchController: UISearchController) {

            if let searchText = searchController.searchBar.text, !searchText.isEmpty {


    // filter method takes a closure ("unnamed function") and returns a result that satisfies the criteria
                filteredCourses = CourseHandler.sharedInstance.coursesCoreData.filter {
                    return $0.name.lowercased().contains(searchText.lowercased())
                }
                
            } else {
                
                filteredCourses = CourseHandler.sharedInstance.coursesCoreData

            }

            tableView.reloadData()

        }


    override func viewDidLoad() {
        
        //loadSampleCourses()

        filteredCourses = CourseHandler.sharedInstance.coursesCoreData.sorted(by: {$0.name < $1.name})
        
        filteredCourseNames = unfilteredCourseNames

        searchController.searchResultsUpdater = self

        searchController.hidesNavigationBarDuringPresentation = false

        searchController.dimsBackgroundDuringPresentation = false

        tableView.tableHeaderView = searchController.searchBar
        

        super.viewDidLoad()
    }
    
    
    @IBAction func unwindToCourseList(sender: UIStoryboardSegue){
        
        if let sourceViewController = sender.source as? ViewController, let course = sourceViewController.course{
            
            CourseHandler.sharedInstance.addCourse(course: course)
            /*unfilteredCourseNames.append(course.name)
            unfilteredCourseNames.sort()
            filteredCourseNames = unfilteredCourseNames*/
            filteredCourses = CourseHandler.sharedInstance.coursesCoreData
            
            tableView.reloadData()
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CourseHandler.sharedInstance.saveView()
        filteredCourses = CourseHandler.sharedInstance.coursesCoreData
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let nflTeams = filteredCourses else {

            return 0

        }

        return nflTeams.count
        //return filteredCourses!.count

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)

        if let nflTeams = filteredCourses {
            
            let team = nflTeams[indexPath.row].getCourseName()


            cell.textLabel!.text = "\(team)"

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
