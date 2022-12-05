//
//  SendChatError.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/05.
//

import Foundation

enum SendChatError: Int, Error {
    case success = 200
    case stateNormal = 201

    case expiredTokenError = 401
    case notCurrentUserError = 406
    case serverError = 500
    case clientError = 501
}
