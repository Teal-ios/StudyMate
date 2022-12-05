//
//  QueueAPI.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/24.
//

import Moya
import Foundation

final class QueueAPI: locationDelegate {
    var dataLong: Double = 126.8854176553498
    var dataLat: Double = 37.52406613969246
    func location(lat: Double, long: Double) {
        dataLong = long
        dataLat = lat
        print("좌표 값",dataLong, dataLat)
    }

    // 싱글톤 패턴
    static let shared: QueueAPI = QueueAPI()
    
    // MoyaProvider라는 BaseProvider로 Provider를 구현하되, 조건(Target == API)에 따라 다양한 Provider를 생성해 구분된 네트워크 작업을 구현
    private let MyPageProvider = MoyaProvider<APIService>(plugins: [MoyaLoggingPlugin()])
    
    private init() { }
    // 서버 연결 후 전달 받을 response
    
    func requestQueueData(completionHandler: @escaping (Int?, QueueError?)->Void) {

        MyPageProvider.request(.queue(lat: dataLat, long: dataLong)) { result  in
            
            switch result {
            case .success(let response):
                guard let statusCode = response.response?.statusCode else { return }
                print("POST 성공", statusCode)
                completionHandler(statusCode, nil)
                
            case .failure(let error):
                guard let statusCode = error.response?.statusCode else { return }
                
                let apiError = QueueError(rawValue: statusCode)
                completionHandler(nil, apiError)
                
                print("POST 실패", error.response?.statusCode)
            }
        }
    }
}
