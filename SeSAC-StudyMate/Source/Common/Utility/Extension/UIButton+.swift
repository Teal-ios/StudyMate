//
//  UIButton+.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/07.
//

import UIKit
import Then

class customButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.titleLabel?.textAlignment = .center
    }
}

class inactiveButton: customButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.backgroundColor = .white
        self.titleLabel?.textColor = .black
        self.layer.borderColor = UIColor.grayScale4.cgColor
        self.layer.borderWidth = 1
    }
}

class fillButton: customButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.backgroundColor = .brandGreen
        self.titleLabel?.textColor = .white
    }
}

class outlineButton: customButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.backgroundColor = .white
        self.titleLabel?.textColor = .black
        self.layer.borderColor = UIColor.brandGreen.cgColor
        self.layer.borderWidth = 1
    }
}

class cancelButton: customButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.backgroundColor = .grayScale2
        self.titleLabel?.textColor = .black
    }
}

class disableButton: customButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        self.backgroundColor = .grayScale6
        self.titleLabel?.textColor = .grayScale3
    }
}
