//
//  CustomAlertView.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/29.
//

import UIKit
import Then

protocol withDrawButtonDelegate: AnyObject {
    func cancelButtonTapped(tap: Bool)
    func okButtonTapped(tap: Bool)
}

protocol responseButtonDelegate: AnyObject {
    func cancelButtonTapped(tap: Bool)
    func okButtonTapped(tap: Bool)
}

class CustomAlertView: BaseView {
    
    var withDrawButtonDelegate: withDrawButtonDelegate?
    var responseButtonDelegate: responseButtonDelegate?
    
    let bgView = UIView().then {
        $0.layer.backgroundColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5).cgColor
    }
    
    let alertView = UIView().then {
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
        $0.backgroundColor = .white
    }
    
    var titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = UIFont.Body1_M16
        $0.textAlignment = .center
    }
    
    var subtitleLabel = UILabel().then {
        $0.textColor = UIColor(red: 0.533, green: 0.533, blue: 0.533, alpha: 1)
        $0.font = UIFont.Title4_R14
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }
    
    private lazy var buttonStackView = UIStackView(arrangedSubviews: [cancelButton, okButton]).then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .fill
        $0.distribution = .fillEqually

    }
    
    private lazy var cancelButton = PlainButton(.cancel, height: .h48).then {
        $0.title = "취소"
        $0.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
    }
    private lazy var okButton = PlainButton(.fill, height: .h48).then {
        $0.title = "확인"
        $0.addTarget(self, action: #selector(okButtonClicked), for: .touchUpInside)
    }
    
    override func configureUI() {
        [bgView, alertView, titleLabel, subtitleLabel, buttonStackView].forEach { addSubview($0) }
    }
    
    override func setConstraints() {
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        alertView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(bgView).inset(16)
            make.centerX.centerY.equalTo(bgView)
            make.height.equalTo(156)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(alertView).inset(16)
            make.height.equalTo(30)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(alertView).inset(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.height.equalTo(30)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalTo(alertView).inset(16)
        }
    }
    
    @objc func cancelButtonClicked(_ sender: PlainButton) {
        let tap = sender.isTouchInside
        withDrawButtonDelegate?.cancelButtonTapped(tap: tap)
        responseButtonDelegate?.cancelButtonTapped(tap: tap)
        print(sender.isTouchInside)
        print("제발눌려라")
    }
    
    @objc func okButtonClicked(_ sender: PlainButton) {
        print(sender.isTouchInside)
        withDrawButtonDelegate?.okButtonTapped(tap: sender.isTouchInside)
        responseButtonDelegate?.okButtonTapped(tap: sender.isTouchInside)
        print("제발눌려라")
    }
}
