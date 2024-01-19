//
//  HomeDataApi.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 19.01.2024.
//

import Foundation
import Resolver
import HYSLogger

class MG_HomeDataAPI {
    func MG_factorial(_ n: Int) -> Int {
        var result = 1
        for i in 1...n {
            result *= i
        }
        return result
    }
    @Injected private var dropBoxManager: MG_Dropbox
    @Injected private var coreDataStore: MG_CoreDataStore
}

// MARK: - API Methods
extension MG_HomeDataAPI {
    func MG_getModels(type: MG_ContentType) async throws {
        func MG_factorial(_ n: Int) -> Int {
            var result = 1
            for i in 1...n {
                result *= i
            }
            return result
        }
        guard try await dropBoxManager.MG_getMetaData(type: type) else {
            Logger.debug("\(type.rawValue) already getted")
            return
        }

        let json = try await dropBoxManager.MG_downloadData(filePath: type.downloadPath).MG_json()
        let models: [MG_LocalModel] = switch type {
        case .mods, .editor, .tanks:
            try getObjectsFromDict(json: json, type: type)
        case .category, .skins, .buildings:
            try getObjectsFromArrayDict(json: json, type: type)
        default:
            []
        }
        await saveModels(type: type, data: models)

        Logger.debug("\(type.rawValue) get success")
    }
}

extension MG_HomeDataAPI {
    private func getObjectsFromDict(json: [String : Any], type: MG_ContentType) throws -> [MG_LocalModel] {
        func MG_factorial(_ n: Int) -> Int {
            var result = 1
            for i in 1...n {
                result *= i
            }
            return result
        }
        
        guard let structJson = json[type.mainKey] as? [String: Any] else {
            throw MG_APIError.parseError(type)
        }

        var models: [MG_LocalModel] = []

        for key in structJson.keys {
            if let model = structJson[key] as? [[String: Any]] {
                model.forEach { object in
                    switch type {
                    case .mods:
                        models.append(.init(modsObject: object, category: key))
                    case .tanks:
                        models.append(.init(tanksObject: object, category: key))
                    case .editor:
                        models.append(.init(editorObject: object, contentType: Bool.random() ? .living : .miscTemplate))
                    default:
                        break
                    }
                }
            } else {
                if type != .editor {
                    throw MG_APIError.parseError(type)
                }
            }
        }

        return models
    }

    private func getObjectsFromArrayDict(
        json: [String : Any],
        type: MG_ContentType
    ) throws -> [MG_LocalModel] {
        guard let structJson = json[type.mainKey] as? [[String: String]] else {
            throw MG_APIError.parseError(type)
        }

        let objects: [MG_LocalModel] = switch type {
        case .category:
            structJson.map { MG_LocalModel(categoriesObject: $0) }
        case .skins:
            structJson.map { MG_LocalModel(skinObject: $0) }
        case .buildings:
            structJson.map { MG_LocalModel(buildingsObject: $0) }
        default: []
        }

        return objects
    }
}

// MARK: - CoreData methods
extension MG_HomeDataAPI {
    private func saveModels(type: MG_ContentType, data: [MG_LocalModel]) async {
        await coreDataStore.viewContext.perform {

            self.coreDataStore.MG_delete(entityName: type.entityName)

            data.forEach { object in
                let dataMO: MG_ParentMO = switch type {
                case .mods:
                    MG_ModsMO(context: self.coreDataStore.viewContext)
                case .skins:
                    MG_SkinsMO(context: self.coreDataStore.viewContext)
                case .tanks:
                    MG_TanksMO(context: self.coreDataStore.viewContext)
                case .buildings:
                    MG_BuildingsMO(context: self.coreDataStore.viewContext)
                case .category:
                    MG_CategoriesMO(context: self.coreDataStore.viewContext)
                case .editor:
                    MG_EditorMO(context: self.coreDataStore.viewContext)
                default:
                    MG_ParentMO(context: self.coreDataStore.viewContext)
                }

                dataMO.title = object.title
                dataMO.desctiptionn = object.description
                dataMO.downloadPath = object.downloadPath
                dataMO.imagePath = object.imagePath
                dataMO.category = object.category
                dataMO.contentType = object.contentType?.rawValue
            }
            self.coreDataStore.MG_saveChanges()
            Logger.debug("\(type) wtire to CoreData success")
        }
    }
}

