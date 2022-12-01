//
//  ResponseView.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/01.
//

import UIKit

class ResponseView: BaseView {
    let imageView = UIImageView().then {
        $0.image = ImageEnum.emptyImage_near.image
    }
    
    override func configureUI() {
        self.addSubview(imageView)
    }
    
    override func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(265)
            make.height.equalTo(158)
        }
    }
}
