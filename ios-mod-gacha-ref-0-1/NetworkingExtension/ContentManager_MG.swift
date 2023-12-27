//
//  ContentManager_MG.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 27.12.2023.
//

import Foundation
import CoreData

//final class ContentManager_MG: NSObject {
//
//    lazy var managedContext_MGN: NSManagedObjectContext = {
//        persistentContainer_MGN.viewContext
//    }()
//
//    private lazy var persistentContainer_MGN: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "ContentCache_MG")
//        container.loadPersistentStores { description, error in
//            if let error = error {
//                fatalError("Unable to load persistent stores: \(error)")
//            }
//        }
//        return container
//    }()
//
//    func getModelPath_MG(for imgPath: String) -> String {
//        String(format: "/%@", imgPath)
//    }
//
//    func getPath_MG(for contentType: ContentType_MG, imgPath: String) -> String {
//        switch contentType {
//        case .mods_mgn:
//            var originalString = imgPath
//            let replacementString = "TipsAndTricks"
//            if let range = originalString.range(of: "Tips_and_Tricks") {
//                originalString.replaceSubrange(range, with: replacementString)
//            }
//            return String(format: "/%@", originalString)
//        case .wallpapers_mgn, .editor_mgn:
//            return String(format: "/%@", imgPath)
//        default:
//            return String(format: "/%@/%@", contentType.associatedPath.rawValue, imgPath)
//        }
//    }
//
//    func getPath_MG(for contentType: ContentType_MG, filePath: String) -> String {
//        switch contentType {
//        case .mods_mgn:
//            return String(format: "/%@", filePath)
//        default: return ""
//        }
//    }
//
//    func serialized_MGN(markups data: Data) -> [EditorCodableContentList_MG] {
//        if let jsonObj = jsonObj_MGN(from: data, with: "dgsb-we3"),
//           let markups = try? JSONDecoder().decode([EditorCodableContentList_MG].self,
//                                                   from: jsonObj) {
//            return markups
//        }
//
//        return []
//    }
//
//    func fetchFavorites_MGN(contentType: ContentType_MG) -> [String] {
//        let fetchRequest = FavoritesEntity.fetchRequest()
//        fetchRequest.predicate = .init(format: "contentType == %i", contentType.int64)
//        do {
//            let result = try managedContext_MGN.fetch(fetchRequest)
//            return result.compactMap { $0.id }
//        } catch let error as NSError {
//            print(error.localizedDescription)
//            return []
//        }
//    }
//
//    func storeFavorites_MGN(with id: String, contentType: ContentType_MG) {
//        let fetchRequest = FavoritesEntity.fetchRequest()
//        fetchRequest.predicate = .init(format: "contentType == %i AND id == %@",
//                                       contentType.int64,
//                                       id as CVarArg)
//        fetchRequest.fetchLimit = 1
//
//        do {
//            if let entity = try managedContext_MGN.fetch(fetchRequest).first {
//                entity.id = id
//                entity.contentType = contentType.int64
//            } else {
//                let entity = FavoritesEntity(context: managedContext_MGN)
//                entity.id = id
//                entity.contentType = contentType.int64
//            }
//
//            saveContext_MGN()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }
//
//    func deleteFavorites_MGN(with id: String, contentType: ContentType_MG) {
//        let fetchRequest = FavoritesEntity.fetchRequest()
//        fetchRequest.predicate = .init(format: "contentType == %i AND id == %@",
//                                       contentType.int64,
//                                       id as CVarArg)
//        fetchRequest.fetchLimit = 1
//
//        do {
//            if let entity = try managedContext_MGN.fetch(fetchRequest).first {
//                managedContext_MGN.delete(entity)
//            }
//        } catch let error as NSError {
//            print(error.localizedDescription)
//            managedContext_MGN.rollback()
//        }
//    }
//
//    func fetchCharacters_MGN() -> [CharacterPreview_MG] {
//        let fetchRequest = CharacterEntity.fetchRequest()
//        do {
//            return try managedContext_MGN
//                .fetch(fetchRequest)
//                .compactMap { CharacterPreview_MG(from: $0) }
//        } catch let error as NSError {
//            print(error.localizedDescription)
//            return []
//        }
//    }
//
//    func removeAllCharacters_MGN() {
//        let fetchRequest = CharacterEntity.fetchRequest()
//
//        do {
//            let characters = try managedContext_MGN.fetch(fetchRequest)
//
//            for character in characters {
//                managedContext_MGN.delete(character)
//            }
//
//            saveContext_MGN()
//            print("All characters removed successfully.")
//        } catch let error as NSError {
//            print("Error removing characters: \(error.localizedDescription)")
//        }
//    }
//
//    func store_MGN(character preview: CharacterPreview_MG) {
//        let fetchRequest = CharacterEntity.fetchRequest()
//        fetchRequest.predicate = .init(format: "%K == %@", "id",
//                                       preview.id as CVarArg)
//        fetchRequest.fetchLimit = 1
//
//        do {
//            if let entity = try managedContext_MGN.fetch(fetchRequest).first {
//                entity.content = preview.content
//                entity.body = preview.body
//                entity.brows = preview.brows
//                entity.eyes = preview.eyes
//                entity.hairBottom = preview.hairBottom
//                entity.hairTop = preview.hairTop
//                entity.headdress = preview.headdress
//                entity.mouth = preview.mouth
//                entity.shoes = preview.shoes
//                entity.top = preview.top
//                entity.trousers = preview.trousers
//                entity.wings = preview.wings
//            } else {
//                let entity = CharacterEntity(context: managedContext_MGN)
//                entity.id = preview.id
//                entity.content = preview.content
//                entity.body = preview.body
//                entity.brows = preview.brows
//                entity.eyes = preview.eyes
//                entity.hairBottom = preview.hairBottom
//                entity.hairTop = preview.hairTop
//                entity.headdress = preview.headdress
//                entity.mouth = preview.mouth
//                entity.shoes = preview.shoes
//                entity.top = preview.top
//                entity.trousers = preview.trousers
//                entity.wings = preview.wings
//            }
//
//            saveContext_MGN()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }
//
//    func delete_MGN(character preview: CharacterPreview_MG) {
//        let fetchRequest = CharacterEntity.fetchRequest()
//        fetchRequest.predicate = .init(format: "%K == %@", "id",
//                                       preview.id as CVarArg)
//        fetchRequest.fetchLimit = 1
//
//        do {
//            if let entity = try managedContext_MGN.fetch(fetchRequest).first {
//                managedContext_MGN.delete(entity)
//            }
//        } catch let error as NSError {
//            print(error.localizedDescription)
//            managedContext_MGN.rollback()
//        }
//    }
//}
//
//// MARK: - Private API
//
//private extension ContentManager_MG {
//
//    func jsonObj_MGN(from data: Data, with key: String) -> Data? {
//        if let jsonDict = jsonDict_MGN(from: data),
//           let jsonObj = jsonDict[key],
//           let data = try? JSONSerialization.data(withJSONObject: jsonObj) {
//            return data
//        }
//
//        return nil
//    }
//
//    func jsonDict_MGN(from data: Data) -> [String: Any]? {
//        try? JSONSerialization.jsonObject(with: data) as? [String: Any]
//    }
//
//    func execute_MGN(deleteRequest: NSBatchDeleteRequest) -> Bool {
//        do {
//            try managedContext_MGN.execute(deleteRequest)
//            return true
//        } catch let error {
//            print(error.localizedDescription)
//            managedContext_MGN.rollback()
//            return false
//        }
//    }
//
//    func saveContext_MGN() {
//        guard managedContext_MGN.hasChanges else {
//            return
//        }
//
//        do {
//            try managedContext_MGN.save()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//            managedContext_MGN.rollback()
//        }
//    }
//}

