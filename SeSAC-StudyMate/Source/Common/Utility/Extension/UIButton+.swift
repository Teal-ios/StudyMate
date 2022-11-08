//
//  UIButton+.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/07.
//

import UIKit
import Then

class customButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class inactiveButton: customButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.titleLabel?.textColor = .black
        self.layer.borderColor = UIColor.grayScale4.cgColor
        self.layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class fillButton: customButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .brandGreen
        self.titleLabel?.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class outlineButton: customButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.titleLabel?.textColor = .black
        self.layer.borderColor = UIColor.brandGreen.cgColor
        self.layer.borderWidth = 1
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class cancelButton: customButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .grayScale2
        self.titleLabel?.textColor = .black
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class disableButton: customButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .grayScale6
        self.titleLabel?.textColor = .grayScale3
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
