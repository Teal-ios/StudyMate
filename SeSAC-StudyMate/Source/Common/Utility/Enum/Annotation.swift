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
            return UIImage(named: "sesac_face_1")
        case .strong:
            return UIImage(named: "sesac_face_2")
        case .mint:
            return UIImage(named: "sesac_face_3")
        case .purple:
            return UIImage(named: "sesac_face_4")
        case .gold:
            return UIImage(named: "sesac_face_5")
        }
    }
}
