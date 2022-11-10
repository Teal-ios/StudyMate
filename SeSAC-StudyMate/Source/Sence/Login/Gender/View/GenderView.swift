//
//  GenderView.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/09.
//

import UIKit

class GenderView: BaseView {
    
    let baseLabel = UILabel().then {
        $0.font = .Display1_R20
        $0.textAlignment = .center
        $0.text = "성별을 선택해 주세요"
    }
    
    let baseSecondLabel = UILabel().then {
        $0.font = .Title2_R16
        $0.textAlignment = .center
        $0.text = "새싹 찾기 기능을 이용하기 위해서 필요해요!"
        $0.textColor = .grayScale7
    }
    
    let baseButton = disableButton().then { button in
        button.setTitle("다음", for: .normal)
        DispatchQueue.main.async {
            button.layer.cornerRadius = 8
        }
    }
    
    let collectionView: UICollectionView = {
       let view = UICollectionView()
        view.backgroundColor = .systemOrange
        return view
    }()
    
    
    let lineView = UIView().then {
        $0.backgroundColor = .grayScale3
    }
    
    override func configureUI() {
        [baseLabel, baseSecondLabel, baseButton, collectionView, lineView].forEach {
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

        collectionView.snp.makeConstraints { make in
            make.trailing.equalTo(-16)
            make.leading.equalTo(16)
            make.top.equalTo(baseSecondLabel.snp.bottom).offset(20)
            make.bottom.equalTo(baseButton.snp.top).offset(-20)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.height.equalTo(1)
            make.trailing.equalTo(-16)
            make.leading.equalTo(16)
        }
    }
}
