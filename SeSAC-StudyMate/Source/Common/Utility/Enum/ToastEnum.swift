//
//  ToastEnum.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/28.
//

import Foundation

enum ToastEnum: Int {
    case notDefindError
    case refreshToken
    case OK
    case cancel
    case comingSoon
    case tooManyRegistration
    case duplicateValue
    case duplicateList
    case tooManyChracater
    case onlyBin
}

extension ToastEnum {
    var message: String {
        switch self {
        case .notDefindError:
            return "등록되지 않은 에러입니다."
        case .refreshToken:
            return "토큰 갱신 완료"
        case .OK:
            return "확인"
        case .cancel:
            return "취소"
        case .comingSoon:
            return "준비중입니다."
        case .tooManyRegistration:
            return "8개 이상 등록할 수 없습니다."
        case .duplicateValue:
            return "중복된 값은 등록할 수 없습니다."
        case .duplicateList:
            return "중복된 리스트입니다."
        case .tooManyChracater:
            return "8자 이상 등록이 불가능합니다."
        case .onlyBin:
            return "공백만 입력해주세요."
        }
    }
}
