//
//  WithDrawAlertViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/30.
//

import UIKit
import Toast

final class WithDrawAlertViewController: CustomAlertViewController {
        
//    let baseAlertView = CustomAlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        mainview.withDrawButtonDelegate = self
        
    }
    
    override func configure() {
        mainview.titleLabel.text = CustomAlertString.withDrawTitle.text
        mainview.subtitleLabel.text = CustomAlertString.withDrawSubtitle.text
    }
}

extension WithDrawAlertViewController: withDrawButtonDelegate {
    func cancelButtonTapped(tap: Bool) {
        print(tap)
        if tap {
            self.dismiss(animated: true)
        }
    }
    
    func okButtonTapped(tap: Bool) {
        WithDrawAPI.shared.requestWithDraw { error, statusCode in
            switch statusCode {
            case 200:
                print("회원 탈퇴 성공")
                self.transition(OnBoardingViewController(), transitionStyle: .presentFullScreen)
                UserDefaultsHelper.standard.removeObject()

            case 406:
                self.transition(OnBoardingViewController(), transitionStyle: .presentFullScreen)
                
            default:
                print("예외처리안햇음. \(statusCode)")
            }
        }
    }
}

 
