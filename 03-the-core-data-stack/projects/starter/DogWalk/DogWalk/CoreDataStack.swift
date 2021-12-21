//
//  CoreDataStack.swift
//  DogWalk
//
//  Created by Aaron Lee on 2021/12/21.
//  Copyright © 2021 Razeware. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
  private let modelName: String
  
  init(modelName: String) {
    self.modelName = modelName
  }
  
  private lazy var storeContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: modelName)
    container.loadPersistentStores { _, error in
      
      if let error = error as NSError? {
        print("Unresolved error \(error), \(error.userInfo)")
      }
      
    }
    
    return container
    
  }()
  
  lazy var managedContext: NSManagedObjectContext = {
    return storeContainer.viewContext
  }()
  
  func saveContext() {
    do {
      try managedContext.save()
    } catch let e as NSError {
      print("Unresolved error \(e), \(e.userInfo)")
    }
  }
  
}
