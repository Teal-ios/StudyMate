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
    var phoneNumber = ""
    var inputNumber: BehaviorSubject<String> = BehaviorSubject(value: "")
    var numValidation: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    private var verificationID: String?
    
    func correctCode(code: String) -> Bool {
        return code == verificationID
    }
    
    func validationCheck(text: String) {
        inputNumber.onNext(text)
        if text.count == 6 {
            numValidation.onNext(true)
        } else {
            numValidation.onNext(false)
        }
    }
    
    func verifyID(code: String?) {
        guard let code = code else { return }
        
        PhoneAuthProvider.provider().verifyPhoneNumber(code, uiDelegate: nil) { (varification, error) in
            if error == nil {
                self.verificationID = varification
            } else {
                print("Phone Varification Error:\(error.debugDescription)")
            }
            
        }
    }
}
