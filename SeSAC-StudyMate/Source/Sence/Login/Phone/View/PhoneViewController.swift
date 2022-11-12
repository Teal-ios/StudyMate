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
import Toast

class PhoneViewController: BaseViewController {

    let mainview = PhoneView()
    let viewModel = PhoneViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func loadView() {
        super.view = mainview
        mainview.backgroundColor = .white
    }
    
    override func configure() {
        mainview.phoneTextField.addTarget(self, action: #selector(inputNumTextFieldChanged), for: .editingChanged)

    }
    
    func bind() {
        viewModel.inputNumber
            .withUnretained(self)
            .bind { (vc, value) in
                let result = vc.viewModel.addHypen(num: value)
                vc.mainview.phoneTextField.text = result
            }
            .disposed(by: disposeBag)
        
        viewModel.numValidation
            .asDriver(onErrorJustReturn: false)
            .map { $0 == true ? UIColor.brandGreen : UIColor.grayScale6 }
            .drive(mainview.baseButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        mainview.baseButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                guard let text = vc.mainview.phoneTextField.text else { return }
                
                vc.viewModel.isPhone(phoneNumber: text) == true ? vc.isPhoneSuccess()
                : vc.mainview.makeToast("실패했습니다 :(")
                
                vc.viewModel.verifyNum(num: vc.mainview.phoneTextField.text)
            }
            .disposed(by: disposeBag)
    }
    
    @objc func inputNumTextFieldChanged() {
        guard let text = mainview.phoneTextField.text else { return }
        viewModel.validationCheck(text: text)
    }
    
    func isPhoneSuccess() {
        self.mainview.makeToast("성공했습니다 :)")
        self.transition(PhoneCertificationViewController(), transitionStyle: .presentFullScreen)
    }
}
