//
//  SeSACFindViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/18.
//

import UIKit

import SnapKit
import Then
import RxSwift
final class SeSACFindViewController: BaseViewController {
    
    
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
        searchNavi()
        configureLayout()
        setupDelegate()
    }
    // MARK: - Search Navigation
    private func searchNavi() {
        
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow"), style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = .black
        self.navigationItem.leftBarButtonItem = backButton
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 340, height: 0))
        searchBar.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
    }
    
    // MARK: - UI & Layout
    
    func configureLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.directionalHorizontalEdges.equalToSuperview().inset(8)
        }
    }
    
    override func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(nowAroundTableViewCell.self, forCellReuseIdentifier: nowAroundTableViewCell.reuseIdentifier)
        tableView.register(wantToDoTableViewCell.self, forCellReuseIdentifier: wantToDoTableViewCell.reuseIdentifier)
    }
    
    
    // MARK: - @objce
    
    @objc func touchupToggleButton(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! InfoManageCardTableViewCell
        cell.toggleButton.isSelected ? cell.changeView(isSelected: true) : cell.changeView(isSelected: false)
        tableView.reloadSections(IndexSet(), with: .fade)
    }
}

// MARK: - TableView
extension SeSACFindViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            guard let nameCell = tableView.dequeueReusableCell(withIdentifier: nowAroundTableViewCell.reuseIdentifier, for: indexPath) as? nowAroundTableViewCell
            else { return UITableViewCell() }
            return nameCell
        } else {
            guard let infoCell = tableView.dequeueReusableCell(withIdentifier: wantToDoTableViewCell.reuseIdentifier, for: indexPath) as? wantToDoTableViewCell
            else { return UITableViewCell() }
            return infoCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
