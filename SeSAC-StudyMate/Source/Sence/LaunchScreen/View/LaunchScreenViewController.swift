//
//  LaunchScreenViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/14.
//

import UIKit
import RxSwift
import FirebaseAuth

enum SceneType: String {
    case onboarding
    case auth
    case nick
    case home
}

final class LaunchScreenViewController: BaseViewController {
    
    var arr: SLPModel?
    
    private let mainview = LaunchScreenView()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginLogic()
    }
    
    override func loadView() {
        super.view = mainview
        mainview.backgroundColor = .white
    }
    
    func loginLogic() {
        if UserDefaultsHelper.standard.idToken == nil {
            transition(OnBoardingViewController(), transitionStyle: .rootViewChanged)
        } else {
            LoginAPI.shared.requestLoginData { data, error, statusCode in
                guard let statusCode = statusCode else { return }
                print("제발나와라이이이잉🔵🔵🔵🔵",statusCode)
                switch statusCode {
                case 401:
                    self.mainview.makeToast("\(LoginError(rawValue: statusCode)?.rawValue)")
                    self.idTokenRefresh()
                case 406:
                    self.transition(NicknameViewController(), transitionStyle: .rootViewChanged)
                case 500:
                    self.mainview.makeToast("\(LoginError(rawValue: statusCode)?.rawValue)")
                case 501:
                    self.mainview.makeToast("\(LoginError(rawValue: statusCode)?.rawValue)")
                default:
                    return self.mainview.makeToast("등록되지 않은 에러입니다.")
                }
            }
        }
    }
    
    func idTokenRefresh() {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
          if let error = error {
            print(error)
            return;
          }
            UserDefaultsHelper.standard.idToken = idToken
            print("refresh완료")
            self.transition(MainTabBarViewController(), transitionStyle: .rootViewChanged)
        }
    }
}
