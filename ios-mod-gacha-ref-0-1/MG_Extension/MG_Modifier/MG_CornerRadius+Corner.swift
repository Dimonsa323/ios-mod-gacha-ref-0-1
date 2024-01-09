//
//  MG_CornerRadius+Corner.swift
//  ios-mod-gacha-ref-0-1
//
//  Created by Дима Губеня on 07.01.2024.
//

import SwiftUI

typealias MG_View = View

extension MG_View {
    func MG_cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        
        return clipShape( MG_RoundedCorner(radius: radius, corners: corners) )
    }
}

struct MG_RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )

        return Path(path.cgPath)
    }
}

