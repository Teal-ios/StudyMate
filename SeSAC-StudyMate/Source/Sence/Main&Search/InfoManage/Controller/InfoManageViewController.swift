//
//  InfoManageViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/16.
//

import UIKit

import SnapKit
import Then
import RxSwift
import MultiSlider

final class InfoManageViewController: BaseViewController, WithdrawDelegate {

    
    
    // MARK: - DisposeBag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Property
    
    private let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
        $0.sectionHeaderTopPadding = 0
        $0.backgroundColor = .white
        $0.bounces = false
        $0.allowsSelection =  false
        $0.rowHeight = UITableView.automaticDimension
    }
    
    
    var updateMypage = myPage(searchable: 1, ageMin: 18, ageMax: 65, gender: 1)
    
    
    let viewModel = InfoManageViewModel()
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveNavi()
        naviSet()
        configureLayout()
        setupDelegate()
        bind()
        getUserData()
    }
    
    // MARK: - UI & Layout
    
    func configureLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview()
        }
    }
    
    override func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(InfoManageCardTableViewCell.self, forCellReuseIdentifier: InfoManageCardTableViewCell.reuseIdentifier)
        tableView.register(InfoManageTableViewCell.self, forCellReuseIdentifier: InfoManageTableViewCell.reuseIdentifier)
    }
    
    func saveNavi() {
        self.navigationItem.title = "정보 관리"
        let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        saveButton.tintColor = .black
        navigationItem.rightBarButtonItem = saveButton
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    //MARK: - RxBind
    func bind() {
        let cell = InfoManageTableViewCell()
        
        cell.maleButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.gender = 1
            }
        
        
        cell.femaleButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.gender = 0
            }
        
        
        cell.textField.rx.text
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.study = cell.textField.text
            }
        
        
        cell.numberSwitch.rx.value
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.accept = cell.numberSwitch.isOn
            }
        
        
        cell.ageSlider.rx.deallocated
            .withUnretained(self)
            .bind { (vc, _) in
                vc.viewModel.minage = Int(cell.ageSlider.value[0])
                vc.viewModel.maxage = Int(cell.ageSlider.value[1])
            }
        
        cell.withdrawButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.transition(CustomAlertViewController())
                print("taptap")
            }
        
        cell.withdrawDelegate = self
    }
    
    // MARK: - @objce
    
    @objc func touchupToggleButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! InfoManageCardTableViewCell
        cell.toggleButton.isSelected ? cell.changeView(isSelected: true) : cell.changeView(isSelected: false)
        tableView.reloadSections(IndexSet(), with: .fade)
    }
    
    @objc func saveButtonClicked() {
        updateMypage = myPage(searchable: self.viewModel.accept ? 1 : 0, ageMin: self.viewModel.minage, ageMax: self.viewModel.maxage, gender: self.viewModel.gender, study: self.viewModel.study)
        MyPageAPI.shared.MyPageUpdate { statusCode, error in
            print(statusCode)
            print(error)
            print("🔵🔵🔵🔵🔵🔵🔵🔵🔵",self.updateMypage)
        }
    }
    
    func getUserData() {
        LoginAPI.shared.requestLoginData { data, error, statusCode in
            guard let statusCode = statusCode else { return }
            print("제발나와라이이이잉🔵🔵🔵🔵",statusCode)
            switch statusCode {
            case 200:
                print(data)
                self.updateMypage = myPage(searchable: data?.searchable ?? 1, ageMin: data?.ageMin ?? 1, ageMax: data?.ageMax ?? 1, gender: data?.gender ?? 1)
                print("🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵🔵", self.updateMypage)
                self.tableView.reloadData()
            case 401:
                self.tableView.makeToast("\(LoginError(rawValue: statusCode)?.rawValue)")
            case 406:
                self.tableView.makeToast("\(LoginError(rawValue: statusCode)?.rawValue)")
            case 500:
                self.tableView.makeToast("\(LoginError(rawValue: statusCode)?.rawValue)")
            case 501:
                self.tableView.makeToast("\(LoginError(rawValue: statusCode)?.rawValue)")
            default:
                return self.tableView.makeToast(ToastEnum.notDefindError.message)
            }
        }
    }
    
    func withdrawButtonTapped(tap: Bool) {
        if tap {
            self.transition(WithDrawAlertViewController(), transitionStyle: .overFullScreen)
        }
    }
}

// MARK: - TableView
extension InfoManageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0: return MyDetailImageView()
        default: return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let nameCell = tableView.dequeueReusableCell(withIdentifier: InfoManageCardTableViewCell.reuseIdentifier, for: indexPath) as? InfoManageCardTableViewCell
            else { return UITableViewCell() }
            nameCell.toggleButton.addTarget(self, action: #selector(touchupToggleButton(_:)), for: .touchUpInside)
            return nameCell
        } else {
            guard let infoCell = tableView.dequeueReusableCell(withIdentifier: InfoManageTableViewCell.reuseIdentifier, for: indexPath) as? InfoManageTableViewCell
            else { return UITableViewCell() }
            
            infoCell.infoCellDelegate = self
            
            if updateMypage.gender == 0 {
                infoCell.maleButton.backgroundColor = .brandGreen
            } else {
                infoCell.femaleButton.backgroundColor = .brandGreen
            }
            infoCell.ageSlider.minimumValue = CGFloat(updateMypage.ageMin)
            infoCell.ageSlider.maximumValue = CGFloat(updateMypage.ageMax)
            if updateMypage.searchable == 1 {
                infoCell.numberSwitch.isOn = true
            } else {
                infoCell.numberSwitch.isOn = false
            }
            //의존성 주입해서 연결
            infoCell.withdrawDelegate = self
            
            return infoCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension InfoManageViewController: sliderDelegate {
    func slider(min: Int, max: Int) {
        viewModel.maxage = min
        viewModel.maxage = max
        print(min, max)
    }
}
