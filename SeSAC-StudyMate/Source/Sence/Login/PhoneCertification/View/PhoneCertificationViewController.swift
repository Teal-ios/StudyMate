//
//  PhoneCertificationViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/09.
//

import UIKit
import RxSwift
import RxCocoa
import FirebaseAuth

class PhoneCertificationViewController: BaseViewController {

    let mainview = PhoneCertificationView()
    let viewModel = PhoneCertificationViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviSet()
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
        
        viewModel.numValidation
            .asDriver(onErrorJustReturn: false)
            .map { $0 == true ? UIColor.brandGreen : UIColor.grayScale6 }
            .drive(mainview.baseButton.rx.backgroundColor)
            .disposed(by: disposeBag)

        
        mainview.baseButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                guard let text = vc.mainview.phoneTextField.text else { return }

                vc.viewModel.correctCode(code: text) == true ?
                vc.isPhoneSuccess()
                : vc.mainview.makeToast("인증코드가 일치하지 않습니다.")
                
            }
            .disposed(by: disposeBag)

      
    }
    
    @objc func inputNumTextFieldChanged() {
        guard let text = mainview.phoneTextField.text else { return }
        viewModel.validationCheck(text: text)
    }

    func isPhoneSuccess() {
        guard let text = self.mainview.phoneTextField.text else { return }
        self.mainview.makeToast("인증코드가 일치합니다.")
        self.viewModel.verifyID(code: text)
        self.transition(NicknameViewController())

    }
}
