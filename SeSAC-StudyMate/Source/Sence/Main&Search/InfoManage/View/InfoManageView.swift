//
//  InfoManageView.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/14.
//

import UIKit

class detailView: BaseView {
    
    let detailScrollerView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    let bgView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.grayScale2.cgColor
        $0.backgroundColor = .brandYellowGreen
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    let nameLabel = UILabel().then {
        $0.text = "김새싹"
    }
    
    let detailButton = UIButton().then {
        $0.setImage(UIImage(named: "check"), for: .normal)
    }
    
    override func configureUI() {
        [detailScrollerView, bgView, nameLabel, detailButton].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        detailScrollerView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(detailScrollerView).inset(0)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.edges.equalTo(bgView).inset(4)
        }
        
        detailButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.top)
            make.trailing.equalTo(nameLabel.snp.trailing)
            make.bottom.equalTo(nameLabel.snp.bottom)
            make.width.equalTo(24)
        }
    }
}

class InfoManageView: BaseView {
    
    let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    let backgroundImgView = UIImageView().then {
        $0.image = UIImage(named: "sesac_background_2")
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    let profileImgView = UIImageView().then {
        $0.image = UIImage(named: "sesac_face_3")
        $0.contentMode = .scaleAspectFit
    }
    
    let dynamicScrollerView = detailView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    let genderStackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .brandGreen
        return view
    }()
    
    let studyStackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .brandYellowGreen
        return view
    }()
    
    let phoneStackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .brandGreen
        return view
    }()
    
    let ageStackView: UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .brandYellowGreen
        return view
    }()
    
    let exitView: UIView = {
        let view = UIView()
        view.backgroundColor = .brandGreen
        return view
    }()
    
    override func configureUI() {
        [contentScrollView, backgroundImgView, profileImgView, dynamicScrollerView, genderStackView, studyStackView, phoneStackView, ageStackView, exitView].forEach {
            self.addSubview($0)
        }
    }
    
    override func setConstraints() {
        
        contentScrollView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        backgroundImgView.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(194)
        }
        
        profileImgView.snp.makeConstraints { make in
            make.width.height.equalTo(184)
            make.bottom.equalTo(backgroundImgView.snp.bottom)
            make.centerX.equalTo(backgroundImgView)
        }
        
        dynamicScrollerView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImgView.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(64)
        }
        
        genderStackView.snp.makeConstraints { make in
            make.top.equalTo(dynamicScrollerView.snp.bottom).offset(8)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(56)
        }
        
        studyStackView.snp.makeConstraints { make in
            make.top.equalTo(genderStackView.snp.bottom).offset(4)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(56)
        }
        
        phoneStackView.snp.makeConstraints { make in
            make.top.equalTo(studyStackView.snp.bottom).offset(4)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(56)
        }
        
        ageStackView.snp.makeConstraints { make in
            make.top.equalTo(phoneStackView.snp.bottom).offset(4)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(64)
        }
        
        exitView.snp.makeConstraints { make in
            make.top.equalTo(ageStackView.snp.bottom).offset(4)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            make.height.equalTo(56)
        }
    }
}
