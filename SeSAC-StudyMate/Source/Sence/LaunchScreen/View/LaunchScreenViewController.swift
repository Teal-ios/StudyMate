//
//  LaunchScreenViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/14.
//

import UIKit
import RxSwift

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
            LoginAPI.shared.requestLoginData { data in
                print("@@@@@@@",data)
            }
            
            transition(MainTabBarViewController(), transitionStyle: .rootViewChanged)
        }
    }
}
