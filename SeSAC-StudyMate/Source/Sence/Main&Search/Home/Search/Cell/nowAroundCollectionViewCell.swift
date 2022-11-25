//
//  nowAroundCollectionViewCell.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/18.
//

import UIKit


final class nowAroundCollectionViewCell: BaseCollectionViewCell {
    
    // MARK: - Property
    
    let button = PlainButton(.grayLine, height: .h32)

    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
