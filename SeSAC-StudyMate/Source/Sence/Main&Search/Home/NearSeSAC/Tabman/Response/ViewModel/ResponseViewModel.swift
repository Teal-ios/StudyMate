//
//  ResponseViewModel.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/04.
//

import Foundation

final class ResponseViewModel: uidDelegate {
    
    var userID: String = ""
    
    func uidDelegate(uid: String) {
        userID = uid
    }
    
    func requestButtonClicked() {
        StudyRequestAPI.shared.requestStudy(userID: userID) { error, statusCode in
            switch statusCode {
            case 200 :
                print("success")
            default:
                print(statusCode)
            }
        }
    }
}
