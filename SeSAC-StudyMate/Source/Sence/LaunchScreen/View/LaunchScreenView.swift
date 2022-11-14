//
//  LaunchScreenView.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/14.
//

import UIKit

class LaunchScreenView: BaseView {
    let splashImgView = UIImageView().then {
        $0.image = UIImage(named: "splash_logo")
    }
    
    let textImgView = UIImageView().then {
        $0.image = UIImage(named: "txt")
    }
    
    override func configureUI() {
        [splashImgView, textImgView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        splashImgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(220)
            make.height.equalTo(264)
            make.top.equalTo(safeAreaLayoutGuide).offset(216)
            
        }
        
        textImgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(328)
            make.height.equalTo(112)
            make.top.equalTo(splashImgView.snp.bottom).offset(32)

        }
    }
}
