//
//  UIView+.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/16.
//

import UIKit

import Then

extension UIView {
    func addSubviews(_ components: [UIView]) {
        components.forEach { self.addSubview($0) }
    }
    
    func makeCornerStyle(width: CGFloat = 0,
                         color: CGColor? = nil,
                         radius: CGFloat = 1) {
        layer.borderWidth = width
        layer.borderColor = color
        layer.cornerRadius = radius
    }
    func makeShadow(color: CGColor = UIColor.black.cgColor,
                    radius: CGFloat,
                    offset: CGSize,
                    opacity: Float) {
        layer.shadowColor = color
        layer.shadowRadius = radius
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        clipsToBounds = false
    }
}
