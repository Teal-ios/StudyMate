//
//  ChattingView.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/05.
//

import UIKit
import Then
import SnapKit

class ChattingView: BaseView {
    
    let chattingTableView = UITableView().then {
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.sectionHeaderTopPadding = 0
        $0.backgroundColor = .white
        $0.bounces = false
        $0.allowsSelection =  false
        $0.rowHeight = UITableView.automaticDimension
    }
    
    let chattingTextField = UITextField().then {
        $0.backgroundColor = UIColor.grayScale1
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.font = UIFont.Body3_R14
        $0.placeholder = PlaceHolder.message.text
        $0.borderStyle = .none
        $0.textColor = .black
    }
    
    let sendButton = UIButton().then {
        $0.setImage(ImageEnum.sendButton_normal.image, for: .normal)
    }
    
    override func configureUI() {
        addSubviews([chattingTextField, sendButton, chattingTableView])
    }
    
    override func setConstraints() {
        chattingTextField.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview().inset(16)
            
        }
    }
}
