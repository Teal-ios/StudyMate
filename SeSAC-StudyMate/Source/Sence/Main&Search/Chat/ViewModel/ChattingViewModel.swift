//
//  ChattingViewModel.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/05.
//

import Foundation
import RxSwift
import RxCocoa

class ChattingViewModel {
    var chatData = BehaviorRelay<[Chat]>(value: [])
    
//    func addChatData(chat: Payload) {
//
//        let chatPayload = Payload(id: chat.id, to: chat.to, from: chat.from, chat: chat.chat, createdAt: chat.createdAt)
//        var temp = chatData.value
//        temp.append(chatPayload)
//        chatData.accept(temp)
//
//    }
}
