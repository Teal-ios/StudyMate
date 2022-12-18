//
//  ChattingView.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/05.
//

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift

class ChattingView: BaseView {
    
    //MARK: - HeaderView 설정
    lazy var headerView = ChattingHeaderView(frame: CGRect(x: 0, y: 0, width: 0, height: 120))
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(MyChattingTableViewCell.self, forCellReuseIdentifier: MyChattingTableViewCell.reuseIdentifier)
        view.register(OtherChattingTableViewCell.self, forCellReuseIdentifier: OtherChattingTableViewCell.reuseIdentifier)
        view.separatorStyle = .none
        view.rowHeight = UITableView.automaticDimension
        view.tableHeaderView = headerView
        return view
    }()
    
    let messageView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
        $0.backgroundColor = .grayScale1
    }
    
    let textView = UITextView().then {
        $0.textColor = .grayScale7
        $0.font = UIFont.Title4_R14
        $0.backgroundColor = .grayScale1
        $0.text = "메세지를 입력하세요"
        $0.textContainer.lineBreakMode = .byTruncatingTail
        $0.isScrollEnabled = false
        $0.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    let sendButton = UIButton().then {
        $0.setImage(ImageEnum.sendButton_normal.image, for: .normal)
        $0.tintColor = .grayScale6
    }
    
    override func configureUI() {
        messageView.addSubviews([textView, sendButton])
        addSubviews([tableView, messageView])
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(messageView.snp.top).offset(-12)
            make.top.equalTo(self.safeAreaLayoutGuide)
        }
        sendButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.trailing.equalTo(messageView).offset(-14)
            make.centerY.equalTo(messageView)
        }
        textView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(messageView).inset(14)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalTo(sendButton.snp.leading).offset(-10)
        }
        messageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-16)
            make.height.greaterThanOrEqualTo(52)
        }
    }
}
