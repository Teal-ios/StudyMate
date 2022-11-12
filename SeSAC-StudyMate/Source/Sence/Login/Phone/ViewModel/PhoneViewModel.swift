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

enum Country {
    case kr
    
    var CountryCode: String {
        switch self {
        case .kr:
            return "+82"
        }
    }
}

class PhoneViewModel {
    private var verificationID: String?
    
    var phoneNumber: String = ""
    var inputNumber: BehaviorSubject<String> = BehaviorSubject(value: "")
    var numValidation: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    func isPhone(phoneNumber: String) -> Bool {
        let regex = "^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$"
        
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: phoneNumber)
    }
    
    func addHypen(num: String) -> String {
        let numTen = num.toPhoneNumberPattern(pattern: "###-###-####", replacmentCharacter: "#")
        let numEleven = num.toPhoneNumberPattern(pattern: "###-####-####", replacmentCharacter: "#")
        
        if num.count < 13 {
            return numTen
        } else {
            return numEleven
        }
    }
    
    func validationCheck(text: String) {
        
        inputNumber.onNext(text)
        
        if text.count >= 12 && text.count <= 13 && text[0] == "0" && text[1] == "1" {
            numValidation.onNext(true)
        } else {
            numValidation.onNext(false)
        }
    }
    
    func verifyNum(num: String?) {
        
        guard let num = num else { return }
        
        PhoneAuthProvider.provider().verifyPhoneNumber(Country.kr.CountryCode + num, uiDelegate: nil) { (varification, error) in
            if error == nil {
                if let id = varification {
                    UserDefaults.standard.set("\(id)", forKey: "verificationID")
                }
                self.verificationID = varification
                print("성공")
            } else {
                print("Phone Varification Error:\(error.debugDescription)")
            }
        }
    }
    
    func verifyID(code: String?) {
        
        guard let code = code else { return }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID ?? "", verificationCode: code)
        
        Auth.auth().signIn(with: credential) { (success, error) in
            if error == nil {
                print(success ?? "")
                print("User Signed in...")
            } else {
                print(error.debugDescription)
            }
        }
    }
}
