//
//  MyDetailImageView.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/16.
//

import UIKit
import SnapKit
import Then

protocol uidDelegate {
    func uidDelegate(uid: String)
}

final class MyDetailImageView: BaseView {
    
    var delegate: uidDelegate?
    let viewModel = ResponseViewModel()
    var userID: String = ""
    
    func configure(data: FromQueueDB) {
        print("background#########",data.background)
        self.setBackgroundImage(background: data.background)
        self.setSeSACImage(sesac: data.sesac)
        delegate?.uidDelegate(uid: data.uid)
        self.userID = data.uid
    }
    
    
    // MARK: - Property
    let backgroundImageView = UIImageView().then {
        //        $0.contentMode = .scaleAspectFill
        //        $0.clipsToBounds = true
        //        $0.image = ImageEnum.background_4.image
        $0.makeCornerStyle(width: 0, color: .none, radius: 8)
    }
    
    let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        //        $0.image = ImageEnum.SeSACFace5.image
    }
    
    let settingButton = UIButton().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        
        $0.addTarget(self, action: #selector(requestButtonClicked), for: .touchUpInside)
        //        $0.backgroundColor = .requestButtonColor
    }
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: -  UI & Layout
    
    override func configureLayout() {
        self.addSubviews([backgroundImageView, profileImageView, settingButton])
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            //            make.width.equalTo(343)
            //            make.height.equalTo(194)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(194)
        }
        
        settingButton.snp.makeConstraints { make in
            make.top.equalTo(backgroundImageView.snp.top).inset(12)
            make.trailing.equalTo(backgroundImageView.snp.trailing).inset(12)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
    }
}

extension MyDetailImageView {
    func setBackgroundImage(background: Int) {
        self.backgroundImageView.contentMode = .scaleAspectFit
        self.backgroundImageView.clipsToBounds = true
        self.backgroundImageView.makeCornerStyle(width: 0, color: .none, radius: 8)
        
        switch background {
        case 0:
            self.backgroundImageView.image = ImageEnum.background_1.image
        case 1:
            self.backgroundImageView.image = ImageEnum.background_2.image
        case 2:
            self.backgroundImageView.image = ImageEnum.background_3.image
        case 3:
            self.backgroundImageView.image = ImageEnum.background_4.image
        case 4:
            self.backgroundImageView.image = ImageEnum.background_5.image
        default:
            self.backgroundImageView.image = ImageEnum.background_1.image
        }
    }
    func setSeSACImage(sesac: Int) {
        self.profileImageView.contentMode = .scaleAspectFill
        switch sesac {
        case 0:
            self.profileImageView.image = ImageEnum.SeSACFace1.image
        case 1:
            self.profileImageView.image = ImageEnum.SeSACFace2.image
        case 2:
            self.profileImageView.image = ImageEnum.SeSACFace3.image
        case 3:
            self.profileImageView.image = ImageEnum.SeSACFace4.image
        case 4:
            self.profileImageView.image = ImageEnum.SeSACFace5.image
        default:
            self.profileImageView.image = ImageEnum.SeSACFace1.image
        }
    }
}

extension MyDetailImageView {
    
    @objc func requestButtonClicked() {
        delegate?.uidDelegate(uid: self.userID)
        print(self.userID)
        if self.settingButton.backgroundColor == UIColor.requestButtonColor {
            UserDefaultsHelper.standard.uid = self.userID
            print("나의 uid")
            print(UserDefaultsHelper.standard.uid)
        } else {
            UserDefaultsHelper.standard.otherUid = self.userID
            print("상대방 uid")
            print(UserDefaultsHelper.standard.otherUid)
        }


//        if settingButton.backgroundColor == .requestButtonColor {
//            StudyRequestAPI.shared.requestStudy(userID: self.userID) { error, statusCode in
//                switch statusCode {
//                case 200 :
//                    print("success")
//                default:
//                    print(statusCode)
//                }
//            }
//        } else if settingButton.backgroundColor == .responseButtonColor {
//            StudyAcceptAPI.shared.requestStudy(userID: self.userID) { error, statusCode in
//                switch statusCode {
//                case 200 :
//                    print("success")
//                    print("Accept 통신",statusCode)
//                default:
//                    print("Accept 통신",statusCode)
//                }
//            }
//        } else {
//            return
//        }
    }
}
