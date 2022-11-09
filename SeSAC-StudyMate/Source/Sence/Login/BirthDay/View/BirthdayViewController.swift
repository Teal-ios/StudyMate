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
    var diaryDate: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.view = mainview
        mainview.backgroundColor = .white
        configureDatePicker()
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
        let yearFormmater = DateFormatter()
        yearFormmater.dateFormat = "yyyy"
        yearFormmater.locale = Locale(identifier: "ko_KR")
        let monthFormmater = DateFormatter()
        monthFormmater.dateFormat = "MM"
        monthFormmater.locale = Locale(identifier: "ko_KR")
        let dayFormmater = DateFormatter()
        dayFormmater.dateFormat = "dd" //데이트 포멧형식 잡기
        dayFormmater.locale = Locale(identifier: "ko_KR")
        self.diaryDate = datePicker.date
        self.mainview.yearTextField.text = yearFormmater.string(from: datePicker.date)
        self.mainview.monthTextField.text = monthFormmater.string(from: datePicker.date)
        self.mainview.dayTextField.text = dayFormmater.string(from: datePicker.date)
    }

    

}
