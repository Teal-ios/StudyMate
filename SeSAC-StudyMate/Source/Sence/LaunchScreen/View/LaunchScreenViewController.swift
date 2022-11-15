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
    
    private let mainview = LaunchScreenView()
    private let viewModel = LaunchScreenViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchNetwork()
    }
    
    override func loadView() {
        super.view = mainview
        mainview.backgroundColor = .white
    }
    
}
