//
//  APIError.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/15.
//


import UIKit
import FirebaseAuth

@frozen
enum APIError: Int, Error {
    
    case success = 200
    case alreadyUser = 201
    case nicknameError = 202
    case expiredTokenError = 401
    case serverError = 500
    case clientError = 501
}

extension APIError: LocalizedError {
    private var errorDescription: String {
        switch self {
        case .success:
            return "성공"
        case .alreadyUser:
            return "중복된 닉네임 입니다."
        case .nicknameError:
            return "사용불가 닉네임"
        case .expiredTokenError:
            return "토큰이 만료되었습니다."
        case .serverError:
            return "서버에러입니다. 잠시만 기다려주세요."
        case .clientError:
            return "전부 입력했는지 확인해주세요."
        }
    }
}
