//
//  TitleCategoryCollectionViewCell.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/16.
//

import UIKit

final class TitleCategoryCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Property
    
    var button = PlainButton(.grayLine, height: .h32)

    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    

    
    // MARK: - UI & Layout
    
    override func configureLayout() {
        contentView.addSubview(button)

        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - setupData
    
    func setupData(_ data: String) {
        button.setTitle(data, for: .normal)
    }
}
