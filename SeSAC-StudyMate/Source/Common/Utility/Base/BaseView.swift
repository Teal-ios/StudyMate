//
//  BaseView.swift
//  BHsplash
//
//  Created by 이병현 on 2022/10/31.
//

import UIKit
import SnapKit

open class BaseView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setConstraints()
        configureLayout()
        setupDelegate()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() { }
    func setConstraints() { }
    func configureLayout() { }
    func setupDelegate() { }
}
