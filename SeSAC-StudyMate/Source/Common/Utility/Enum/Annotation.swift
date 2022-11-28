//
//  Annotation.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/25.
//

import UIKit

enum Annotation: Int {
    case basic
    case strong
    case mint
    case purple
    case gold
}

extension Annotation {
    var imageName: UIImage? {
        switch self {
        case .basic:
            return ImageEnum.SeSACFace1.image
        case .strong:
            return ImageEnum.SeSACFace2.image
        case .mint:
            return ImageEnum.SeSACFace3.image
        case .purple:
            return ImageEnum.SeSACFace4.image
        case .gold:
            return ImageEnum.SeSACFace5.image
        }
    }
}
