//
//  BaseTableViewCell.swift
//  BHsplash
//
//  Created by 이병현 on 2022/10/31.
//

import UIKit
import SnapKit

open class BaseTableViewCell: UITableViewCell {
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        configureLayout()
        setConstraints()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() { }
    func configureLayout() { }
    func setConstraints() { }
}
