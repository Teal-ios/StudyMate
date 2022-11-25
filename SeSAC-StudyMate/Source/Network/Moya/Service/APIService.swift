//
//  APIService.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/13.
//

import Foundation
import Moya

// 영화 API에서 사용할 Service를 case 별로 관리
enum APIService {
    // 트렌드 미디어 API
    case user
    case login
    case withdraw
    case update_fcm_token
    case mypage
    case search
    case myQueueState
    case queue(lat: Double, long: Double)
    case queueStop
    
}


// TargetType이라는 protocol을 채택하면 -> 서버 통신 시 필요한 요소들을 채택해서 사용할 수 있도록 유도
extension APIService: TargetType {
    // base url
    var baseURL: URL {
        return URL(string: "http://api.sesac.co.kr:1210")!
    }
    
    // base url 뒤로 붙는 각 API 별 path parameter
    var path: String {
        switch self {
        case .user, .login:
            return "/v1/user"
        case .withdraw:
            return "/v1/user/withdraw"
        case .update_fcm_token:
            return "/v1/user/update_fcm_token"
        case .mypage:
            return "/v1/user/mypage"
        case .queue, .queueStop:
            return "/v1/queue"
        case .search:
            return "/v1/queue/search"
        case .myQueueState:
            return "/v1/queue/myQueueState"
        }
    }
    
    // header
    var headers: [String : String]? {
        return ["Content-Type": "application/x-www-form-urlencoded", "idtoken" : UserDefaultsHelper.standard.idToken!]
    }
    
    // method (.get, .post, .delete, .patch 등의 어떤 통신을 할 것인가?)
    var method: Moya.Method {
        switch self {
        case .user, .withdraw, .queue, .search:
            return .post
        case .mypage, .update_fcm_token:
            return .put
        case .login, .myQueueState:
            return .get
        case .queueStop:
            return .delete
        }
    }
    
    // 서버를 연결하기 전, mock data
    var sampleData: Data {
        return Data()
    }
    
    // request를 어떻게 가공해서 보낼 것인가?
    // 1. request body로 보낼 것인가?
    // 2. query parameter로 보낼 것인가?
    // 3. JSON으로 보낼 것인가? 등등 ..
    
    
    var task: Moya.Task {
        switch self {
        case .login:
            return .requestPlain
        case .user:
            return .requestParameters(parameters: ["phoneNumber" : UserDefaultsHelper.standard.phone!,
                                                   "FCMtoken" : UserDefaultsHelper.standard.FCMtoken!,
                                                   "nick" : UserDefaultsHelper.standard.nickname!,
                                                   "birth" : UserDefaultsHelper.standard.birthday!,
                                                   "email" : UserDefaultsHelper.standard.email!,
                                                   "gender" : UserDefaultsHelper.standard.gender
                                                  ], encoding: URLEncoding.default)
                
        case .withdraw:
            return .requestCompositeParameters(bodyParameters: ["phoneNumber" : UserDefaults.standard.string(forKey: "phoneNumber")!,
                                                                "FCMtoken" : UserDefaults.standard.string(forKey: "FCMtoken")!,
                                                                "nick" : UserDefaults.standard.string(forKey: "nick")!,
                                                                "birth" : UserDefaults.standard.string(forKey: "birth")!,
                                                                "email" : UserDefaults.standard.string(forKey: "email")!,
                                                                "gender" : UserDefaults.standard.integer(forKey: "gender")
                                                               ], bodyEncoding: URLEncoding.default, urlParameters: ["Content-Type": "application/x-www-form-urlencoded"])
        case .update_fcm_token:
            return .requestCompositeParameters(bodyParameters: ["phoneNumber" : UserDefaults.standard.string(forKey: "phoneNumber")!,
                                                                "FCMtoken" : UserDefaults.standard.string(forKey: "FCMtoken")!,
                                                                "nick" : UserDefaults.standard.string(forKey: "nick")!,
                                                                "birth" : UserDefaults.standard.string(forKey: "birth")!,
                                                                "email" : UserDefaults.standard.string(forKey: "email")!,
                                                                "gender" : UserDefaults.standard.integer(forKey: "gender")
                                                               ], bodyEncoding: URLEncoding.default, urlParameters: ["Content-Type": "application/x-www-form-urlencoded"])
        case .mypage:
            let mypage = InfoManageViewController().updateMypage
            return .requestParameters(parameters: ["searchable" : mypage.searchable, "ageMin" : mypage.ageMin, "ageMax" : mypage.ageMax, "gender" : mypage.gender, "study" : mypage.study ?? nil], encoding: URLEncoding.default)
        case .queue(let lat, let long):
            return .requestParameters(parameters: [
                "long": long,
                "lat": lat,
                "studylist":  ["아속피", "콘크리트", "anything"]]
                                   , encoding: URLEncoding(arrayEncoding: .noBrackets))
        case .queueStop:
            return .requestPlain
        case .search:
            return .requestParameters(parameters: ["lat": 37.51818789942772, "long" : 126.88541765534976], encoding: URLEncoding.default)
            
        case .myQueueState:
            return .requestPlain
        }
    }

}
