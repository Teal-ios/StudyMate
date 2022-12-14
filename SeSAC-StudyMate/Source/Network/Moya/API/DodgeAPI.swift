//
//  DodgeAPI.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/14.
//

import Moya
import Foundation

final class DodgeAPI {
    
    static let shared: DodgeAPI = DodgeAPI()
    
    private let MyPageProvider = MoyaProvider<APIQueueService>(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    
    func requestStudy(userID: String, completionHandler: @escaping (dodgeError?, Int?) -> Void) {
        MyPageProvider.request(.dodge(uid: userID)) { result  in

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
