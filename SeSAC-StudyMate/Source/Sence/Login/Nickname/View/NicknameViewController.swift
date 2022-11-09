//
//  NicknameViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/09.
//

import UIKit
import RxSwift
import RxCocoa

class NicknameViewController: BaseViewController {

    let mainview = NicknameView()
    let viewModel = NicknameViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validButtonBind()
    }
    
    override func loadView() {
        super.view = mainview
        mainview.backgroundColor = .white
    }
    
    func validButtonBind() {
        mainview.phoneTextField.rx.text
            .orEmpty
            .asDriver()
            .drive(viewModel.nickname)
            .disposed(by: disposeBag)

        let validation = mainview.phoneTextField.rx.text
            .orEmpty
            .map { $0.count <= 10 }
        
        
        validation
            .withUnretained(self)
            .bind { (vc, value) in
                let color: UIColor = value ? .brandGreen : .grayScale3
                let lineColor: UIColor = value ? .black : .grayScale3
                vc.mainview.baseButton.backgroundColor = color
                vc.mainview.lineView.backgroundColor = lineColor
            }
            .disposed(by: disposeBag)
    }
}
