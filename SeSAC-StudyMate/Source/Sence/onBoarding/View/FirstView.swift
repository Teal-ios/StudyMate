//
//  FirstView.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/07.
//

import UIKit
import Then
import SnapKit

class FirstView: BaseView {
    let explainLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = UIFont(name: "NotoSansKR-Regular", size: 24)
        $0.text = "위치 기반으로 빠르게\n주위 친구를 확인"
    }
    
    let ImageView = UIImageView().then {
        $0.image = UIImage(named: "onboarding_img1")
    }
    
    let pageControl = UIPageControl().then {
        $0.currentPage = 0
        $0.currentPageIndicatorTintColor = .grayScale6
        $0.backgroundColor = .grayScale2
        $0.numberOfPages = 3
        $0.isUserInteractionEnabled = false

    }

    let startButton = fillButton().then {
        $0.setTitle("시작하기", for: .normal)
    }
    
    override func configureUI() {
        [explainLabel, ImageView, pageControl, startButton].forEach {
            self.addSubview($0)
        }
        
    }
    
    override func setConstraints() {
        explainLabel.snp.makeConstraints { make in
            make.width.equalTo(205)
            make.height.equalTo(76)
            make.centerX.equalTo(ImageView)
            make.top.equalTo(safeAreaLayoutGuide).offset(100)
        }
        
        ImageView.snp.makeConstraints { make in
            make.top.equalTo(explainLabel.snp.bottom).offset(56)
            make.trailing.equalTo(8)
            make.leading.equalTo(-8)
            make.width.equalTo(ImageView.snp.height)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(ImageView.snp.bottom).offset(20)
            make.centerX.equalTo(ImageView)
            make.width.equalTo(80)
            make.height.equalTo(30)
        } 
        
        
    }
}
