//
//  LayoutConfig_MG.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 27.12.2023.
//

import UIKit

struct LayoutConfig_MG {
    let itemWidth: CGFloat
    let itemHeight: CGFloat
    let columns: Int
    let interItemSpacing: CGFloat
    let interGroupSpacing: CGFloat
    let sectionInsets: UIEdgeInsets
    
    static let defaultPhoneInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    static let defaultPadInsets = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 80)
    
    static func getItemWidth(with columns: Int, interItemSpacing: CGFloat, sectionInsets: UIEdgeInsets) -> CGFloat {
        let totalSpacing = CGFloat(columns - 1) * interItemSpacing + sectionInsets.left + sectionInsets.right
        let width = (UIScreen.main.bounds.width - totalSpacing) / CGFloat(columns)
        return width
    }
}

extension NSCollectionLayoutSection {
    static func generateLayout_MGN(for modelType: ContentType_MG) -> NSCollectionLayoutSection {
        let config: LayoutConfig_MG
        let deviceType = UIDevice.current.userInterfaceIdiom
        switch (modelType, deviceType) {
        case (.mods_mgn, .phone), (.miniGames_mgn, .phone):
            let itemWidth = LayoutConfig_MG.getItemWidth(with: 1, interItemSpacing: 0,
                                                         sectionInsets: LayoutConfig_MG.defaultPhoneInsets)
            config = LayoutConfig_MG(itemWidth: itemWidth, itemHeight: 136, columns: 1, interItemSpacing: 0,
                                  interGroupSpacing: 20, sectionInsets: LayoutConfig_MG.defaultPhoneInsets)
        case (.mods_mgn, .pad), (.miniGames_mgn, .pad):
            let itemWidth = LayoutConfig_MG.getItemWidth(with: 2, interItemSpacing: 30,
                                                         sectionInsets: LayoutConfig_MG.defaultPadInsets)
            config = LayoutConfig_MG(itemWidth: itemWidth, itemHeight: 233, columns: 2, interItemSpacing: 10,
                                  interGroupSpacing: 20, sectionInsets: LayoutConfig_MG.defaultPadInsets)
        case (.wallpapers_mgn, .phone):
            let itemWidth = LayoutConfig_MG.getItemWidth(with: 3, interItemSpacing: 8.5,
                                                         sectionInsets: LayoutConfig_MG.defaultPhoneInsets)
            config = LayoutConfig_MG(itemWidth: itemWidth, itemHeight: itemWidth*1.67, columns: 3, interItemSpacing: 8.5,
                                  interGroupSpacing: 20, sectionInsets: LayoutConfig_MG.defaultPhoneInsets)
        case (.wallpapers_mgn, .pad):
            let itemWidth = LayoutConfig_MG.getItemWidth(with: 4, interItemSpacing: 20,
                                                         sectionInsets: LayoutConfig_MG.defaultPadInsets)
            config = LayoutConfig_MG(itemWidth: itemWidth, itemHeight: itemWidth*1.67, columns: 4, interItemSpacing: 10,
                                  interGroupSpacing: 20, sectionInsets: LayoutConfig_MG.defaultPadInsets)
        case (.characters_mgn, .phone), (.outfitIdeas_mgn, .phone), (.collections_mgn, .phone):
            let itemWidth = LayoutConfig_MG.getItemWidth(with: 2, interItemSpacing: 10,
                                                         sectionInsets: LayoutConfig_MG.defaultPhoneInsets)
            config = LayoutConfig_MG(itemWidth: itemWidth, itemHeight: itemWidth, columns: 2, interItemSpacing: 10,
                                     interGroupSpacing: 20, sectionInsets: LayoutConfig_MG.defaultPhoneInsets)
        case (.characters_mgn, .pad), (.outfitIdeas_mgn, .pad), (.collections_mgn, .pad):
            let itemWidth = LayoutConfig_MG.getItemWidth(with: 3, interItemSpacing: 10,
                                                         sectionInsets: LayoutConfig_MG.defaultPadInsets)
            config = LayoutConfig_MG(itemWidth: itemWidth, itemHeight: itemWidth, columns: 3, interItemSpacing: 10,
                                     interGroupSpacing: 20, sectionInsets: LayoutConfig_MG.defaultPadInsets)
        default:
            fatalError("Unsupported configuration")
        }
        
        return generateLayout_MGN(using: config)
    }
    
    private static func generateLayout_MGN(using config: LayoutConfig_MG) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(config.itemWidth),
                                              heightDimension: .absolute(config.itemHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: config.sectionInsets.top,
                                                     leading: config.interItemSpacing/2,
                                                     bottom: config.sectionInsets.bottom,
                                                     trailing: config.interItemSpacing/2)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(config.itemHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: config.columns)
        group.interItemSpacing = .fixed(config.interItemSpacing)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: config.sectionInsets.top,
                                                        leading: config.sectionInsets.left,
                                                        bottom: config.sectionInsets.bottom,
                                                        trailing: config.sectionInsets.right)
        section.interGroupSpacing = config.interGroupSpacing
        
        return section
    }
}

