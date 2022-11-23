//
//  SearchError.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/23.
//

import Foundation

enum SearchError: Int, Error {
    case success = 200
    case firebaseTokenRefresh = 401
    case notSignUp = 406
    case serverError = 500
    case clientError = 501
}

extension SearchError: LocalizedError {
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
        }
    }
}
