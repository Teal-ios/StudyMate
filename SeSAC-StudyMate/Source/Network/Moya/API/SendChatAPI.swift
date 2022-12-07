//
//  SendChatAPI.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/05.
//

import Moya
import Foundation

final class SendChatAPI {
    
    // 싱글톤 패턴
    static let shared: SendChatAPI = SendChatAPI()
    
    // MoyaProvider라는 BaseProvider로 Provider를 구현하되, 조건(Target == API)에 따라 다양한 Provider를 생성해 구분된 네트워크 작업을 구현
    private let MyPageProvider = MoyaProvider<APIChatService>(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    // 서버 연결 후 전달 받을 response
    
    var data: Chat?
    
    func sendChat(chat: String, to: String, completionHandler: @escaping (Chat?, SendChatError?, Int?) -> Void) {
        MyPageProvider.request(.sendChat(chat: chat, to: to)) { result in
            switch result {
                
                
            case .success(let response):
                guard let statusCode = response.response?.statusCode else { return }
                
                print("GET 성공", statusCode)
                do {
                    self.data = try response.map(Chat?.self)
                    guard let data = self.data else { return }
                    
                    // 해당 데이터를 함수 호출 뒤, 탈출 클로저로 쓸 수 있도록 전달
                    completionHandler(data, nil, statusCode)
                } catch {
                    guard let error = SendChatError(rawValue: statusCode) else { return }
                    completionHandler(nil, error, statusCode)
                    print("decode 실패")
                }
            case .failure(let error):
                guard let statusCode = error.response?.statusCode else { return }
                
                completionHandler(nil, nil, statusCode)
            }
        }
    }
}
