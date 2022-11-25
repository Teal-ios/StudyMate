//
//  QueueError.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/24.
//

import Foundation

enum QueueError: Int, Error {
    case success = 200
    case ProhibitionOfUse = 201
    case ReportPenaltyLV1 = 203
    case ReportPenaltyLV2 = 204
    case ReportPenaltyLV3 = 205
    
    case firebaseTokenRefresh = 401
    case notSignUp = 406
    case serverError = 500
    case clientError = 501
}

extension QueueError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .success:
            return "성공했습니다."
        case .firebaseTokenRefresh:
            return "토큰 갱신 필요"
        case .notSignUp:
            return "미가입 회원"
        case .serverError:
            return "Server Error"
        case .clientError:
            return "Client Error"
        case .ProhibitionOfUse:
            return "신고가 누적되어 이용하실 수 없습니다"
        case .ReportPenaltyLV1:
            return "스터디 취소 패널티로, 1분동안 이용하실 수 없습니다"
        case .ReportPenaltyLV2:
            return "스터디 취소 패널티로, 2분동안 이용하실 수 없습니다"
        case .ReportPenaltyLV3:
            return "스터디 취소 패널티로, 3분동안 이용하실 수 없습니다"
        }
    }
}
