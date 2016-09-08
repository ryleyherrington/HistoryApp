//
//  Article+CoreDataProperties.swift
//  HistoryDaze
//
//  Created by Ryley Herrington on 9/7/16.
//  Copyright © 2016 Herrington. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Article {

    @NSManaged var hasRead: NSNumber?
    @NSManaged var url: String?
    @NSManaged var wikiName: String?
    @NSManaged var saved: NSNumber?
    @NSManaged var fullDesc: String?
    @NSManaged var imageUrl: String?

}
