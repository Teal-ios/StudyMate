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

final class InfoManageViewController: BaseViewController {
    
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
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        saveNavi()
        naviSet()
        configureLayout()
        setupDelegate()
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
    
    // MARK: - @objce
    
    @objc func touchupToggleButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! InfoManageCardTableViewCell
        cell.toggleButton.isSelected ? cell.changeView(isSelected: true) : cell.changeView(isSelected: false)
        tableView.reloadSections(IndexSet(), with: .fade)
    }
    

    
    @objc func saveButtonClicked() {
        self.tableView.reloadData()
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
            return infoCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
