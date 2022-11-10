//
//  GenderCollectionViewCell.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/10.
//

import UIKit
import SnapKit
import Then

class GenderCollectionViewCell: UICollectionViewCell {
    
    let genderLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .Title2_R16
    }
    
    let genderImg = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(genderLabel)
        contentView.addSubview(genderImg)
        genderImg.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(genderImg.snp.bottom)
            make.leading.equalTo(-20)
            make.trailing.equalTo(20)
            make.bottom.equalTo(0)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
