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
            .map { ($0.count == 6) }
        
        
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
                vc.navigationController?.pushViewController(NicknameViewController(), animated: true)
            }

      
    }
}
