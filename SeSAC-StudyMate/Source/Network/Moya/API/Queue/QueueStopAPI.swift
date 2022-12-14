//
//  QueueStopAPI.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/14.
//

import Moya
import Foundation

final class queueStopAPI {
    
    // 싱글톤 패턴
    static let shared: queueStopAPI = queueStopAPI()
    
    // MoyaProvider라는 BaseProvider로 Provider를 구현하되, 조건(Target == API)에 따라 다양한 Provider를 생성해 구분된 네트워크 작업을 구현
    private let MyPageProvider = MoyaProvider<APIService>(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    // 서버 연결 후 전달 받을 response
    
    func requestQueueStop(completionHandler: @escaping (queueStopError?, Int?) -> Void) {
        MyPageProvider.request(.queueStop) { result  in

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
