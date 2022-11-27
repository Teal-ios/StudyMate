//
//  matchedEnum.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/27.
//

import UIKit

enum matched: Int {
    case matched
    case notMatched
}

enum dodged: Int {
    case dodged
    case cancelStudy
}

enum matchState: Int {
    case matching
    case matched
    case normal
}
extension matchState {
    var imageName: UIImage? {
        switch self {
        case .matching:
            return UIImage(named: "Property 1=matching")
        case .matched:
            return UIImage(named: "Property 1=matched")
        case .normal:
            return UIImage(named: "Property 1=default")
        }
    }
}


//enum reviewed: Int {
//    case notReviewed
//    case reviewd
//}
