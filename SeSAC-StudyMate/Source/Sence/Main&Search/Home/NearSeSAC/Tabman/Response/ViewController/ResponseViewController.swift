//
//  ResponseViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/30.
//
import UIKit

import SnapKit
import Then
import RxSwift

class ResponseViewController: BaseViewController {
    
    var indexPathSection = 0
    
    // MARK: - DisposeBag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Property
    let viewModel = NearTabmanViewModel()
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
        
        configureLayout()
        setupDelegate()
    }
    
    override func loadView() {
        view = ResponseView()
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
    
    
    // MARK: - @objce
    
    @objc func touchupToggleButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let cell = tableView.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as! InfoManageCardTableViewCell
        
        sender.isSelected ? cell.changeView(isSelected: true) : cell.changeView(isSelected: false)
        tableView.reloadSections(IndexSet(), with: .fade)
    }
    
    @objc func saveButtonClicked() {
        self.tableView.reloadData()
    }
    
}

// MARK: - TableView
extension ResponseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.searchData.value.fromQueueDB.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return MyDetailImageView()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let nameCell = tableView.dequeueReusableCell(withIdentifier: InfoManageCardTableViewCell.reuseIdentifier, for: indexPath) as? InfoManageCardTableViewCell
        else { return UITableViewCell() }
        nameCell.toggleButton.addTarget(self, action: #selector(touchupToggleButton(_:)), for: .touchUpInside)
        //        nameCell.toggleButton.isHidden = true
        //        self.reloadCell(cell: nameCell, section: indexPath.section)
        //        nameCell.isSelected ? nameCell.changeView(isSelected: true) : nameCell.changeView(isSelected: false)
        //        tableView.reloadSections(IndexSet(), with: .fade)
        return nameCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        tableView.deselectRow(at: indexPath, animated: true)
        guard let nameCell = tableView.dequeueReusableCell(withIdentifier: InfoManageCardTableViewCell.reuseIdentifier, for: indexPath) as? InfoManageCardTableViewCell
        else { return }
        self.reloadCell(cell: nameCell, section: indexPath.section)
        //        nameCell.isSelected ? nameCell.changeView(isSelected: true) : nameCell.changeView(isSelected: false)
        //        tableView.reloadSections(IndexSet(), with: .fade)
        //        return nameCell
        print("@@")
        
    }
    
    func reloadCell(cell : InfoManageCardTableViewCell, section: Int) {
        
        //        cell(IndexPath(row: 0, section: section)).isSelected ? cell(IndexPath(row: 0, section: section)).changeView(isSelected: true) : cell(IndexPath(row: 0, section: section)).changeView(isSelected: false)
        
        cell.isSelected ? cell.changeView(isSelected: true) : cell.changeView(isSelected: false)
        tableView.reloadSections(IndexSet(), with: .fade)
    }
    
}
