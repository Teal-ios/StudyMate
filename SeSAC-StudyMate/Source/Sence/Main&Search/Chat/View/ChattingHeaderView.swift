//
//  ChattingHeaderView.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/05.
//

import UIKit
import SnapKit

final class ChattingHeaderView: BaseView {
    let dateContainView = UIView().then {
        $0.backgroundColor = UIColor.grayScale7
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 14
    }
    
    let dateLabel = UILabel().then {
        $0.textAlignment = .center
        $0.textColor = .white
        $0.font = UIFont.Title5_M12
        $0.text = "1월 15일 토요일"
    }
    
    let matchView = UIView().then {
        $0.backgroundColor = .clear
    }
    
    let imgView = UIImageView().then {
        $0.image = ImageEnum.bell.image
        $0.tintColor = .grayScale7
    }
    
    let matchLabel = UILabel().then {
        $0.textColor = .grayScale7
        $0.font = UIFont.Title3_M14
        $0.textAlignment = .center
        $0.text = "고래밥님과 매칭되었습니다."
    }
    
    let subtitleLabel = UILabel().then {
        $0.textColor = .grayScale6
        $0.font = UIFont.Title4_R14
        $0.textAlignment = .center
        $0.text = "채팅을 통해 약속을 정해보세요:)"
    }
    
    override func configureUI() {
        dateContainView.addSubview(dateLabel)
        matchView.addSubviews([imgView,matchLabel])
        addSubviews([dateContainView, matchView, subtitleLabel])
    }
    
    override func setConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(4)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        dateContainView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.height.equalTo(28)
        }
        
        imgView.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.size.equalTo(16)
        }
        matchLabel.snp.makeConstraints { make in
            make.leading.equalTo(imgView.snp.trailing).offset(6)
            make.verticalEdges.trailing.equalToSuperview()
        }
        matchView.snp.makeConstraints { make in
            make.top.equalTo(dateContainView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(matchView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
    }
}
