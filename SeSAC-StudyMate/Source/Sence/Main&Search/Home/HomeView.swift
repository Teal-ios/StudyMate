//
//  HomeView.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/18.
//

import Foundation
import UIKit
import SnapKit
import MapKit
import Then

class HomeView: BaseView{


    let myLocationButton = UIStackView().then {
        $0.backgroundColor = .brandGreen
        $0.makeCornerStyle(radius: 8)
        $0.makeShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor, radius: 1, offset: CGSize(width: 0, height: 1), opacity: 1)    }
    
    let sesacLocationButton = UIButton().then {
        $0.setImage(UIImage(named: "place"), for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
        $0.makeCornerStyle(radius: 8)
        $0.makeShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor, radius: 1, offset: CGSize(width: 0, height: 1), opacity: 1)
    }

//    let button: UIButton = {
//        let button = UIButton()
//        button.setImage("place", for: .normal)
//        button.makeShadow(radius: <#T##CGFloat#>, offset: <#T##CGSize#>, opacity: <#T##Float#>)
//        button.makeCornerStyle(r)
//        return button
//    }()
//
    let map = MKMapView()
    
    override func configureUI() {
        self.addSubview(map)
        self.addSubview(myLocationButton)
        self.addSubview(sesacLocationButton)
        
    }
    
    override func setConstraints() {
        map.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        myLocationButton.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.top.equalTo(self.safeAreaLayoutGuide).inset(52)
            make.width.equalTo(48)
            make.height.equalTo(48*3)
        }
        
        sesacLocationButton.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.top.equalTo(myLocationButton.snp.bottom).offset(16)
            make.height.width.equalTo(48)
        }

    }
    
    

    
}
