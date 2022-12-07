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

final class ChattingViewController: BaseViewController {
    
    var mainview = ChattingView()
    var chat: [Chat] = []
    var disposeBag = DisposeBag()
    let viewModel = ChattingViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavi()
        bind()
    }
    
    override func loadView() {
        view = mainview
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
}

