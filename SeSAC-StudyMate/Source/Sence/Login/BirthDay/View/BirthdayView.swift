//
//  BirthdayView.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/09.
//

import UIKit

class BirthdayView: BaseView {
    
    let baseLabel = UILabel().then {
        $0.font = .Display1_R20
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.text = "생년월일을 알려주세요"
    }
    
    let baseButton = disableButton().then { button in
        button.setTitle("다음", for: .normal)
        DispatchQueue.main.async {
            button.layer.cornerRadius = 8
        }
    }
    
    let yearTextField = UITextField().then {
        $0.placeholder = "1990"
        $0.keyboardType = .numberPad
    }
    
    let yearLineView = UIView().then {
        $0.backgroundColor = .grayScale3
    }
    
    let yearLabel = UILabel().then {
        $0.text = "년"
    }
    
    let monthTextField = UITextField().then {
        $0.placeholder = "1"
        $0.keyboardType = .numberPad
    }
    
    
    let monthLineView = UIView().then {
        $0.backgroundColor = .grayScale3
    }
    
    let monthLabel = UILabel().then {
        $0.text = "월"
    }
    
    let dayTextField = UITextField().then {
        $0.placeholder = "1"
    }
    
    let dayLineView = UIView().then {
        $0.backgroundColor = .grayScale3
    }
    
    let dayLabel = UILabel().then {
        $0.text = "일"
    }
    
    override func configureUI() {
        [baseLabel, baseButton, yearTextField, yearLineView, yearLabel, monthTextField, monthLineView, monthLabel, dayTextField, dayLineView, dayLabel].forEach {
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

        yearTextField.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(300)
            make.height.equalTo(48)
            make.width.equalTo(80)
        }
        
        yearLineView.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom)
            make.height.equalTo(1)
            make.leading.equalTo(16)
            make.width.equalTo(80)

        }
        
        yearLabel.snp.makeConstraints { make in
            make.height.equalTo(yearTextField.snp.height)
            make.width.equalTo(yearLabel.snp.height)
            make.leading.equalTo(yearTextField.snp.trailing).offset(4)
            make.top.equalTo(yearTextField.snp.top)
        }
        
        monthTextField.snp.makeConstraints { make in
            make.centerX.equalTo(baseLabel)
            make.top.equalTo(300)
            make.height.equalTo(48)
            make.width.equalTo(80)
        }
        
        monthLineView.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom)
            make.height.equalTo(1)
            make.centerX.equalTo(baseLabel)
            make.width.equalTo(80)

        }
        
        monthLabel.snp.makeConstraints { make in
            make.height.equalTo(yearTextField.snp.height)
            make.width.equalTo(yearLabel.snp.height)
            make.leading.equalTo(monthTextField.snp.trailing).offset(4)
            make.top.equalTo(monthTextField.snp.top)
        }
        
        dayTextField.snp.makeConstraints { make in
            make.trailing.equalTo(-32)
            make.top.equalTo(300)
            make.height.equalTo(48)
            make.width.equalTo(80)
        }
        
        dayLineView.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom)
            make.height.equalTo(1)
            make.trailing.equalTo(-32)
            make.width.equalTo(80)

        }
        
        dayLabel.snp.makeConstraints { make in
            make.height.equalTo(yearTextField.snp.height)
            make.width.equalTo(yearLabel.snp.height)
            make.trailing.equalTo(8)
            make.top.equalTo(dayTextField.snp.top)
        }
    }
}
