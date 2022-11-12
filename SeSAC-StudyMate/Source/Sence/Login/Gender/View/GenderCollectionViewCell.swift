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
    
    override var isSelected: Bool {
        didSet {
            isSelectedCell()
        }
    }
    
    func isSelectedCell() {
        if isSelected {
            self.backgroundColor = .brandYellowGreen
        } else {
            self.backgroundColor = .white
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(genderImg)
        contentView.addSubview(genderLabel)
        genderImg.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(genderImg.snp.bottom).inset(20)
            make.leading.equalTo(genderImg.snp.leading).inset(8)
            make.trailing.equalTo(genderImg.snp.trailing).inset(8)
            make.bottom.equalTo(genderImg.snp.bottom).inset(4)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
