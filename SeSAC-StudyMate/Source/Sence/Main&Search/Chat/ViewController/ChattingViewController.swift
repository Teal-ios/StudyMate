//
//  ChattingViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/05.
//

import UIKit

final class ChattingViewController: BaseViewController {
    var mainview = ChattingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavi()
    }
    
    override func loadView() {
        view = mainview
    }
    
    func setNavi() {
        //    //MARK: - Navi 설정
        navigationController?.isNavigationBarHidden = false
        let backButtonItem = UIBarButtonItem(image: ImageEnum.arrow.image, style: .plain, target: self, action: #selector(backButtonTapped))
        let menuButtonItem = UIBarButtonItem(image: ImageEnum.menu.image, style: .plain, target: self, action: #selector(menuButtonTapped))
        navigationItem.leftBarButtonItem = backButtonItem
        navigationItem.rightBarButtonItem = menuButtonItem
        navigationItem.title = "고래밥"


    }
    
    //MARK: - Obj-C
    @objc func backButtonTapped() {
        
    }
    
    @objc func menuButtonTapped() {
        
    }
}
