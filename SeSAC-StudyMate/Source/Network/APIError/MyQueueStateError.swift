//
//  MyQueueStateError.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/21.
//

import Foundation

enum MyQueueStateError: Int, Error {
    case matchingCheckingOK = 200
    case normalStatus = 201
    case firebaseTokenRefresh = 401
    case notSignUp = 406
    case serverError = 500
    case clientError = 501
}

extension MyQueueStateError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .matchingCheckingOK:
            return "매칭 상태 확인 성공"
        case .normalStatus:
            return "일반 상태"
        case .firebaseTokenRefresh:
            return "토큰 갱신 필요"
        case .notSignUp:
            return "미가입 회원"
        case .serverError:
            return "Server Error"
        case .clientError:
            return "Client Error"
        }
    }
}
