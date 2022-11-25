//
//  SLPError.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/24.
//

import Foundation

enum SLPError: Int, Error {
    case success = 200
    case alreadyUser = 201
    case nicknameError = 202
    case expiredTokenError = 401
    
    case notCurrentUserError = 406
    case serverError = 500
    case clientError = 501
}
