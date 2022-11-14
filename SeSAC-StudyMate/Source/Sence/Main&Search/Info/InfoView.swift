//
//  File.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/14.
//

import UIKit

final class InfoView: BaseView {
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.register(InfoTableViewCell.self, forCellReuseIdentifier: "cell")
        view.backgroundColor = .white
        return view
    }()
    

    override func configureUI() {
        [tableView].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
    }
    
}
