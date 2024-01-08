////
////  LayoutConfigMG_.swift
////  ios-mod-gacha-ref-0-1
////
////  Created by Дима Губеня on 27.12.2023.
////
//
//import UIKit
//
//struct LayoutConfigMG_ {
//    let itemWidth: CGFloat
//    let itemHeight: CGFloat
//    let columns: Int
//    let interItemSpacing: CGFloat
//    let interGroupSpacing: CGFloat
//    let sectionInsets: UIEdgeInsets
//    
//    static let defaultPhoneInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//    static let defaultPadInsets = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 80)
//    
//    static func getItemWidth(with columns: Int, interItemSpacing: CGFloat, sectionInsets: UIEdgeInsets) -> CGFloat {
//        let totalSpacing = CGFloat(columns - 1) * interItemSpacing + sectionInsets.left + sectionInsets.right
//        let width = (UIScreen.main.bounds.width - totalSpacing) / CGFloat(columns)
//        return width
//    }
//}
//
//extension NSCollectionLayoutSection {
//    static func generateLayoutMG_N(for modelType: ContentTypeMG_) -> NSCollectionLayoutSection {
//        let config: LayoutConfigMG_
//        let deviceType = UIDevice.current.userInterfaceIdiom
//        switch (modelType, deviceType) {
//        case (.modsMG_n, .phone), (.miniGamesMG_n, .phone):
//            let itemWidth = LayoutConfigMG_.getItemWidth(with: 1, interItemSpacing: 0,
//                                                         sectionInsets: LayoutConfigMG_.defaultPhoneInsets)
//            config = LayoutConfigMG_(itemWidth: itemWidth, itemHeight: 136, columns: 1, interItemSpacing: 0,
//                                  interGroupSpacing: 20, sectionInsets: LayoutConfigMG_.defaultPhoneInsets)
//        case (.modsMG_n, .pad), (.miniGamesMG_n, .pad):
//            let itemWidth = LayoutConfigMG_.getItemWidth(with: 2, interItemSpacing: 30,
//                                                         sectionInsets: LayoutConfigMG_.defaultPadInsets)
//            config = LayoutConfigMG_(itemWidth: itemWidth, itemHeight: 233, columns: 2, interItemSpacing: 10,
//                                  interGroupSpacing: 20, sectionInsets: LayoutConfigMG_.defaultPadInsets)
//        case (.wallpapersMG_n, .phone):
//            let itemWidth = LayoutConfigMG_.getItemWidth(with: 3, interItemSpacing: 8.5,
//                                                         sectionInsets: LayoutConfigMG_.defaultPhoneInsets)
//            config = LayoutConfigMG_(itemWidth: itemWidth, itemHeight: itemWidth*1.67, columns: 3, interItemSpacing: 8.5,
//                                  interGroupSpacing: 20, sectionInsets: LayoutConfigMG_.defaultPhoneInsets)
//        case (.wallpapersMG_n, .pad):
//            let itemWidth = LayoutConfigMG_.getItemWidth(with: 4, interItemSpacing: 20,
//                                                         sectionInsets: LayoutConfigMG_.defaultPadInsets)
//            config = LayoutConfigMG_(itemWidth: itemWidth, itemHeight: itemWidth*1.67, columns: 4, interItemSpacing: 10,
//                                  interGroupSpacing: 20, sectionInsets: LayoutConfigMG_.defaultPadInsets)
//        case (.charactersMG_n, .phone), (.outfitIdeasMG_n, .phone), (.collectionsMG_n, .phone):
//            let itemWidth = LayoutConfigMG_.getItemWidth(with: 2, interItemSpacing: 10,
//                                                         sectionInsets: LayoutConfigMG_.defaultPhoneInsets)
//            config = LayoutConfigMG_(itemWidth: itemWidth, itemHeight: itemWidth, columns: 2, interItemSpacing: 10,
//                                     interGroupSpacing: 20, sectionInsets: LayoutConfigMG_.defaultPhoneInsets)
//        case (.charactersMG_n, .pad), (.outfitIdeasMG_n, .pad), (.collectionsMG_n, .pad):
//            let itemWidth = LayoutConfigMG_.getItemWidth(with: 3, interItemSpacing: 10,
//                                                         sectionInsets: LayoutConfigMG_.defaultPadInsets)
//            config = LayoutConfigMG_(itemWidth: itemWidth, itemHeight: itemWidth, columns: 3, interItemSpacing: 10,
//                                     interGroupSpacing: 20, sectionInsets: LayoutConfigMG_.defaultPadInsets)
//        default:
//            fatalError("Unsupported configuration")
//        }
//        
//        return generateLayoutMG_N(using: config)
//    }
//    
//    private static func generateLayoutMG_N(using config: LayoutConfigMG_) -> NSCollectionLayoutSection {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(config.itemWidth),
//                                              heightDimension: .absolute(config.itemHeight))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets(top: config.sectionInsets.top,
//                                                     leading: config.interItemSpacing/2,
//                                                     bottom: config.sectionInsets.bottom,
//                                                     trailing: config.interItemSpacing/2)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                               heightDimension: .absolute(config.itemHeight))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: config.columns)
//        group.interItemSpacing = .fixed(config.interItemSpacing)
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.contentInsets = NSDirectionalEdgeInsets(top: config.sectionInsets.top,
//                                                        leading: config.sectionInsets.left,
//                                                        bottom: config.sectionInsets.bottom,
//                                                        trailing: config.sectionInsets.right)
//        section.interGroupSpacing = config.interGroupSpacing
//        
//        return section
//    }
//}
//
