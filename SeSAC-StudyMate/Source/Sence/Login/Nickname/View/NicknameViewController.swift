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
        
        viewModel.nicknameValidation
            .asDriver(onErrorJustReturn: false)
            .map { $0 == true ? UIColor.brandGreen : UIColor.grayScale6 }
            .drive(mainview.baseButton.rx.backgroundColor)
            .disposed(by: disposeBag)

        mainview.baseButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                
                vc.mainview.baseButton.backgroundColor == .brandGreen ? vc.seccess() : vc.mainview.makeToast("닉네임은 1자 이상 10자 이내로 부탁드려요")

            }
    }
    
    @objc func inputNumTextFieldChanged() {
        guard let text = mainview.phoneTextField.text else { return }
        viewModel.nicknameValidationCheck(text: text)
    }
    
    private func seccess() {
        guard let text = mainview.phoneTextField.text else { return }
        viewModel.successNickname(nickname: text)
        self.transition(BirthdayViewController(), transitionStyle: .presentFullScreen)
    }
}
