//
//  APIChatService.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/05.
//

import Foundation
import Moya

enum APIChatService {
    case sendChat(chat: String)
    case responseChat
}

extension APIChatService: TargetType {
    // base url
    var baseURL: URL {
        return URL(string: "http://api.sesac.co.kr:1210")!
    }
    
    var version: String {
        return "/v1"
    }
    
    // base url 뒤로 붙는 각 API 별 path parameter
    var path: String {
        switch self {
        case .sendChat:
            return "\(version)/chat/\(UserDefaultsHelper.standard.uid ?? "")"
        case .responseChat:
            return "\(version)/chat/{from}?lastchatDate={lastchatDate}"
        }
    }
    
    // header
    var headers: [String : String]? {
        return ["Content-Type": "application/x-www-form-urlencoded", "idtoken" : UserDefaultsHelper.standard.idToken!]
    }
    
    //MARK: method (.get, .post, .delete, .patch 등의 어떤 통신을 할 것인가?)
    var method: Moya.Method {
        switch self {
        case .sendChat:
            return .post
        case .responseChat:
            return .get

        }
    }
    
    //MARK: 서버를 연결하기 전의 Mock Data
    var sampleData: Data {
        return Data()
    }
    
    //MARK: 요청
    var task: Moya.Task {
        switch self {
        case .sendChat(let chat):
            return .requestParameters(parameters: ["chat": chat], encoding: URLEncoding.default)
        case .responseChat:
            return .requestPlain
        }
    }
}
