//
//  SearchResponse.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/21.
//

import Foundation

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let fromQueueDB, fromQueueDBRequested: [FromQueueDB]
    let fromRecommend: [String]
}

// MARK: - FromQueueDB
struct FromQueueDB: Codable {
    let uid, nick: String
    let lat, long: Double
    let reputation: [Int]
    let studylist, reviews: [String]
    let gender, type, sesac, background: Int
}
