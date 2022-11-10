//
//  BaseViewController.swift
//  BHsplash
//
//  Created by 이병현 on 2022/10/31.
//

import UIKit

open class BaseViewController: UIViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    func configure() { }
    
    func naviSet() {
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow"), style: .plain, target: self, action: nil)
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
}
