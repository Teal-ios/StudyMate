//
//  NearTapmanViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/30.
//




import UIKit
import Tabman
import Pageboy

final class NearTabmanViewController: TabmanViewController {
    
    let mainview = NearTabManView()
    
    var viewControllers: [BaseViewController] = [
        RequestViewController(), ResponseViewController()
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
             
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        settingTabBar(ctBar: bar)
        addBar(bar, dataSource: self, at: .top)
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "찾기중단", style: .plain, target: self, action: #selector(cancelFind))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: ImageEnum.arrow.image, style: .plain, target: self, action: #selector(backButtonClicked))
        navigationItem.title = "새싹 찾기"
    }
    
    func settingTabBar(ctBar: TMBar.ButtonBar) {

        ctBar.layout.transitionStyle = .snap
        // 왼쪽 여백주기
        ctBar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)

        // 간격
        ctBar.layout.interButtonSpacing = 20
        ctBar.backgroundView.style = .clear

        // 선택 & 선택X시 색 + 폰트사이즈
        ctBar.buttons.customize { (button) in
            button.tintColor = .grayScale6
            button.selectedTintColor = .brandGreen
            button.font = UIFont.Title4_R14!
            button.selectedFont = UIFont.Title4_R14
        }

        // 인디케이터
        ctBar.indicator.weight = .custom(value: 2)
        ctBar.indicator.tintColor = .brandGreen
        ctBar.layout.contentMode = .fit
    }
}

extension NearTabmanViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        
        switch index {
        case 0:
            return TMBarItem(title: "주변 새싹")
        case 1:
            return TMBarItem(title: "받은 요청")
        default:
            return TMBarItem(title: "Empty")
        }
    }
}

extension NearTabmanViewController {
    @objc func cancelFind() {
        
    }
    
    @objc func backButtonClicked() {
        
    }
}
