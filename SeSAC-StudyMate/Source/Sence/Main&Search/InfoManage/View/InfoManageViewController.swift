//
//  InfoManageViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/14.
//
import UIKit
import SnapKit


class InfoManageViewController : BaseViewController {
    
    var mainview = InfoManageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    
    }
    
    override func loadView() {
        super.view = mainview
    }
}

