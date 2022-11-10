//
//  PhoneViewModel.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/08.
//

import Foundation
import RxCocoa
import RxSwift
import FirebaseAuth

class PhoneViewModel {
    var phoneNumber = BehaviorRelay<String>(value: "")
    var verifyID: String?
    
    func isPhone(phoneNumber: String) -> Bool {
        let regex = "^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$"
        
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: phoneNumber)
    }
    
    func handleDoneBtn(text: String) {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verifyID ?? "", verificationCode: text )
        Auth.auth().signIn(with: credential) { (success, error) in
            if error == nil {
                print(success ?? "")
                print("User Singed in...")
            } else {
                print(error.debugDescription)
            }
        }
    }
}
