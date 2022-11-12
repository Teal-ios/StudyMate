//
//  EmailViewModel.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/09.
//

import Foundation
import RxCocoa
import RxSwift

class EmailViewModel {
    var email = BehaviorRelay<String>(value: "")
    var emailValidation: BehaviorSubject<Bool> = BehaviorSubject(value: false)

    var inputEmail: BehaviorSubject<String> = BehaviorSubject(value: "")
    
    func emailValidationCheck(text: String) {
        inputEmail.onNext(text)
        if text.contains("@") && text.contains(".") && text.count > 10 {
            emailValidation.onNext(true)
        } else {
            emailValidation.onNext(false)
        }
    }
}
