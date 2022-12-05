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
    var chatData = BehaviorRelay<[Payload]>(value: [])
    
    func sendChat(chat: String) {
        SendChatAPI.shared.sendChat(chat: chat) { data, error, statusCode in
            switch statusCode {
            case 200:
                print("채팅보내기 성공",data)
                self.addChatData(chat: data ?? Payload(id: "", to: "", from: "", chat: "", createdAt: ""))
            default:
                print("채팅보내기 실패")
            }
        }
    }
    
    func addChatData(chat: Payload) {

        let chatPayload = Payload(id: chat.id, to: chat.to, from: chat.from, chat: chat.chat, createdAt: chat.createdAt)
        var data = [chatPayload]
        chatData.accept(data)

    }
}
