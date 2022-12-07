//
//  ChatModel.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/05.
//

import Foundation

// MARK: - ChatList
struct ChatList: Codable {
    let payload: [Payload]
}

// MARK: - Payload
struct Payload: Codable {
    let id, to, from, chat: String
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case to, from, chat, createdAt
    }
}
