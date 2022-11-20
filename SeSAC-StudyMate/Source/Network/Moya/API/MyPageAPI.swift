//
//  MyPageAPI.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/21.
//

import Moya
import Foundation

final class MyPageAPI {
    
    // 싱글톤 패턴
    static let shared: MyPageAPI = MyPageAPI()
    
    // MoyaProvider라는 BaseProvider로 Provider를 구현하되, 조건(Target == API)에 따라 다양한 Provider를 생성해 구분된 네트워크 작업을 구현
    private let MyPageProvider = MoyaProvider<APIService>(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    // 서버 연결 후 전달 받을 response
    
    func MyPageUpdate(completionHandler: @escaping (Int?, APIError?)->Void) {
        MyPageProvider.request(.mypage) { result  in
            
            switch result {
            case .success(let response):
                guard let statusCode = response.response?.statusCode else { return }
                print("PUT 성공", statusCode)
                completionHandler(statusCode, nil)
                
            case .failure(let error):
                guard let statusCode = error.response?.statusCode else { return }
                
                let apiError = APIError(rawValue: statusCode)
                completionHandler(nil, apiError)
                
                print("PUT 실패", error.response?.statusCode)
            }
        }
    }
}
