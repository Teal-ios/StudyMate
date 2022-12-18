//
//  SocketIOManager.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/18.
//

import Foundation
import SocketIO

enum APIKey {
    static let url = "http://api.sesac.co.kr:2022/chats"
    static let socket = "http://api.sesac.co.kr:1210"
    static let header = UserDefaultsHelper.standard.idToken!
    static let userId = UserDefaultsHelper.standard.uid!
}

class SocketIOManager {
    static let shared = SocketIOManager()
    
    //서버와 메시지를 주고 받기 위한 클래스
    
    var manager: SocketManager!
    
    var socket: SocketIOClient!
    
    private init() {
        manager = SocketManager(socketURL: URL(string: APIKey.socket)!, config: [
//            .log(true),
            .extraHeaders(["auth": APIKey.header])
        ])
        
        socket = manager.defaultSocket // http://api.sesac.co.kr:2022/
        
        //연결
        socket.on(clientEvent: .connect) { data, ack in
            print("SOCKET IS CONNECTED", data, ack)
        }
        
        //연결 해제
        socket.on(clientEvent: .disconnect) { data, ack in
            print("SOCKET IS DISCONNECTED", data, ack)
        }
        
        //이벤트 수신
        socket.on("sesac") { dataArray, ack in
            print("SESAC RECEIVED", dataArray, ack)
            
            let data = dataArray[0] as! NSDictionary
            let id = data["id"] as! String
            let to = data["to"] as! String
            let from = data["from"] as! String
            let chat = data["chat"] as! String
            let createdAt = data["createdAt"] as! String
            
            print("CHECK >>>>", chat, to, from, createdAt)
            
            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: ["chat": chat, "id": id, "createdAt": createdAt, "to": to, "from": from])
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
}
