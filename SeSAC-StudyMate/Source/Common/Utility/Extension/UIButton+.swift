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

import UIKit

/**
 PlainButton
 - 기본 버튼 시스템
 */

// MARK: - Enum
@frozen
enum HeightType {
    case h48
    case h32
    
    fileprivate var height: CGFloat {
        switch self {
        case .h48:
            return 48
        case .h32:
            return 32
        }
    }
}

@frozen
enum PlainButtonType {
    case fill // 배경색있는
    case outline // 테두리있는
    case grayLine
    case cancel // 취소버튼
    
    fileprivate var titleColor: UIColor {
        switch self {
        case .fill:
            return .white
        case .outline:
            return UIColor.brandGreen
        case .grayLine:
            return UIColor.black
        case .cancel:
            return UIColor.black
        }
    }
    
    fileprivate var backgroundColor: UIColor {
        switch self {
        case .fill:
            return UIColor.brandGreen
        case .outline:
            return .white
        case .grayLine:
            return .white
        case .cancel:
            return UIColor.grayScale2
        }
    }
    
    fileprivate var borderColor: UIColor {
        switch self {
        case .fill:
            return .clear
        case .outline:
            return UIColor.brandGreen
        case .grayLine:
            return UIColor.grayScale4
        case .cancel:
            return .clear
        }
    }
    
    fileprivate var borderWidth: CGFloat {
        switch self {
        case .fill, .cancel:
            return 0
        case .outline, .grayLine:
            return 1
        }
    }
    
    fileprivate var selectedColor: UIColor {
        switch self {
        case .fill:
            return UIColor.brandGreen
        case .outline:
            return .white
        case .grayLine:
            return UIColor.brandGreen
        case .cancel:
            return UIColor.grayScale2
        }
    }
}

final class PlainButton: UIButton {
    
    // MARK: - Property
    
    private var height: HeightType = .h48
    private var type: PlainButtonType = .fill
    
    var title: String? {
        didSet {
            setTitle(title, for: .normal)
        }
    }
        
    var isEnable: Bool = false {
        didSet {
            configureDisableColor(type: type)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            configureSelectedColor(type: type)
        }
    }
        
    // MARK: - Initializer
    
    init(_ type: PlainButtonType, height: HeightType) {
        super.init(frame: .zero)
        configureUI(type: type)
        configureLayout(height: height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func configureUI(type: PlainButtonType) {
        titleLabel?.font = UIFont.Body4_R12
        setTitleColor(type.titleColor, for: .normal)
        backgroundColor = type.backgroundColor
        makeCornerStyle(width: type.borderWidth, color: type.borderColor.cgColor, radius: 8)
        setTitleColor(UIColor.grayScale4, for: .highlighted)
    }
    
    private func configureLayout(height: HeightType = .h48) {
        snp.makeConstraints { make in
            make.height.equalTo(height.height)
        }
    }
    
    private func configureDisableColor(type: PlainButtonType) {
        let titleColor: UIColor = isEnable ? .white : UIColor.grayScale4
        setTitleColor(titleColor, for: .normal)
        backgroundColor = isEnable ? type.backgroundColor : UIColor.grayScale6
    }
    
    private func configureSelectedColor(type: PlainButtonType) {
        backgroundColor = isSelected ? type.selectedColor : type.backgroundColor
        makeCornerStyle(width: 0, color: type.borderColor.cgColor, radius: 8)
    }
}
