//
//  PhoneViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/08.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth

class PhoneViewController: BaseViewController {

    let mainview = PhoneView()
    let viewModel = PhoneViewModel()
    let disposeBag = DisposeBag()
    var verifyID: String?
    
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
                let lineColor: UIColor = value ? .black : .grayScale3
                vc.mainview.baseButton.backgroundColor = color
                vc.mainview.lineView.backgroundColor = lineColor
            }
            .disposed(by: disposeBag)
        
        mainview.baseButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.navigationController?.pushViewController(PhoneCertificationViewController(), animated: true)
            }
        
//        mainview.baseButton.rx.tap
//            .withUnretained(self)
//            .bind { (vc, _) in
//                vc.viewModel.handleDoneBtn(text: vc.mainview.phoneTextField.text ?? "")
//            }
    }
}
