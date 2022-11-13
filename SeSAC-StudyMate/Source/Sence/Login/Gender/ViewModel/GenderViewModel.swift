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
    func successGender(gender: Int) {
        UserDefaults.standard.set(gender, forKey: "gender")
        print("전화번호 : \(UserDefaults.standard.string(forKey: "phoneNumber"))")
        print("닉네임 : \(UserDefaults.standard.string(forKey: "nick"))")
        print("생일 : \(UserDefaults.standard.string(forKey: "birth"))")
        print("이메일 : \(UserDefaults.standard.string(forKey: "email"))")
        print("성별 : \(UserDefaults.standard.string(forKey: "gender"))")
       
        UserAPI.shared.postData()
    }
}
