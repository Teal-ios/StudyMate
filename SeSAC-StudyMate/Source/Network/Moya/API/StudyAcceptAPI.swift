//
//  StudyAcceopAPI.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/04.
//

import Moya
import Foundation

final class StudyAcceptAPI {
    
    // 싱글톤 패턴
    static let shared: StudyAcceptAPI = StudyAcceptAPI()
    
    // MoyaProvider라는 BaseProvider로 Provider를 구현하되, 조건(Target == API)에 따라 다양한 Provider를 생성해 구분된 네트워크 작업을 구현
    private let MyPageProvider = MoyaProvider<APIQueueService>(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    // 서버 연결 후 전달 받을 response
    
    func requestStudy(userID: String, completionHandler: @escaping (studyAcceptError?, Int?) -> Void) {
        MyPageProvider.request(.studyaccept(uid: userID)) { result  in

            switch result {
                
            case .success(let response):
                guard let statusCode = response.response?.statusCode else { return }
                completionHandler(.success, statusCode)

            case .failure(let error):
                guard let statusCode = error.response?.statusCode else { return }
                
                completionHandler(nil, statusCode)
            }
        }
    }
}
