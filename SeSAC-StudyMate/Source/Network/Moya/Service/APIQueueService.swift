//
//  APIQueueService.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/04.
//

import Foundation
import Moya

enum APIQueueService {
    case studyrequest(uid: String)
    case studyaccept(uid: String)
    case dodge(uid: String)
}

extension APIQueueService: TargetType {
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
        case .studyaccept:
            return "\(version)/queue/studyaccept"
        case .studyrequest:
            return "\(version)/queue/studyrequest/"
        case .dodge:
            return "\(version)/queue/dodge"

        }
    }
    
    // header
    var headers: [String : String]? {
        return ["Content-Type": "application/x-www-form-urlencoded", "idtoken" : UserDefaultsHelper.standard.idToken!]
    }
    
    //MARK: method (.get, .post, .delete, .patch 등의 어떤 통신을 할 것인가?)
    var method: Moya.Method {
        switch self {
        case .studyaccept, .studyrequest, .dodge:
            return .post
            

        }
    }
    
    //MARK: 서버를 연결하기 전의 Mock Data
    var sampleData: Data {
        return Data()
    }
    
    //MARK: 요청
    var task: Moya.Task {
        switch self {
        case .studyaccept(let uid):
            return .requestParameters(parameters: ["otheruid":uid], encoding: URLEncoding.default)
        case .studyrequest(let uid):
            return .requestParameters(parameters: ["otheruid": uid], encoding: URLEncoding.default)
        case .dodge(let uid):
            return .requestParameters(parameters: ["otheruid": uid], encoding: URLEncoding.default)
        }
    }
}
