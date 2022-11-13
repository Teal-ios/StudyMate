//
//  BirthdayViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/09.
//

import UIKit
import RxSwift
import RxCocoa

class BirthdayViewController: BaseViewController {
    
    let mainview = BirthdayView()
    let viewModel = BirthdayViewModel()
    let disposeBag = DisposeBag()
    let datePicker = UIDatePicker()
    var birthdayDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviSet()
    }
    
    override func loadView() {
        super.view = mainview
        mainview.backgroundColor = .white
        configureDatePicker()
        bind()
    }
    override func configure() {
        mainview.yearTextField.addTarget(self, action: #selector(inputDayTextFieldChanged), for: .allEvents)
    }
    
    func bind() {
        
        viewModel.birthDayValidation
            .asDriver(onErrorJustReturn: false)
            .map { $0 == true ? UIColor.brandGreen : UIColor.grayScale6 }
            .drive(mainview.baseButton.rx.backgroundColor)
            .disposed(by: disposeBag)

        mainview.baseButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                
                vc.mainview.baseButton.backgroundColor == .brandGreen ? vc.success() : vc.mainview.makeToast("날짜를 입력해주세요")

            }
    }
    
    // DATE PICKER
      private func configureDatePicker(){
          self.datePicker.datePickerMode = .date
          self.datePicker.preferredDatePickerStyle = .wheels
          self.datePicker.addTarget(self, action: #selector(datePickerValueDidChange(_:)), for: .valueChanged)
          self.datePicker.locale = Locale(identifier: "ko-KR") // 데이트 피커 UI  한국어 포메터 설정
          self.mainview.yearTextField.inputView = self.datePicker // 키보드가 아닌 datePicker UI 가 표시되게 하기
      }
    
    //addTarget 두번쨰 파라미터 셀렉터 메서드
    @objc private func datePickerValueDidChange(_ datePicker: UIDatePicker){
        
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        yearFormatter.locale = Locale(identifier: "ko_KR")
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM"
        monthFormatter.locale = Locale(identifier: "ko_KR")
        
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd" //데이트 포멧형식 잡기
        dayFormatter.locale = Locale(identifier: "ko_KR")
        
        let totalFormatter = DateFormatter()
        totalFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        birthdayDate = totalFormatter.string(from: datePicker.date)
        print("@@@@@",birthdayDate)
        self.mainview.yearTextField.text = yearFormatter.string(from: datePicker.date)
        self.mainview.monthTextField.text = monthFormatter.string(from: datePicker.date)
        self.mainview.dayTextField.text = dayFormatter.string(from: datePicker.date)
        
        self.viewModel.selectDay
            .onNext(totalFormatter.string(from: datePicker.date))
    }
    
    @objc func inputDayTextFieldChanged() {
        guard let text = mainview.yearTextField.text else { return }
        viewModel.birthDayValidationCheck(selectDay: text)
    }
    
    func success() {
        guard let birthday = birthdayDate else { return }
        print(birthday)
        viewModel.successBirthday(birthday: birthday)
        self.transition(EmailViewController(), transitionStyle: .push)
    }
}
