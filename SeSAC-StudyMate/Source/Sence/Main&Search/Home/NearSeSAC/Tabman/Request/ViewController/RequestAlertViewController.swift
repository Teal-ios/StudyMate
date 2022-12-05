//
//  RequestAlertViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/05.
//

import UIKit

class RequestAlertViewController: CustomAlertViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        mainview.responseButtonDelegate = self

        mainview.titleLabel.text = "스터디를 수락할까요?"
        mainview.subtitleLabel.text = "요청을 수락하면 채팅방에서 대화를 나눌 수 있어요."
        
    }
    
    override func loadView() {
        view = mainview
    }
    
}

extension RequestAlertViewController: responseButtonDelegate {
    
    func cancelButtonTapped(tap: Bool) {
        if tap {
            self.dismiss(animated: true)
        }
    }
    
    func okButtonTapped(tap: Bool) {
        StudyAcceptAPI.shared.requestStudy(userID: UserDefaultsHelper.standard.uid ?? "") { error, statusCode in
            switch statusCode {
            case 200 :
                print("지금 이게 성공한거 맞제?")
                print("success")
            default:
                print(statusCode)
            }
        }
        self.dismiss(animated: true)
    }
}
