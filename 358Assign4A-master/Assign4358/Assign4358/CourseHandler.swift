//
//  CourseHandler.swift
//  Assign4358
//
//  Created by Beverly L Brown on 4/8/20.
//  Copyright © 2020 Chris Halikias. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CourseHandler{
    static let sharedInstance = CourseHandler()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    let requestCourse = NSFetchRequest<NSFetchRequestResult>(entityName: "Course")
    
    var courses2:[Course] = [
        Course(name: "IT 191-Introduction to Professional Practice", description: "Researching available positions, interpreting job descriptions, interview skills, preparing a resume, benefits of a Professional Practice experience.", views: 0, fav: false)!,
        Course(name: "IT 276-Data Communications", description: "Hardware and software used in data communications and networking. Network types, architectures, protocols and standards. Local area and packet networks.", views: 0, fav: false)!,
        Course(name: "IT 382-Distributed Systems", description: "Overview of distributed systems including system architectures, models, distributed operating systems, distributed algorithms, distributed databases, distributed objects, issues and trends. Offered alternate years.", views: 0, fav: false)!,
        Course(name: "IT 225-Computer Organization", description: "Introduction to computer organization, internal representation of instructions and data, and interaction between software and hardware components.", views: 0, fav: false)!,
        Course(name: "IT 180- C++ Programming", description: "Introduction to the C++ programming language with emphasis on pointers, dynamic memory management, and templates.", views: 0, fav: false)!,
        Course(name: "IT 178-Computer Application Programming", description: "The design, development, and implementation of computer application systems, including files and GUI.", views: 0, fav: false)!,
        Course(name: "IT 179-Introduction To Data Structures", description: "Intermediate computer programming, including elementary data structures such as linked lists, stacks, queues, binary trees.", views: 0, fav: false)!,
        Course(name: "IT 353-Introduction to Web Development", description: "Web concepts, infrastructure, development technologies, multi-tiered program design and implementation, and current issues and trends.", views: 0, fav: false)!,
        Course(name: "IT 254-Hardware and Software Concepts", description: "Overview of nature and interrelationships of computer architectures, hardware, operating systems, data types, microcontrollers, virtualization, storage technologies, and filesystems.", views: 0, fav: false)!,
        Course(name: "IT 354-Advanced Web Development", description: "Theory and practice of state-of-the-art technologies for application development for the Web including service-oriented and mobile systems.", views: 0, fav: false)!].sorted(by: {$0.name < $1.name})
    var copy = [Course]()
    var top3 = [Course]()
    var coursesCoreData:[Course] = []
    
    let requestSettings = NSFetchRequest<NSFetchRequestResult>(entityName: "SettingsClass")
    var color: Bool = false
    var pushNotify: Bool = false
    
    func savePush(newPush: Bool){
        pushNotify = newPush
        setSettings()
    }
    func setSettings(){
        let settingEntity = NSEntityDescription.entity(forEntityName: "SettingsClass", in: context.viewContext)
        let updatedSettings = NSManagedObject(entity: settingEntity!, insertInto: context.viewContext)
        updatedSettings.setValue(color, forKey: "color")
        updatedSettings.setValue(pushNotify, forKey: "pushNotify")
        do{
            try context.viewContext.save()
            print("Settings have been updated")
        } catch{
            print("Failed to update Settings")
        }
        
    }
    func getSettings(){
        requestCourse.returnsObjectsAsFaults = false
        do{
            let result = try self.context.viewContext.fetch(requestSettings)
            for setting in result as! [NSManagedObject]{
                self.pushNotify = setting.value(forKey: "pushNotify") as! Bool
                self.color = setting.value(forKey: "color") as! Bool
            }
        }catch{
            print("Unable to get settings")
        }
    }
    /*
     func getData(){
         requestCourse.returnsObjectsAsFaults = false
         
         do{
             let result = try self.context.viewContext.fetch(requestCourse)
             for data in result as! [NSManagedObject]{
                 coursesCoreData.append(Course(name: data.value(forKey: "name") as! String, description: data.value(forKey: "courseDescription") as! String, views: data.value(forKey: "visit") as! Int, fav: data.value(forKey: "fav") as! Bool)!)
             }
             coursesCoreData = coursesCoreData.sorted(by: {$0.name < $1.name})
         } catch{
             
         }
     }
     */
    
    func addCourse(course: Course){
        coursesCoreData.append(course)
        coursesCoreData = coursesCoreData.sorted(by: {$0.name < $1.name})
        saveData()
    }
    func saveView(){
        coursesCoreData = coursesCoreData.sorted(by: {$0.name < $1.name})
        saveData()
    }
    func highView() -> [Course]{
        copy = coursesCoreData.sorted(by: {$0.getView() > $1.getView()})
        top3 = [copy[0], copy[1], copy[2]]
        return top3
    }
    func favList() -> [Course]{
        copy = coursesCoreData.filter {$0.fav == true}
        return copy
    }
    func favSet(course: Course){
        if let index = self.coursesCoreData.firstIndex(where: {$0.name == course.name}) {
               coursesCoreData[index] = course
        }
        saveData()
    }
    func saveFav() {
        saveData()
    }
    func count() -> Int{
        return coursesCoreData.count
    }
    func noFavs(){
        coursesCoreData = coursesCoreData.map{course in
            var tempCourse:Course = course
            tempCourse.setFav(false)
            return tempCourse
        }
        saveData()
    }
    func initialSave(){
        let entity = NSEntityDescription.entity(forEntityName: "Course", in: context.viewContext)
        
        for course in CourseHandler.sharedInstance.courses2{
            let newEntity = NSManagedObject(entity: entity!, insertInto: context.viewContext)
            newEntity.setValue(course.getCourseName(), forKey: "name")
            newEntity.setValue(course.getCourseDescription(), forKey: "courseDescription")
            newEntity.setValue(course.getView(), forKey: "visit")
            newEntity.setValue(course.getFav(), forKey: "fav")
        }
        do{
            try context.viewContext.save()
            print("Initial data has been saved")
        }catch{
            print("Initial save failed")
        }
    }
    
    func saveData(){
        deleteData()
        let entity = NSEntityDescription.entity(forEntityName: "Course", in: context.viewContext)
        for course in CourseHandler.sharedInstance.coursesCoreData{
            let newEntity = NSManagedObject(entity: entity!, insertInto: context.viewContext)
            newEntity.setValue(course.getCourseName(), forKey: "name")
            newEntity.setValue(course.getCourseDescription(), forKey: "courseDescription")
            newEntity.setValue(course.visit, forKey: "visit")
            newEntity.setValue(course.getFav(), forKey: "fav")
        }
        do{
            try context.viewContext.save()
            print("New data has been saved")
        }catch{
            print("Failed to save data")
        }
    }
    func getData(){
        requestCourse.returnsObjectsAsFaults = false
        
        do{
            let result = try self.context.viewContext.fetch(requestCourse)
            for data in result as! [NSManagedObject]{
                coursesCoreData.append(Course(name: data.value(forKey: "name") as! String, description: data.value(forKey: "courseDescription") as! String, views: data.value(forKey: "visit") as! Int, fav: data.value(forKey: "fav") as! Bool)!)
            }
            coursesCoreData = coursesCoreData.sorted(by: {$0.name < $1.name})
        } catch{
            
        }
    }
    func deleteData() {
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: requestCourse)
        do {
            try context.viewContext.execute(batchDeleteRequest)
        } catch {
            print("Goofed up")
        }
    }
}
