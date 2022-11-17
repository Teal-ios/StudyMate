//
//  requestLoginData.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/17.
//

import Moya
import Foundation

final class LoginAPI {
    
    // 싱글톤 패턴
    static let shared: LoginAPI = LoginAPI()
    
    // MoyaProvider라는 BaseProvider로 Provider를 구현하되, 조건(Target == API)에 따라 다양한 Provider를 생성해 구분된 네트워크 작업을 구현
    private let SLPProvider = MoyaProvider<APIService>(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    
    // 서버 연결 후 전달 받을 response
    var data: SLPModel?

    func requestLoginData(completionHandler: @escaping (Result<SLPModel?, LoginError> ) -> Void) {
        SLPProvider.request(.login) { result  in

            switch result {
                
            case .success(let response):
                guard let statusCode = response.response?.statusCode else { return }

                print("GET 성공", statusCode)
                print("idToken", UserDefaultsHelper.standard.idToken)
                do {
                    self.data = try response.map(SLPModel?.self)
                    guard let data = self.data else { return }
                    
                    // 해당 데이터를 함수 호출 뒤, 탈출 클로저로 쓸 수 있도록 전달
                    completionHandler(.success(data))
                } catch {
                    guard let error = LoginError(rawValue: statusCode) else { return }
                    completionHandler(.failure(error))
                    print("decode 실패")
                }
            case .failure(let error):
                guard let statusCode = error.response?.statusCode else { return }
                
                print("GET 실패", error.response?.statusCode)
            }
        }
    }
}
