//
//  NearStudyCollectionViewCell.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/24.
//

import UIKit
import SnapKit

final class NearStudyCollectionViewCell: BaseCollectionViewCell {
    
    let outerView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.grayScale4.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .Body3_R14
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureUI() {
        super.configureUI()
        
        [outerView, titleLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        outerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4.5)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
    }
}
