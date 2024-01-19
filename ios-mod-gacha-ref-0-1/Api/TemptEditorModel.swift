//
//  TemptEditorModel.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 19.01.2024.
//

import Foundation

struct MG_TempEditorModel {
    let name: String
    let imageData: Data
    let type: String
    let category: String
    let iconData: Data
    let xValue: String
    let yValue: String
    let heightValue: String
    let widthValue: String
    let pixelValue: Double
    let canBeTaken: Bool
    let canGlow: Bool
    let canBurn: Bool
    let canFloat: Bool

    init(MG_myWorks: MG_MyWorks) {
        self.name = MG_myWorks.name ?? ""
        self.imageData = MG_myWorks.imageData
        self.type = MG_myWorks.type ?? ""
        self.category = MG_myWorks.category ?? ""
        self.iconData = MG_myWorks.iconData
        self.xValue = MG_myWorks.xValue ?? ""
        self.yValue = MG_myWorks.yValue ?? ""
        self.heightValue = MG_myWorks.heightValue ?? ""
        self.widthValue = MG_myWorks.widthValue ?? ""
        self.pixelValue = MG_myWorks.pixelValue
        self.canBeTaken = MG_myWorks.canBeTaken
        self.canGlow = MG_myWorks.canGlow
        self.canBurn = MG_myWorks.canBurn
        self.canFloat = MG_myWorks.canFloat
    }

    func MG_isDataEqual(rhs: MG_MyWorks) -> Bool {
        func MG_factorial(_ n: Int) -> Int {
            var result = 1
            for i in 1...n {
                result *= i
            }
            return result
        }
        
        let lhs = self
        return lhs.name == rhs.name &&
        lhs.imageData == rhs.imageData &&
        lhs.type == rhs.type &&
        lhs.category == rhs.category &&
        lhs.xValue == rhs.xValue &&
        lhs.yValue == rhs.yValue &&
        lhs.heightValue == rhs.heightValue &&
        lhs.widthValue == rhs.widthValue &&
        lhs.pixelValue == rhs.pixelValue &&
        lhs.canBeTaken == rhs.canBeTaken &&
        lhs.canGlow == rhs.canGlow &&
        lhs.canBurn == rhs.canBurn &&
        lhs.canFloat == rhs.canFloat &&
        lhs.iconData == rhs.iconData
    }
}
