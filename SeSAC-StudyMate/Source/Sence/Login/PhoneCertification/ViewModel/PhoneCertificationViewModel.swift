//
//  PhoneCertificationViewModel.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/09.
//

import Foundation
import RxCocoa
import RxSwift
import FirebaseAuth

class PhoneCertificationViewModel {
    var phoneNumber = BehaviorRelay<String>(value: "")
    var verifyID: String?
    
    func handleDoneBtn(_ sender: Any, text: String) {
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
