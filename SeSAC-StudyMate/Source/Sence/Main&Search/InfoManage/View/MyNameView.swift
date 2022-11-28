//
//  MyNameView.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/16.
//

import UIKit

import SnapKit
import Then

final class MyNameView: BaseView {
    
    // MARK: - Property
    
    let nameLabel = UILabel().then {
        $0.textColor = UIColor.black
        $0.font = UIFont.Title1_M16
        $0.text = "이병현"
    }
        
    let moreImageView = UIImageView().then {
        $0.image = ImageEnum.moreArrow_1.image
    }
        
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    
    // MARK: - Configure UI & Layout
    
    override func configureLayout() {
        self.addSubviews([nameLabel, moreImageView])

        nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(26)
        }
        
        moreImageView.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.trailing.equalToSuperview()
        }
    }
}
