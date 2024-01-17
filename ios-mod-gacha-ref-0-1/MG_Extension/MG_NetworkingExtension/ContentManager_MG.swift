//
//  ContentManagerMG_.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 27.12.2023.
//

import Foundation
import CoreData

//final class ContentManagerMG_: NSObject {
//
//    lazy var managedContextMG_N: NSManagedObjectContext = {
//        persistentContainerMG_N.viewContext
//    }()
//
//    private lazy var persistentContainerMG_N: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "ContentCacheMG_")
//        container.loadPersistentStores { description, error in
//            if let error = error {
//                fatalError("Unable to load persistent stores: \(error)")
//            }
//        }
//        return container
//    }()
//
//    func getModelPathMG_(for imgPath: String) -> String {
//        String(format: "/%@", imgPath)
//    }
//
//    func getPathMG_(for contentType: ContentTypeMG_, imgPath: String) -> String {
//        switch contentType {
//        case .modsMG_n:
//            var originalString = imgPath
//            let replacementString = "TipsAndTricks"
//            if let range = originalString.range(of: "Tips_and_Tricks") {
//                originalString.replaceSubrange(range, with: replacementString)
//            }
//            return String(format: "/%@", originalString)
//        case .wallpapersMG_n, .editorMG_n:
//            return String(format: "/%@", imgPath)
//        default:
//            return String(format: "/%@/%@", contentType.associatedPath.rawValue, imgPath)
//        }
//    }
//
//    func getPathMG_(for contentType: ContentTypeMG_, filePath: String) -> String {
//        switch contentType {
//        case .modsMG_n:
//            return String(format: "/%@", filePath)
//        default: return ""
//        }
//    }
//
//    func serializedMG_N(markups data: Data) -> [EditorCodableContentListMG_] {
//        if let jsonObj = jsonObjMG_N(from: data, with: "dgsb-we3"),
//           let markups = try? JSONDecoder().decode([EditorCodableContentListMG_].self,
//                                                   from: jsonObj) {
//            return markups
//        }
//
//        return []
//    }
//
//    func fetchFavoritesMG_N(contentType: ContentTypeMG_) -> [String] {
//        let fetchRequest = FavoritesEntity.fetchRequest()
//        fetchRequest.predicate = .init(format: "contentType == %i", contentType.int64)
//        do {
//            let result = try managedContextMG_N.fetch(fetchRequest)
//            return result.compactMap { $0.id }
//        } catch let error as NSError {
//            print(error.localizedDescription)
//            return []
//        }
//    }
//
//    func storeFavoritesMG_N(with id: String, contentType: ContentTypeMG_) {
//        let fetchRequest = FavoritesEntity.fetchRequest()
//        fetchRequest.predicate = .init(format: "contentType == %i AND id == %@",
//                                       contentType.int64,
//                                       id as CVarArg)
//        fetchRequest.fetchLimit = 1
//
//        do {
//            if let entity = try managedContextMG_N.fetch(fetchRequest).first {
//                entity.id = id
//                entity.contentType = contentType.int64
//            } else {
//                let entity = FavoritesEntity(context: managedContextMG_N)
//                entity.id = id
//                entity.contentType = contentType.int64
//            }
//
//            saveContextMG_N()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }
//
//    func deleteFavoritesMG_N(with id: String, contentType: ContentTypeMG_) {
//        let fetchRequest = FavoritesEntity.fetchRequest()
//        fetchRequest.predicate = .init(format: "contentType == %i AND id == %@",
//                                       contentType.int64,
//                                       id as CVarArg)
//        fetchRequest.fetchLimit = 1
//
//        do {
//            if let entity = try managedContextMG_N.fetch(fetchRequest).first {
//                managedContextMG_N.delete(entity)
//            }
//        } catch let error as NSError {
//            print(error.localizedDescription)
//            managedContextMG_N.rollback()
//        }
//    }
//
//    func fetchCharactersMG_N() -> [CharacterPreviewMG_] {
//        let fetchRequest = CharacterEntity.fetchRequest()
//        do {
//            return try managedContextMG_N
//                .fetch(fetchRequest)
//                .compactMap { CharacterPreviewMG_(from: $0) }
//        } catch let error as NSError {
//            print(error.localizedDescription)
//            return []
//        }
//    }
//
//    func removeAllCharactersMG_N() {
//        let fetchRequest = CharacterEntity.fetchRequest()
//
//        do {
//            let characters = try managedContextMG_N.fetch(fetchRequest)
//
//            for character in characters {
//                managedContextMG_N.delete(character)
//            }
//
//            saveContextMG_N()
//            print("All characters removed successfully.")
//        } catch let error as NSError {
//            print("Error removing characters: \(error.localizedDescription)")
//        }
//    }
//
//    func storeMG_N(character preview: CharacterPreviewMG_) {
//        let fetchRequest = CharacterEntity.fetchRequest()
//        fetchRequest.predicate = .init(format: "%K == %@", "id",
//                                       preview.id as CVarArg)
//        fetchRequest.fetchLimit = 1
//
//        do {
//            if let entity = try managedContextMG_N.fetch(fetchRequest).first {
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
//                let entity = CharacterEntity(context: managedContextMG_N)
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
//            saveContextMG_N()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }
//
//    func deleteMG_N(character preview: CharacterPreviewMG_) {
//        let fetchRequest = CharacterEntity.fetchRequest()
//        fetchRequest.predicate = .init(format: "%K == %@", "id",
//                                       preview.id as CVarArg)
//        fetchRequest.fetchLimit = 1
//
//        do {
//            if let entity = try managedContextMG_N.fetch(fetchRequest).first {
//                managedContextMG_N.delete(entity)
//            }
//        } catch let error as NSError {
//            print(error.localizedDescription)
//            managedContextMG_N.rollback()
//        }
//    }
//}
//
//// MARK: - Private API
//
//private extension ContentManagerMG_ {
//
//    func jsonObjMG_N(from data: Data, with key: String) -> Data? {
//        if let jsonDict = jsonDictMG_N(from: data),
//           let jsonObj = jsonDict[key],
//           let data = try? JSONSerialization.data(withJSONObject: jsonObj) {
//            return data
//        }
//
//        return nil
//    }
//
//    func jsonDictMG_N(from data: Data) -> [String: Any]? {
//        try? JSONSerialization.jsonObject(with: data) as? [String: Any]
//    }
//
//    func executeMG_N(deleteRequest: NSBatchDeleteRequest) -> Bool {
//        do {
//            try managedContextMG_N.execute(deleteRequest)
//            return true
//        } catch let error {
//            print(error.localizedDescription)
//            managedContextMG_N.rollback()
//            return false
//        }
//    }
//
//    func saveContextMG_N() {
//        guard managedContextMG_N.hasChanges else {
//            return
//        }
//
//        do {
//            try managedContextMG_N.save()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//            managedContextMG_N.rollback()
//        }
//    }
//}

