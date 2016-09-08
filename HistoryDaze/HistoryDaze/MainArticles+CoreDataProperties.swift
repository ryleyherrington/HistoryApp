//
//  MainArticles+CoreDataProperties.swift
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

extension MainArticles {

    @NSManaged var articleSlug: String?
    @NSManaged var mainName: String?
    @NSManaged var hasRead: NSNumber?

}
