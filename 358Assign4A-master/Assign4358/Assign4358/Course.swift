//
//  Course.swift
//  Assign4358
//
//  Created by Beverly L Brown on 4/8/20.
//  Copyright © 2020 Chris Halikias. All rights reserved.
//
import Foundation
struct Course {
    var name: String
    var courseDescription: String
    var visit: Int
    var fav: Bool
    
    init?(name: String, description: String, views: Int, fav:Bool = false) {
        
        self.name = name
        self.courseDescription = description
        self.visit = views
        self.fav = fav
    }
    public func getCourseName() -> String{
        return self.name
    }
    public func getCourseDescription() -> String{
        return self.courseDescription
    }
    public func getView() -> Int{
        return self.visit
    }
    public func getFav() -> Bool{
        return self.fav
    }
    mutating public func incrementView() -> Int {
        self.visit += 1
        return self.visit
    }
    mutating public func setFav(_ fav: Bool){
        self.fav = fav
    }
}
