//
//  ChattingViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/05.
//

import UIKit
import RxSwift
import RxCocoa
import RxKeyboard
import SnapKit
import Alamofire

final class ChattingViewController: BaseViewController {
    
    var mainview = ChattingView()
    var chat: [Chat] = []
    var disposeBag = DisposeBag()
    let viewModel = ChattingViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavi()
        bind()
        NotificationCenter.default.addObserver(self, selector: #selector(getMessage(notification:)), name: NSNotification.Name("getMessage"), object: nil)
    }
    
    override func loadView() {
        view = mainview
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        SocketIOManager.shared.closeConnection()
    }
    
    func setNavi() {
        //    //MARK: - Navi 설정
        navigationController?.isNavigationBarHidden = false
        let backButtonItem = UIBarButtonItem(image: ImageEnum.arrow.image, style: .plain, target: self, action: #selector(backButtonTapped))
        let menuButtonItem = UIBarButtonItem(image: ImageEnum.menu.image, style: .plain, target: self, action: #selector(menuButtonTapped))
        navigationItem.leftBarButtonItem = backButtonItem
        navigationItem.rightBarButtonItem = menuButtonItem
        navigationItem.title = "고래밥"
        
    }
    
    func bind() {
        RxKeyboard.instance.visibleHeight
            .drive(onNext: { [weak self] height in
                self?.setUpConstraints(height: height)
                UIView.animate(withDuration: 0.5) {
                    self?.mainview.messageView.layoutIfNeeded()
                }
            })
            .disposed(by: disposeBag)
        
        mainview.sendButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                guard let text = vc.mainview.textView.text else { return }
                guard let uid = UserDefaultsHelper.standard.otherUid else { return }

                vc.viewModel.sendChat(chat: text, to: uid)
                vc.mainview.textView.text = ""
            }
               
        viewModel.chatData.bind(to: mainview.tableView.rx.items) { tableView, row, element in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherChattingTableViewCell.reuseIdentifier) as? OtherChattingTableViewCell else { return UITableViewCell() }

            return cell
            
        }
        .disposed(by: disposeBag)
        
        
        
//        viewModel.chatData.bind(to: mainview.tableView.rx.items) { tableView, row, chat in
//            guard let uid = UserDefaultsHelper.standard.otherUid else { return }
//            
//            if chat.from == uid {
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: OtherChattingTableViewCell.reuseIdentifier) as? OtherChattingTableViewCell else { return UITableViewCell() }
//                cell.messageLabel.text = chat.chat
//                return cell
//            } else {
//                guard let cell = tableView.dequeueReusableCell(withIdentifier: MyChattingTableViewCell.reuseIdentifier) as? MyChattingTableViewCell else { return UITableViewCell() }
//                cell.messageLabel.text = chat.chat
//                return cell
//            }
//        }.disposed(by: disposeBag)
    }
    
    private func setUpConstraints(height: CGFloat) {
        switch height {
        case 0:
            //다시 돌아가기
            mainview.messageView.snp.remakeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(16)
                make.bottom.equalTo(mainview.safeAreaLayoutGuide).offset(-16)
                make.height.greaterThanOrEqualTo(52)
            }
            mainview.tableView.snp.remakeConstraints { make in
                make.horizontalEdges.equalToSuperview()
                make.bottom.equalTo(mainview.messageView.snp.top).offset(-12)
                make.top.equalTo(mainview.safeAreaLayoutGuide)
            }
        default:
            //올리기
            mainview.messageView.snp.remakeConstraints { make in
                make.horizontalEdges.equalToSuperview().inset(16)
                make.bottom.equalToSuperview().offset(-height-16)
                make.height.greaterThanOrEqualTo(52)
            }
            mainview.tableView.snp.remakeConstraints { make in
                make.horizontalEdges.equalToSuperview()
                make.bottom.equalTo(mainview.messageView.snp.top).offset(-12)
                make.top.equalTo(mainview.safeAreaLayoutGuide)
            }
        }
    }
    
    //MARK: - Obj-C
    @objc func backButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func menuButtonTapped() {
        
    }
    
    @objc func getMessage(notification: NSNotification) {
            
        let chat = notification.userInfo!["chat"] as! String
        let id = notification.userInfo!["id"] as! String
        let createdAt = notification.userInfo!["createdAt"] as! String
        let from = notification.userInfo!["from"] as! String
        let to = notification.userInfo!["to"] as! String

        
        let value = Chat(id: id, to: to, from: from, chat: chat, createdAt: createdAt)
        
        self.chat.append(value)
        mainview.tableView.reloadData()
        mainview.tableView.scrollToRow(at: IndexPath(row: self.chat.count - 1, section: 0), at: .bottom, animated: false)
    }
    
    func fetchChat() {
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(APIKey.header)",
            "Content-Type": "application/json"
        ]

        AF.request(APIKey.url, method: .get, headers: header).responseDecodable(of: [Chat].self) { [weak self] response in
            switch response.result {
            case .success(let value):
                self?.chat = value
                self?.mainview.tableView.reloadData()
                self?.mainview.tableView.scrollToRow(at: IndexPath(row: self!.chat.count - 1, section: 0), at: .bottom, animated: false)
                SocketIOManager.shared.establishConnection()
            case .failure(let error):
                print("FAIL", error)
            }
        }
    }
    
    
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        mainview.tableView.delegate = self
        mainview.tableView.dataSource = self
        mainview.tableView.allowsSelection = false
        mainview.tableView.separatorStyle = .none
        mainview.tableView.rowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = chat[indexPath.row]
         
//        if indexPath.row.isMultiple(of: 2) {
        if data.id == APIKey.userId {
            let cell = mainview.tableView.dequeueReusableCell(withIdentifier: MyChattingTableViewCell.reuseIdentifier, for: indexPath) as! MyChattingTableViewCell
            cell.messageLabel.text = data.chat
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: OtherChattingTableViewCell.reuseIdentifier, for: indexPath) as! OtherChattingTableViewCell
            cell.messageLabel.text = data.chat
            return cell
        }
    }
    
}
