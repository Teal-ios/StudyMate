//
//  FirstViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/07.
//

import UIKit

class FirstViewController: BaseViewController {
    let mainview = FirstView()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func loadView() {
        super.view = mainview
    }
}
