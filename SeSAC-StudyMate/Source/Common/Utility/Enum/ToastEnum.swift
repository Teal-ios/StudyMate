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
        }
    }
}
