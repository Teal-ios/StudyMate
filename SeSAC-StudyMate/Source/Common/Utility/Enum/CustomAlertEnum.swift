//
//  CustomAlert.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/30.
//

import Foundation

enum CustomAlertString: Int {
    case withDrawTitle
    case withDrawSubtitle
    
}

extension CustomAlertString {
    var text: String {
        switch self {
        case .withDrawTitle:
            return "정말 탈퇴하시겠습니까?"
        case .withDrawSubtitle:
            return "탈퇴하시면 새싹 스터디를 이용할 수 없어요ㅜ"
        }
    }
}
