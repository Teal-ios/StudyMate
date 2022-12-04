//
//  ResponseAlertViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/04.
//

import UIKit

class ResponseAlertViewController: CustomAlertViewController {
    
    var userID:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        mainview.responseButtonDelegate = self

        mainview.titleLabel.text = "스터디를 요청할게요!"
        mainview.subtitleLabel.text = "상대방이 요청을 수락하면 채팅방에서 대화를 나눌 수 있어요."
        
    }
    
    override func loadView() {
        view = mainview
    }
    
    func configureFromQueueDBDate(data: FromQueueDB) {
        self.userID = data.uid
    }
}

extension ResponseAlertViewController: responseButtonDelegate, uidProtocol {
    func uidDelegate(uid: String) {
        self.userID = uid
    }
    
    func cancelButtonTapped(tap: Bool) {
        if tap {
            self.dismiss(animated: true)
        }
    }
    
    func okButtonTapped(tap: Bool) {
        let vc = ResponseViewController()
        vc.uidDelegate = self
        print("니아이디가 뭐이니?",self.userID)
        StudyRequestAPI.shared.requestStudy(userID: self.userID) { error, statusCode in
            switch statusCode {
            case 200 :
                print("지금 이게 성공한거 맞제?")
                print("success")
            default:
                print(statusCode)
            }
        }
        if tap {
            let VC = MyDetailImageView()
            if VC.settingButton.backgroundColor == .requestButtonColor {
                StudyRequestAPI.shared.requestStudy(userID: self.userID) { error, statusCode in
                    switch statusCode {
                    case 200 :
                        print("지금 이게 성공한거 맞제?")
                        print("success")
                    default:
                        print(statusCode)
                    }
                }
            } else if VC.settingButton.backgroundColor == .responseButtonColor {
                StudyAcceptAPI.shared.requestStudy(userID: self.userID) { error, statusCode in
                    switch statusCode {
                    case 200 :
                        print("success")
                        print("Accept 통신",statusCode)
                    default:
                        print("Accept 통신",statusCode)
                    }
                }
            } else {
                return print("아무것도아임다")
            }
        }
        self.dismiss(animated: true)
    }
        
}
