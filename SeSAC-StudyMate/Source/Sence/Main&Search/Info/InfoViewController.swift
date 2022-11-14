//
//  InfoViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/14.
//


import UIKit
import Toast

final class InfoViewController: BaseViewController {
    
    private let mainview = InfoView()
    private let viewModel = InfoViewModel()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainview.tableView.rowHeight = 72
        
        mainview.tableView.dataSource = self
        mainview.tableView.delegate = self
    }
    
    
    override func loadView() {
        super.view = mainview
    }
    
    
}

extension InfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? InfoTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        cell.explainLabel.text = InfoLabelEnum.allCases[indexPath.row].rawValue
        cell.iconImgView.image = UIImage(named: InfoIconEnum.allCases[indexPath.row].rawValue)
        
        if indexPath.row == 0 {
            cell.nextButton.isHidden = false
        }
        
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            transition(InfoManageViewController(), transitionStyle: .push)
        default:
            self.mainview.makeToast("준비중입니다.")
        }
    }
    
}
