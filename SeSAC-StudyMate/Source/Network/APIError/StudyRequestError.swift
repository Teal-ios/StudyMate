//
//  StudyRequestError.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/04.
//

import Foundation

enum studyRequestError: Int, Error {
    case success = 200
    case anotherMachingState = 201
    case anotherCancelState = 202
    
    case expiredTokenError = 401
    case notCurrentUserError = 406
    case serverError = 500
    case clientError = 501
}
