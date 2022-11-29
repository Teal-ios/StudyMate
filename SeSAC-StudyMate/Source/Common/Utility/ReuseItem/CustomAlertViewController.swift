//
//  CustomAlertViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/29.
//

import UIKit

class CustomAlertViewController: BaseViewController {
    
    let mainview = CustomAlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        view = mainview
    }
    
}
