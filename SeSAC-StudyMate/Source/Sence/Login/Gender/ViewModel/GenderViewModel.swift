//
//  GenderViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/09.
//

import Foundation
import RxCocoa
import RxSwift

class GenderViewModel {
    var gender = BehaviorRelay<Int>(value: 0)
    var genderValidation: BehaviorSubject<Bool> = BehaviorSubject(value: false)

    var inputGender: BehaviorSubject<Int> = BehaviorSubject(value: 3)
    
    func genderValidationCheck(text: Int) {
        inputGender.onNext(text)
        if text == 0 || text == 1 {
            genderValidation.onNext(true)
        } else {
            genderValidation.onNext(false)
        }
    }
}
