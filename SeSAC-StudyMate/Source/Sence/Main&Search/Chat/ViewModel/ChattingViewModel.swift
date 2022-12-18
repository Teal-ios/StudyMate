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
    
    func sendChat(chat: String, to: String) {
        SendChatAPI.shared.sendChat(chat: chat, to: to) { data, error, statusCode in
            switch statusCode {
            case 200:
                print("채팅보내기 성공",data)
                self.addChatData(chat: data ?? Chat(id: "", to: "", from: "", chat: "", createdAt: ""))
            default:
                print("채팅보내기 실패")
            }
        }
    }
    
    func fetchChat() {
//        responseChatAPI.shared.responseChat(from: <#T##String#>, lastchatDate: <#T##String#>, completionHandler: <#T##(ChatList?, responseChatError?, Int?) -> Void#>)
    }
    
    func addChatData(chat: Chat) {

        let chatPayload = Chat(id: chat.id, to: chat.to, from: chat.from, chat: chat.chat, createdAt: chat.createdAt)
        var data = [chatPayload]
        chatData.accept(data)

    }
    
    func tableViewCellCount() -> Int {
        return chatData.value.count
    }
}
