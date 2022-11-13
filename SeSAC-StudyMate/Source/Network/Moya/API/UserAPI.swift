//
//  UserAPI.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/13.
//


import Moya
import Foundation

final class UserAPI {
    
    // 싱글톤 패턴
    static let shared: UserAPI = UserAPI()
    
    // MoyaProvider라는 BaseProvider로 Provider를 구현하되, 조건(Target == API)에 따라 다양한 Provider를 생성해 구분된 네트워크 작업을 구현
    private let SLPProvider = MoyaProvider<APIService>(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    // 서버 연결 후 전달 받을 response
    
    func postData() {
        SLPProvider.request(.user) { result in
            switch result {
                
            case .success(_):
                print("POST 성공")
            case .failure(_):
                print("POST 실패")
            }
        }
    }
}
