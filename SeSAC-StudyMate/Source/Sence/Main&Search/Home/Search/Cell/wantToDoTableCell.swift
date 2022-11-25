//
//  wantToDoTableCell.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/18.
//

import UIKit
import SnapKit
import Then

final class wantToDoTableViewCell: BaseTableViewCell {
    
    // MARK: - Property
    
    private lazy var view = wantToDoView().then {
        $0.layer.borderColor = UIColor.brandGreen.cgColor
    }
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: -  UI & Layout
    
    override func configureLayout() {
        contentView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
                .priority(.low)
        }
    }
}
