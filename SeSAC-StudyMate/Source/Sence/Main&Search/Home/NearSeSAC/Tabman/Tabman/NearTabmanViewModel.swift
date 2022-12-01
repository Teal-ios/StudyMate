//
//  NearTabmanViewModel.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/01.
//

import Foundation
import RxCocoa
import RxSwift

class NearTabmanViewModel {
    
    var searchData = BehaviorRelay<SearchResponse>(value: SearchResponse(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
    
    var nick       = BehaviorRelay<String>(value: "")
    var reputation = BehaviorRelay<[Int]>(value: [])
    var studyList  = BehaviorRelay<[String]>(value: [])
    var reviews    = BehaviorRelay<[String]>(value: [])
    var gender     = BehaviorRelay<Int>(value: 0)
    var type       = BehaviorRelay<Int>(value: 0)
    var sesac      = BehaviorRelay<Int>(value: 0)
    var background = BehaviorRelay<Int>(value: 0)
    
    func spreadData() {
        searchData.value.fromQueueDB.forEach {
            self.nick.accept($0.nick)
            self.reputation.accept($0.reputation)
            self.studyList.accept($0.studylist)
            self.reviews.accept($0.reviews)
            self.gender.accept($0.gender)
            self.type.accept($0.type)
            self.sesac.accept($0.sesac)
            self.background.accept($0.background)
        }
    }
    
    func requestSearchData(lat: Double, long: Double) {
        SearchAPI.shared.requestSearchData(lat: lat, long: long) { data, error, statusCode in
            print("requestSearchData")
            guard let statusCode = statusCode else { return }
            print("☘️☘️☘️☘️☘️☘️☘️",data, statusCode, error)
            switch statusCode {
            case 200:
                guard let data = data else { return }
                self.searchData.accept(data)
                self.spreadData()
            default:
                print("에러당에러야")
            }
        }
    }
}
