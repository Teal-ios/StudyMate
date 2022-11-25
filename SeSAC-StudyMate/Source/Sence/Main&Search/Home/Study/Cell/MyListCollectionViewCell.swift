//
//  MyListCollectionViewCell.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/24.
//

import UIKit
import SnapKit

final class MyListCollectionViewCell: BaseCollectionViewCell {
    
    let outerView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.brandGreen.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .brandGreen
        label.font = .Body2_R16
        label.textAlignment = .center
        return label
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.baseForegroundColor = .brandGreen
        configuration.baseBackgroundColor = .clear
        configuration.image = UIImage(systemName: "close_small")
        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 12)
        button.configuration = configuration
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    

    
    override func configureUI() {
        super.configureUI()
        
        [titleLabel, deleteButton].forEach {
            outerView.addSubview($0)
        }
        contentView.addSubview(outerView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        outerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
            make.size.equalTo(20)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(deleteButton.snp.leading).offset(-6)
            make.top.equalToSuperview().offset(4.5)
        }
    }
}
