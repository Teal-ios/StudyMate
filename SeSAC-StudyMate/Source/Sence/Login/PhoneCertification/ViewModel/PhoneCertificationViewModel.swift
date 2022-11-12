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
    
//    func correctCode(code: String) -> Bool {
//        print(code)
//        return code == verificationID
//    }
    
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
        guard let verificationID = UserDefaults.standard.string(forKey: "verificationID") else { return }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
        
        logIn(credential: credential)
    }
    
    func logIn(credential: PhoneAuthCredential) {
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print(error.localizedDescription)
                    print("LogIn Failed...")
                } else {
                    print("LogIn Success!!")
                    print("###\(authResult!)")
                    UserDefaults.standard.set("\(authResult)", forKey: "authResult")
                }
            }
        }
    
}
