//
//  InfoManageTabkeViewCell.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/16.
//

import UIKit
import MultiSlider
import SnapKit
import Then

protocol sliderDelegate: AnyObject {
    func slider(min: Int, max: Int)
}

final class InfoManageTableViewCell: BaseTableViewCell {
    
    // MARK: - Property
    
    weak var infoCellDelegate: sliderDelegate?
    
    var ageRange: String = "18 - 65" {
        didSet {
            rangeLabel.text = oldValue
        }
    }
    
    private let genderLabel = UILabel().then {
        $0.text = "내 성별"
    }
    
    let maleButton = PlainButton(.grayLine, height: .h48).then {
        $0.title = "남자"
        $0.addTarget(self, action: #selector(maleButtonClicked), for: .touchUpInside)
    }
    
    let femaleButton = PlainButton(.grayLine, height: .h48).then {
        $0.title = "여자"
        $0.addTarget(self , action: #selector(femaleButtonClicked), for: .touchUpInside)

    }
    
    private let studyLabel = UILabel().then {
        $0.text = "자주 하는 스터디"
    }
    
    let textField = UITextField().then {
        $0.font = UIFont.Title4_R14
        $0.textColor = .black
        $0.borderStyle = .none
        $0.placeholder = "스터디를 입력해 주세요"
    }
    
    private let lineView = UIView().then {
        $0.backgroundColor = UIColor.grayScale3
    }
    
    private let numberLabel = UILabel().then {
        $0.text = "내 번호 검색 허용"
    }
    
    let numberSwitch = UISwitch().then {
        $0.isOn = true
        $0.onTintColor = UIColor.brandGreen

    }
    
    private let ageLabel = UILabel().then {
        $0.text = "상대방 연령대"
    }
    
    let ageSlider = MultiSlider().then {
        $0.orientation = .horizontal
        $0.minimumValue = 18
        $0.maximumValue = 65
        $0.outerTrackColor = UIColor.grayScale2
        $0.value = [1, 65]
        $0.tintColor = UIColor.brandGreen
        $0.trackWidth = 4
        $0.showsThumbImageShadow = true
        $0.thumbImage = UIImage(named: "filter_control")
        $0.keepsDistanceBetweenThumbs = true
        $0.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
    }
    
    let rangeLabel = UILabel().then {
        $0.font = UIFont.Title3_M14
        $0.textColor = UIColor.brandGreen
        $0.text = "18 - 65"
    }
    
    let withdrawButton = UIButton()
    
    private let withdrawLabel = UILabel().then {
        $0.text = "회원탈퇴"
    }
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    // MARK: - Configure UI & Layout
    
    override func configureUI() {
        super.configureUI()
        configureMenuLabel([genderLabel, studyLabel, numberLabel, ageLabel, withdrawLabel])
        
    }
    
    override func configureLayout() {
                contentView.addSubviews([genderLabel, maleButton, femaleButton, studyLabel, textField, lineView,
                                         numberLabel, numberSwitch,
                                         ageLabel, rangeLabel, ageSlider,
                                         withdrawLabel])
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(24)
            make.leading.equalToSuperview()
        }
        
        maleButton.snp.makeConstraints { make in
            make.centerY.equalTo(genderLabel.snp.centerY)
            make.width.equalTo(56)
            make.trailing.equalTo(femaleButton.snp.leading).offset(-8)
        }
        
        femaleButton.snp.makeConstraints { make in
            make.centerY.equalTo(genderLabel.snp.centerY)
            make.width.equalTo(56)
            make.trailing.equalToSuperview()
        }
        
        studyLabel.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(42)
            make.leading.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.leading.equalTo(lineView.snp.leading)
            make.trailing.equalTo(lineView.snp.trailing)
            make.centerY.equalTo(studyLabel.snp.centerY)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(12)
            make.leading.equalTo(studyLabel.snp.trailing).offset(82)
            make.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(studyLabel.snp.bottom).offset(42)
            make.leading.equalToSuperview()
        }
        
        numberSwitch.snp.makeConstraints { make in
            make.centerY.equalTo(numberLabel.snp.centerY)
            make.trailing.equalToSuperview()
        }
        
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).offset(42)
            make.leading.equalToSuperview()
        }
        
        rangeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(ageLabel.snp.centerY)
            make.trailing.equalToSuperview()
        }
        
        ageSlider.snp.makeConstraints { make in
            make.top.equalTo(ageLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(13)
            make.height.equalTo(28)
        }
        
        withdrawLabel.snp.makeConstraints { make in
            make.top.equalTo(ageSlider.snp.bottom).offset(29)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().inset(67)
        }
    }
    
    // MARK: - Custom Method
    
    private func configureMenuLabel(_ label: [UILabel]) {
        label.forEach {
            $0.textColor = UIColor.black
            $0.font = UIFont.Title4_R14
        }
    }
    
    // MARK: - @objc
    
    @objc func sliderChanged(_ sender: MultiSlider) {
        print(sender.minimumValue, sender.maximumValue)
//        rangeLabel.text = "\(Int(sender.value[0]))" + " - " + "\(Int(sender.value[1]))"
        var min = ageSlider.value[0]
        var max = ageSlider.value[1]
        
        infoCellDelegate?.slider(min: Int(min), max: Int(max))
    }
    
    @objc func maleButtonClicked(_ sender: PlainButton) {
        if sender.backgroundColor == UIColor.white {
            self.buttonSettingGreen(sender)
            self.buttonSettingWhite(femaleButton)
        } else {
            if self.femaleButton.backgroundColor == .white {
                return
            } else {
                self.buttonSettingWhite(sender)
                self.buttonSettingGreen(femaleButton)
            }
        }
        
    }
    
    @objc func femaleButtonClicked(_ sender: PlainButton) {
        if sender.backgroundColor == UIColor.white {
            self.buttonSettingGreen(sender)
            self.buttonSettingWhite(maleButton)
        } else {
            if self.maleButton.backgroundColor == .white {
                return
            } else {
                self.buttonSettingWhite(sender)
                self.buttonSettingGreen(maleButton)
            }
        }
    }
    
    func buttonSettingWhite(_ sender: PlainButton) {
        sender.backgroundColor = UIColor.white
        sender.layer.borderWidth = 1
        sender.setTitleColor(.black, for: .normal)
    }
    
    func buttonSettingGreen(_ sender: PlainButton) {
        sender.backgroundColor = UIColor.brandGreen
        sender.layer.borderWidth = 0
        sender.setTitleColor(.white, for: .normal)
    }
}
