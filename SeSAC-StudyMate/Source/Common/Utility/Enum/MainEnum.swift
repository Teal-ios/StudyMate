//
//  MainEnum.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/28.
//

import Foundation

enum MainEnum {
    //MARK: - InfoManage
    case ageRange
    case myGender
    case man
    case female
    case opponentAge
    case withDrawal
    case frequentStudy
    case allowMyPhone
    case title
    case wantStudy
    case review
    case firstReview
    case nowAround
    case wantToDo
    case home
    case shop
    case friend
    case myInfo
}

extension MainEnum {
    var text: String {
        switch self {
            
        case .ageRange:
            return "18 - 65"
        case .myGender:
            return "내 성별"
        case .man:
            return "남자"
        case .female:
            return "여자"
        case .opponentAge:
            return "상대방 연령대"
        case .withDrawal:
            return "회원탈퇴"
        case .frequentStudy:
            return "자주 하는 스터디"
        case .allowMyPhone:
            return "내 번호 검색 허용"
        case .title:
            return "새싹 타이틀"
        case .wantStudy:
            return "하고 싶은 스터디"
        case .review:
            return "새싹 리뷰"
        case .firstReview:
            return "첫 리뷰를 기다리는 중이에요!"
        case .nowAround:
            return "지금 주변에는"
        case .wantToDo:
            return "내가 하고싶은"
        case .home:
            return "홈"
        case .shop:
            return "새싹샵"
        case .friend:
            return "새싹친구"
        case .myInfo:
            return "내정보"
        }
    }
}
