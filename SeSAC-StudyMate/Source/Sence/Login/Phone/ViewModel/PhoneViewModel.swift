//
//  PhoneViewModel.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/08.
//

import Foundation
import RxCocoa
import RxSwift

class PhoneViewModel {
    var phoneNumber = BehaviorRelay<String>(value: "")
    
    func isPhone(phoneNumber: BehaviorRelay<String>) -> Bool {
          let regex = "^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$"
          return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: phoneNumber)
      }
}
