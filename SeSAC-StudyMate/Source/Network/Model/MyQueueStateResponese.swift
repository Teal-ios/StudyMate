//
//  MyQueueStateResponese.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/21.
//

import Foundation

// MARK: - MyQueueStateResponese
struct MyQueueStateResponese: Codable {
    let dodged, matched, reviewed: Int
    let matchedNick, matchedUid: String
}

