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
}
