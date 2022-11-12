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
    
    
    func validationCheck(text: String) {
        inputNumber.onNext(text)
        if text.count == 6 {
            numValidation.onNext(true)
        } else {
            numValidation.onNext(false)
        }
    }
    
    
    func requestIDToken() {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            
            if let error = error {
                return
            }
            
            guard let idToken = idToken else { return }
            UserDefaults.standard.set(idToken, forKey: "idToken")
            print("idToken",idToken)
        }
    }
}
