//
//  PhoneViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/08.
//

import UIKit
import RxSwift
import RxCocoa

class PhoneViewController: BaseViewController {

    let mainview = PhoneView()
    let viewModel = PhoneViewModel()
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
            .drive(viewModel.phoneNumber)
            .disposed(by: disposeBag)
        
        let validation = mainview.phoneTextField.rx.text
            .orEmpty
            .map { ($0.count >= 10 && $0.count <= 11) }
        
        
        validation
            .withUnretained(self)
            .bind { (vc, value) in
                let color: UIColor = value ? .brandGreen : .grayScale3
                vc.mainview.baseButton.backgroundColor = color
            }
            .disposed(by: disposeBag)
        
    }
}
