//
//  matchedEnum.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/27.
//

import UIKit

enum Matched: Int {
    case matched
    case notMatched
}

enum Dodged: Int {
    case dodged
    case cancelStudy
}

enum MatchState: Int {
    case matching
    case matched
    case normal
}
extension MatchState {
    var imageName: UIImage? {
        switch self {
        case .matching:
            return ImageEnum.MatchStateMatching.image
        case .matched:
            return ImageEnum.MatchStateMatched.image
        case .normal:
            return ImageEnum.MatchStateState.image
        }
    }
}
