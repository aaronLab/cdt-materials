//
//  BowTie+CoreDataProperties.swift
//  BowTies
//
//  Created by Aaron Lee on 2021/12/20.
//  Copyright © 2021 Razeware. All rights reserved.
//
//

import CoreData
import UIKit


extension BowTie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BowTie> {
        return NSFetchRequest<BowTie>(entityName: "BowTie")
    }

    @NSManaged public var name: String?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var lastWorn: Date?
    @NSManaged public var rating: Double
    @NSManaged public var searchKey: String?
    @NSManaged public var timesWorn: Int32
    @NSManaged public var id: UUID?
    @NSManaged public var url: URL?
    @NSManaged public var photoData: Data?
    @NSManaged public var tintColor: UIColor?

}

extension BowTie : Identifiable {

}
