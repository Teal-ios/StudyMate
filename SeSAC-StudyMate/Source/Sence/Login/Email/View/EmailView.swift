//
//  EmailView.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/09.
//

import UIKit

class EmailView: BaseView {
    
    let baseLabel = UILabel().then {
        $0.font = .Display1_R20
        $0.textAlignment = .center
        $0.text = "이메일을 입력해 주세요"
    }
    
    let baseSecondLabel = UILabel().then {
        $0.font = .Title2_R16
        $0.textAlignment = .center
        $0.text = "휴대폰 번호 변경 시 인증을 위해 사용해요"
        $0.textColor = .grayScale7
    }
    
    let baseButton = disableButton().then { button in
        button.setTitle("다음", for: .normal)
        DispatchQueue.main.async {
            button.layer.cornerRadius = 8
        }
    }
    
    let phoneTextField = UITextField().then {
        $0.placeholder = "SeSAC@email.com"
        $0.keyboardType = .emailAddress
    }
    
    let lineView = UIView().then {
        $0.backgroundColor = .grayScale3
    }
    
    override func configureUI() {
        [baseLabel, baseSecondLabel, baseButton, phoneTextField, lineView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        baseLabel.snp.makeConstraints { make in
            make.top.equalTo(168)
            make.trailing.equalTo(-16)
            make.leading.equalTo(16)
            make.height.equalTo(40)
        }
        
        baseSecondLabel.snp.makeConstraints { make in
            make.top.equalTo(212)
            make.trailing.equalTo(-16)
            make.leading.equalTo(16)
            make.height.equalTo(40)
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
