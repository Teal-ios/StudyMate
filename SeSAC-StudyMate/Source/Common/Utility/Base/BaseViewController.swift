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
        setupDelegate()
    }
    
    func configure() {
        view.backgroundColor = .white
//        navigationController?.navigationBar.topItem?.title = " "
    }
    
    func naviSet() {
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow"), style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    func setupDelegate() { }
    
}
