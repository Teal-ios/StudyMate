//
//  DodgeError.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/14.
//

import Foundation

enum dodgeError: Int, Error {
    case success = 200
    case anotherMachingState = 201
    
    case expiredTokenError = 401
    case notCurrentUserError = 406
    case serverError = 500
    case clientError = 501
}
