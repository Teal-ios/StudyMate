//
//  PlaceHolder.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/24.
//

import Foundation

enum PlaceHolder {
    case searchBar
    case writeStudy
    case message
}

extension PlaceHolder {
    var text: String? {
        switch self {
        case .searchBar:
            return "띄어쓰기로 복수 입력이 가능해요."
        case .writeStudy:
            return "스터디를 입력해 주세요."
        case .message:
            return "메세지를 입력하세요"
        }
    }
}
