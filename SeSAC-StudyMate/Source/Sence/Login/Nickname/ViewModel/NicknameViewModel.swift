//
//  NicknameViewModel.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/09.
//

import Foundation
import RxCocoa
import RxSwift

class NicknameViewModel {
    var nickname = BehaviorRelay<String>(value: "")
    var nicknameValidation: BehaviorSubject<Bool> = BehaviorSubject(value: false)

    var inputName: BehaviorSubject<String> = BehaviorSubject(value: "")
    
    func nicknameValidationCheck(text: String) {
        
        inputName.onNext(text)
        
        if text.count >= 1 && text.count <= 10 {
            nicknameValidation.onNext(true)
        } else {
            nicknameValidation.onNext(false)
        }
    }
}
