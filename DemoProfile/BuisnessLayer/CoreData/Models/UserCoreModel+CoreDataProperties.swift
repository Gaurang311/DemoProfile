//
//  UserCoreModel+CoreDataProperties.swift
//  DemoProfile
//
//  Created by Gaurang Lathiya on 09/12/18.
//  Copyright © 2018 Gaurang Lathiya. All rights reserved.
//
//

import Foundation
import CoreData


extension UserCoreModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCoreModel> {
        return NSFetchRequest<UserCoreModel>(entityName: "UserCoreModel")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var email: String?
    @NSManaged public var userName: String?
    @NSManaged public var password: String?
    @NSManaged public var age: Int16
    
    func profileData() -> String {
        return """
        Your Profile Data is follwing:
        
        First Name: \(self.firstName ?? "")
        Last Name: \(self.lastName ?? "")
        User Name: \(self.userName ?? "")
        Age: \(self.age)
        """
    }

}
