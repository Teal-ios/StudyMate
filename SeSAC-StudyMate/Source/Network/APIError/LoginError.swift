//
//  LoginError.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/17.
//

import Foundation

enum LoginError: Int, Error {
    case FirebaseTokenError = 401
    case notSignUp = 406
    case serverError = 500
    case clientError = 501
}

extension LoginError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .FirebaseTokenError:
            return "id토큰이 만료되었습니다. 갱신해주세요"
        case .notSignUp:
            return "미가입 유저입니다."
        case .serverError:
            return "Server Error"
        case .clientError:
            return "Client Error"
        }
    }
}
