//
//  MyDetailImageView.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/16.
//

import UIKit

import SnapKit
import Then

final class MyDetailImageView: BaseView {
    
    // MARK: - Property
    let backgroundImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = ImageEnum.background_2.image
        $0.makeCornerStyle(width: 0, color: .none, radius: 8)
    }
    
    let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = ImageEnum.SeSACFace4.image
    }
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: -  UI & Layout
    
    override func configureLayout() {
        self.addSubviews([backgroundImageView, profileImageView])
        
        backgroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            make.width.equalTo(343)
            make.height.equalTo(194)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(194)
        }
    }
}
