//
//  WithDrawError.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/30.
//

import Foundation

enum withDrawError: Int, Error {
    case success = 200
    
    case expiredTokenError = 401
    case notCurrentUserError = 406
    case serverError = 500
    case clientError = 501
}
