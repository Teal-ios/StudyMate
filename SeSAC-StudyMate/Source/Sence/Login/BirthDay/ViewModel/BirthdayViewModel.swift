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

}
