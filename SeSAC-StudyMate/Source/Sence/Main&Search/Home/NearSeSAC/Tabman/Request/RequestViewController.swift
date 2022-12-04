//
//  RequestViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/30.
//

import UIKit

import SnapKit
import Then
import RxSwift

class RequestViewController: BaseViewController {

    var lat: Double = 37.517819364682694
    var long: Double = 126.88647317074734
    var indexPathSection = 0
    
    // MARK: - DisposeBag
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Property
    let viewModel = NearTabmanViewModel()
    private let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.separatorStyle               = .none
        $0.showsVerticalScrollIndicator = false
        $0.sectionHeaderTopPadding      = 0
        $0.backgroundColor              = .white
        $0.bounces                      = false
        $0.allowsSelection              = false
        $0.rowHeight                    = UITableView.automaticDimension
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.requestSearchData(lat: lat, long: long)
        bind()
        configureLayout()
        setupDelegate()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.global().sync {
            viewModel.requestSearchData(lat: lat, long: long)
        }
    }
    
    override func loadView() {
        view = RequestView()
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
extension RequestViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print(viewModel.searchData.value.fromQueueDB.count, "viewmodel Cnt")
        
        return viewModel.searchData.value.fromQueueDBRequested.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var detailImageView = MyDetailImageView()
        detailImageView.settingButton.setTitle("수락하기", for: .normal)
        detailImageView.settingButton.backgroundColor = .responseButtonColor
        let data = viewModel.searchData.value.fromQueueDBRequested[section]
        detailImageView.configure(data: data)
        detailImageView.settingButton.addTarget(self, action: #selector(acceptButtonClicked), for: .touchUpInside)

        return detailImageView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let nameCell = tableView.dequeueReusableCell(withIdentifier: InfoManageCardTableViewCell.reuseIdentifier, for: indexPath) as? InfoManageCardTableViewCell
        else { return UITableViewCell() }
        nameCell.toggleButton.addTarget(self, action: #selector(touchupToggleButton(_:)), for: .touchUpInside)
                
        let data = viewModel.searchData.value.fromQueueDBRequested[indexPath.section]
        
        nameCell.configure(data: data)
        
        
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
    
    @objc func acceptButtonClicked() {
        let alertVC = CustomAlertViewController()
        alertVC.mainview.titleLabel.text = "스터디를 수락할까요?"
        alertVC.mainview.subtitleLabel.text = "요청을 수락하면 채팅방에서 대화를 나눌 수 있어요"
        self.transition(alertVC, transitionStyle: .overFullScreen)

    }
}
