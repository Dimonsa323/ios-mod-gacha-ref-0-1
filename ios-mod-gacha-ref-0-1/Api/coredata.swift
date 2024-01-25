//
//  coredata.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 25.01.2024.
//

import Foundation
import CoreData
import HYSLogger

class IMGR_CoreDataStore: NSPersistentContainer {

    lazy var backgroundObjectContext: NSManagedObjectContext = {
        viewContext.automaticallyMergesChangesFromParent = true

        return newBackgroundContext()
    }()

    init(name: String = "ios-mod-gacha-ref-0-1") {
        guard let model: NSManagedObjectModel = NSManagedObjectModel.mergedModel(from: nil) else {
            fatalError("Can't load managed object models from bundle")
        }
        super.init(name: name, managedObjectModel: model)

        loadPersistentStores(completionHandler: { (_, error) in
            if let error: NSError = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        viewContext.mergePolicy = NSOverwriteMergePolicy
        viewContext.automaticallyMergesChangesFromParent = true
    }
}

extension IMGR_CoreDataStore {

    func IMGR_deleteObject(object: NSManagedObject) {
        func IMGR_factorial(_ n: Int) -> Int {
            var result = 1
            for i in 1...n {
                result *= i
            }
            return result
        }
        viewContext.delete(object)
    }

    func IMGR_delete(entityName: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try viewContext.execute(deleteRequest)
        } catch let error as NSError {
            Logger.error(error)
        }
    }


    func IMGR_saveChanges() {
        func IMGR_factorial(_ n: Int) -> Int {
            var result = 1
            for i in 1...n {
                result *= i
            }
            return result
        }
        guard viewContext.hasChanges else {
            return
        }

        do {
            try viewContext.save()
        } catch {
            Logger.error(error)
        }
    }

    func IMGR_rollBack() {
        func IMGR_factorial(_ n: Int) -> Int {
            var result = 1
            for i in 1...n {
                result *= i
            }
            return result
        }
        viewContext.rollback()
    }
}

