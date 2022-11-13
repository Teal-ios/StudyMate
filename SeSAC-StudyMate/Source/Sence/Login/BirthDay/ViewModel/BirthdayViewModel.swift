//
//  BirthdayViewModel.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/09.
//

import Foundation
import RxCocoa
import RxSwift

class BirthdayViewModel {
    var year = BehaviorRelay<String>(value: "")
    var month = BehaviorRelay<String>(value: "")
    var day = BehaviorRelay<String>(value: "")
    var selectDay = BehaviorSubject<String>(value: "")
    
//    var birthDay = BehaviorRelay<Date>(value: "YYYY-MM-DDTHH:mm:ss.SSSZ")
    var birthDayValidation: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    var inputDay: BehaviorSubject<String> = BehaviorSubject(value: "")


    func birthDayValidationCheck(selectDay: String) {
        
        inputDay.onNext(selectDay)
        if selectDay.count > 1 {
            birthDayValidation.onNext(true)
            print("####",self.selectDay.values)
        } else {
            birthDayValidation.onNext(false)
        }
    }
    
    func successBirthday(birthday: String) {
        UserDefaults.standard.set(birthday, forKey: "birth")
        print("생일 : \(UserDefaults.standard.string(forKey: "birth"))")
    }
}
