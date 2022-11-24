//
//  SearchViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/23.
//

import UIKit

import SnapKit
import Then
import RxSwift

final class SearchViewController: BaseViewController {
    
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
        
        SearchAPI.shared.requestSearchData { data, error, statusCode in
            print("🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷",data, statusCode, error)
            print(statusCode)
        }
        
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
        tableView.register(nowAroundRedTableViewCell.self, forCellReuseIdentifier: nowAroundTableViewCell.reuseIdentifier)
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
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "지금 주변에는"
        case 2:
            return "내가 하고싶은"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == 0 {
            guard let cell0 = tableView.dequeueReusableCell(withIdentifier: nowAroundRedTableViewCell.reuseIdentifier, for: indexPath) as? nowAroundRedTableViewCell
            else { return UITableViewCell() }
            return cell0
        } else if indexPath.section == 1 {
            guard let cell1 = tableView.dequeueReusableCell(withIdentifier: nowAroundTableViewCell.reuseIdentifier, for: indexPath) as? nowAroundTableViewCell
            else { return UITableViewCell() }
            return cell1
        }
        else {
            guard let cell2 = tableView.dequeueReusableCell(withIdentifier: wantToDoTableViewCell.reuseIdentifier, for: indexPath) as? wantToDoTableViewCell
            else { return UITableViewCell() }
            return cell2
        }
    }
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //                tableView.deselectRow(at: indexPath, animated: true)
    //    }
}
