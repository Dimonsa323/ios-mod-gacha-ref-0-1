//
//  GeneralCardView.swift
//  mods-for-melon-playground-42
//
//  Created by Дима Губеня on 24.12.2023.
//

import SwiftUI

enum MG_GeneralCardAction {
    case favourite
    case pushDetail
    case pushEditor(Data)
    case share(CGRect)
    case download(CGRect)
}

struct MG_GeneralCardView: View {

    @State private var image: UIImage?

    let contentType: MG_ContentType
    let item: MG_ParentMO

    var action: MG_ValueClosure<MG_GeneralCardAction>

    var body: some View {
        VStack(spacing: 0) {
            cardImage
                .MG_iosDeviceTypePadding(edge: .bottom, iOSPadding: imageBottonPadding, iPadPadding: imageBottonPadding)

            if contentType != .editor {
                textBlock
                    .MG_iosDeviceTypePadding(edge: .horizontal, iOSPadding: 8, iPadPadding: 16, iPadIsAspect: true)
                    .MG_iosDeviceTypePadding(edge: .bottom, iOSPadding: 12, iPadPadding: 24)
                HStack(spacing: 12) {
                    favouriteButton

                    if contentType == .skins || contentType == .buildings {
                        downloadButton
                    }
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            if contentType == .editor {
                if let data = image?.pngData() {
                    action(.pushEditor(data))
                }
            } else {
                action(.pushDetail)
            }
        }
        .frame(maxWidth: .infinity)
        .MG_iosDeviceTypePadding(edge: .all, iOSPadding: 8, iPadPadding: 16, iPadIsAspect: true)
        .MG_addRoundedModifier(radius: isIPad ? 64 : 32, bgColor: .yellowMG)
    }
}

// MARK: - Child views
private extension MG_GeneralCardView {

    @ViewBuilder
    var cardImage: some View {
        RemoteImage(
            url: imageURL,
            size: .init(width: .zero, height: imageHeight),
            image: $image
        )
        .frame(maxWidth: .infinity)
        .padding(.vertical, imagePadding)
        .clipShape(
            RoundedRectangle(cornerRadius: isIPad ? 56 : 28)
        )
        .overlay {
            RoundedRectangle(cornerRadius: isIPad ? 56 : 28)
                .strokeBorder(Color.blackMG, lineWidth: isIPad ? 4 : 2)
        }
        .MG_addRoundedModifier(radius: isIPad ? 56 : 28, bgColor: .whiteMG)
    }

    var favouriteButton: some View {
        MG_LargeButton(
            text: favouriteButtonText,
            fontStyle: .MG_fontWithName(.nunito, style: .bold, size: isIPad ? 26 : 18),
            backgroundColor: .blackMG,
            foregroundColor: .whiteMG,
            height: isIPad ? 76 : 48,
            alignment: .trailing,
            textAlignment: .leading,
            textPadding: (.leading, isIPad ? 22 : 24),
            action: {
                action(.favourite)
            },
            additionalContent: {
                MG_CircleButton(
                    image: favouriteButtonImage,
                    iOsButtonSize: 40,
                    ipaImagedSize: 30,
                    ipaButtonSize: 60,
                    bgColor: .yellowMG,
                    lineWidth: 0
                ) { }
                .MG_iosDeviceTypePadding(edge: .trailing, iOSPadding: 4, iPadPadding: 8)
            }
        )
    }

    var downloadButton: some View {
        GeometryReader { geo in
            MG_CircleButton(
                image: .iconDownload,
                iOsImageSize: 24,
                iOsButtonSize: 48,
                ipaImagedSize: 32,
                ipaButtonSize: 76,
                bgColor: .blackMG)
            {
                let rect = geo.frame(in: CoordinateSpace.global)
                if !item.isLoadedToPhone {
                    action(.download(rect))
                } else {
                    action(.share(rect))
                }
            }
            .foregroundStyle(.white)
        }
        .MG_iosDeviceTypeFrame(iOSWidth: 48, iOSHeight: 48, iPadWidth: 76, iPadHeight: 76)

    }

    var textBlock: some View {
        VStack(spacing: 0) {
            Text(item.title ?? "")
                .MG_iosDeviceTypeFont(font: .init(name: .nunito, style: .extraBold, iPhoneSize: 18, iPadSize: 32))
                .foregroundStyle(.blackMG)
                .MG_iosDeviceTypePadding(edge: .bottom, iOSPadding: 4, iPadPadding: 8)
                .multilineTextAlignment(.center)
                .lineLimit(1)

            if contentType != .skins {
                Text(item.desctiptionn ?? "")
                    .MG_iosDeviceTypeFont(font: .init(name: .nunito, style: .bold, iPhoneSize: 14, iPadSize: 24))
                    .foregroundStyle(.blackMG)
                    .lineLimit(1)
            }
        }
    }
}

// MARK: - Computed property
private extension MG_GeneralCardView {
    var favouriteButtonText: String {
        item.isFavourite ? "Favorite" : "Add to favorite"
    }

    var favouriteButtonImage: ImageResource {
        item.isFavourite ? .iconHeartFill : .iconHeart
    }

    var imageHeight: CGFloat {
        switch contentType {
        case .skins:
            MG_Utilities.shared.MG_widthWith(aspectRatio: isIPad ? 160/1024 : 80/390)
        default:
            MG_Utilities.shared.MG_widthWith(aspectRatio: isIPad ? 282/1024 : 141/390)
        }
    }

    var imagePadding: CGFloat {
        switch contentType {
        case .skins:
            isIPad ? 60 : 30
        default:
            0
        }
    }

    var imageURL: String {
        if contentType == .editor {
            let path = "/\(item.imagePath ?? "")".replacingOccurrences(of: "Mod_Editor", with: "Editor")
            return path
        } else {
            return "/\(contentType.folderName)/\(item.imagePath ?? "")"
        }
    }

    var imageBottonPadding: CGFloat {
        contentType == .editor ? 0 : (isIPad ? 24 : 12)
    }
}

#Preview {
    MG_GeneralContentView(selectedMenu: .mods)
        .environment(\.managedObjectContext, MG_CoreDataMockService.preview)
}
