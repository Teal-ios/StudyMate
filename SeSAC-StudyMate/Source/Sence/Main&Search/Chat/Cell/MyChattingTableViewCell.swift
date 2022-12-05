//
//  MyChattingTableViewCell.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/05.
//

import UIKit
import SnapKit

final class MyChattingTableViewCell: BaseTableViewCell {
    let bgView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .brandGreen
    }
    
    let messageLabel = UILabel().then {
        $0.font = UIFont.Body3_R14
        $0.numberOfLines = 0
    }
    
    let dateLabel = UILabel().then {
        $0.font = UIFont.Body4_R12
        $0.textColor = .grayScale6
        $0.textAlignment = .center
    }
    
    override func configureUI() {
        bgView.addSubview(messageLabel)
        addSubviews([dateLabel, bgView])
    }
    
    override func setConstraints() {
        
        bgView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(12)
            make.trailing.equalToSuperview().inset(16)
            make.width.lessThanOrEqualToSuperview().multipliedBy(1)
        }
        
        bgView.setContentCompressionResistancePriority(.init(rawValue: 749), for: .horizontal)
        messageLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview().inset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalTo(bgView)
            make.trailing.equalTo(bgView.snp.leading).offset(-8)
            make.leading.greaterThanOrEqualTo(12)
        }
        
        dateLabel.setContentCompressionResistancePriority(.init(rawValue: 751), for: .horizontal)
    }
}
