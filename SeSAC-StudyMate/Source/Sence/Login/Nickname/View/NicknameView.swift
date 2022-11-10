//
//  NicknameView.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/09.
//

import UIKit

class NicknameView: BaseView {
    
    let baseLabel = UILabel().then {
        $0.font = .Display1_R20
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.text = "닉네임을 입력해 주세요"
    }
    
    let baseButton = disableButton().then { button in
        button.setTitle("다음", for: .normal)
        DispatchQueue.main.async {
            button.layer.cornerRadius = 8
        }
    }
    
    let phoneTextField = UITextField().then {
        $0.placeholder = "10개 이내로 입력"
        $0.keyboardType = .numberPad
    }
    
    let lineView = UIView().then {
        $0.backgroundColor = .grayScale3
    }
    
    override func configureUI() {
        [baseLabel, baseButton, phoneTextField, lineView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        baseLabel.snp.makeConstraints { make in
            make.top.equalTo(168)
            make.trailing.equalTo(-16)
            make.leading.equalTo(16)
            make.height.equalTo(80)
        }
        
        baseButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(418)
            make.height.equalTo(48)
            make.trailing.equalTo(-16)
            make.leading.equalTo(16)
        }

        phoneTextField.snp.makeConstraints { make in
            make.trailing.equalTo(-16)
            make.leading.equalTo(16)
            make.top.equalTo(300)
            make.height.equalTo(48)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom)
            make.height.equalTo(1)
            make.trailing.equalTo(-16)
            make.leading.equalTo(16)
        }
    }
    
}
