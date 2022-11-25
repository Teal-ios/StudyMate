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
import CoreLocation

class HomeView: BaseView{


    let genderFilterView = UIStackView().then {
        $0.backgroundColor = .brandGreen
        $0.makeCornerStyle(radius: 8)
        $0.makeShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor, radius: 1, offset: CGSize(width: 0, height: 1), opacity: 1)    }
    
    let gpsButton = UIButton().then {
        $0.setImage(UIImage(named: "place"), for: .normal)
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
        $0.makeCornerStyle(radius: 8)
        $0.makeShadow(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor, radius: 1, offset: CGSize(width: 0, height: 1), opacity: 1)
    }
    
    let statusButton = UIButton().then {
        $0.setImage(UIImage(named: "Property 1=default"), for: .normal)
    }
    
    let fakeImgPinView = UIImageView().then {
        $0.image = UIImage(named: "map_marker")
        $0.contentMode = .scaleAspectFit
    }

    let map = MKMapView()
    
    override func configureUI() {
        [map, genderFilterView, gpsButton, statusButton, fakeImgPinView].forEach{ addSubview($0) }        
    }
    
    override func setConstraints() {
        map.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        genderFilterView.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.top.equalTo(self.safeAreaLayoutGuide).inset(52)
            make.width.equalTo(48)
            make.height.equalTo(48*3)
        }
        
        gpsButton.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.top.equalTo(genderFilterView.snp.bottom).offset(16)
            make.height.width.equalTo(48)
        }
        
        statusButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(self.safeAreaLayoutGuide).inset(16)
            make.width.height.equalTo(64)
        }
        
        fakeImgPinView.snp.makeConstraints { make in
            make.centerX.equalTo(map)
            make.centerY.equalTo(map)
            make.width.height.equalTo(48)
        }

    }   
}
