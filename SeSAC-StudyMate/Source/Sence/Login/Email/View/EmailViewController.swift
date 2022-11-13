//
//  EmailViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/09.
//

import UIKit
import RxSwift
import RxCocoa

class EmailViewController: BaseViewController {

    let mainview = EmailView()
    let viewModel = EmailViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviSet()
    }
    
    override func loadView() {
        super.view = mainview
        mainview.backgroundColor = .white
        validButtonBind()
    }
    override func configure() {
        mainview.phoneTextField.addTarget(self, action: #selector(inputEmailTextFieldChanged), for: .editingChanged)
    }
    
    func validButtonBind() {
        viewModel.emailValidation
            .asDriver(onErrorJustReturn: false)
            .map { $0 == true ? UIColor.brandGreen : UIColor.grayScale6 }
            .drive(mainview.baseButton.rx.backgroundColor)
            .disposed(by: disposeBag)

        mainview.baseButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                
                vc.mainview.baseButton.backgroundColor == .brandGreen ? vc.sucess() : vc.mainview.makeToast("이메일의 형식이 맞지 않습니다.")
            }
    }

    @objc func inputEmailTextFieldChanged() {
        guard let text = mainview.phoneTextField.text else { return }
        viewModel.emailValidationCheck(text: text)
    }
    
    func sucess() {
        guard let email = mainview.phoneTextField.text else { return }
        print(email)
        viewModel.successEmail(email: email)
        self.transition(GenderViewController(), transitionStyle: .push)
    }

}
