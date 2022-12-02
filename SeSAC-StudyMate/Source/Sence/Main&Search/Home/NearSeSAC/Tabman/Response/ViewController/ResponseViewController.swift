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
import RxCocoa

protocol cellSettingDelegate: AnyObject {
    func cellData(nick: String, reputation: [Int], studyList: [String], reviews: [String], gender: Int, type: Int, sesac: Int, background: Int)
}

class ResponseViewController: BaseViewController {
    
    var lat: Double = 37.517819364682694
    var long: Double = 126.88647317074734
    var indexPathSection = 0
    weak var delegate: cellSettingDelegate?
    
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
        print("@@@@@@@@@")
        viewModel.requestSearchData(lat: lat, long: long)
        bind()
        configureLayout()
        setupDelegate()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func loadView() {
        view = ResponseView()
    }
    
    func bind() {
        
        viewModel.searchData
            .distinctUntilChanged{$0}
            .bind(onNext: { [weak self] _ in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
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
        print(viewModel.requestedStudyUserCount, "viewmodel Cnt")
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
        
        //MARK: - delegate를 사용해 값 전달하기
        let nick = viewModel.searchData.value.fromQueueDB[indexPathSection].nick
        let reputation = viewModel.searchData.value.fromQueueDB[indexPathSection].reputation
        let studyList = viewModel.searchData.value.fromQueueDB[indexPathSection].studylist
        let reviews = viewModel.searchData.value.fromQueueDB[indexPathSection].reviews
        let gender = viewModel.searchData.value.fromQueueDB[indexPathSection].gender
        let type = viewModel.searchData.value.fromQueueDB[indexPathSection].type
        let sesac = viewModel.searchData.value.fromQueueDB[indexPathSection].sesac
        let background = viewModel.searchData.value.fromQueueDB[indexPathSection].background
        
        delegate?.cellData(nick: nick, reputation: reputation, studyList: studyList, reviews: reviews, gender: gender, type: type, sesac: sesac, background: background)
        
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
    }
    
    func reloadCell(cell : InfoManageCardTableViewCell, section: Int) {
        
        //        cell(IndexPath(row: 0, section: section)).isSelected ? cell(IndexPath(row: 0, section: section)).changeView(isSelected: true) : cell(IndexPath(row: 0, section: section)).changeView(isSelected: false)
        
        cell.isSelected ? cell.changeView(isSelected: true) : cell.changeView(isSelected: false)
        tableView.reloadSections(IndexSet(), with: .fade)
    }
    
}
