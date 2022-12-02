//
//  MyReviewView.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/16.
//

import UIKit

import SnapKit
import Then

final class MyReviewView: BaseView {
    
    func configure(data: FromQueueDB) {
        reviewLabel.text = data.reviews.first
    }
    
    // MARK: - Property
    
    private lazy var reviewStackView = UIStackView(arrangedSubviews: [reviewTitleLabel, reviewLabel]).then {
        $0.axis = .vertical
        $0.spacing = 16
        $0.alignment = .fill
    }
    
    private let reviewTitleLabel = UILabel().then {
        $0.textColor = UIColor.black
        $0.font = UIFont.Title6_R12
        $0.text = MainEnum.review.text
    }
    
    let reviewLabel = UILabel().then {
        $0.font = UIFont.Body3_R14
        $0.textColor = UIColor.grayScale6
    }
    
    private let reviewBottomView = UIView()

    let moreButton = UIButton().then {
        $0.setImage(ImageEnum.moreArrow.image, for: .normal)
    }

    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    // MARK: - Configure UI & Layout
    
    override func configureLayout() {
        self.addSubviews([reviewStackView, moreButton])
        
        reviewStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        reviewLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(reviewTitleLabel.snp.top)
            make.trailing.equalToSuperview()
        }
    }
}
