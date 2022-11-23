//
//  MainViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/12.
//

import UIKit

import UIKit

class MainTabBarViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        let HomeVC = HomeViewController()
        let ShopVC = ShopViewController()
        let FriendVC = FriendViewController()
        let InfoVC = InfoViewController()
        
        SearchAPI.shared.requestSearchData { data, error, statusCode in
            print("🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷",data, statusCode, error)
            print(statusCode)
        }
        
        //각 tab bar의 viewcontroller 타이틀 설정
        
        HomeVC.title = "홈"
        ShopVC.title = "새싹샵"
        FriendVC.title = "새싹친구"
        InfoVC.title = "내정보"
        
        HomeVC.tabBarItem.image = UIImage.init(named: "tabHome.gray")
        ShopVC.tabBarItem.image = UIImage.init(named: "tabShop.gray")
        FriendVC.tabBarItem.image = UIImage.init(named: "tabFriend.gray")
        InfoVC.tabBarItem.image =  UIImage.init(named: "tabInfo.gray")
        //self.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0);
        
        // 위에 타이틀 text를 항상 크게 보이게 설정
//        HomeVC.navigationItem.largeTitleDisplayMode = .always
//        ShopVC.navigationItem.largeTitleDisplayMode = .always
//        FriendVC.navigationItem.largeTitleDisplayMode = .always
//        InfoVC.navigationItem.largeTitleDisplayMode = .always
        // navigationController의 root view 설정
        let navigationHome = UINavigationController(rootViewController: HomeVC)
        let navigationShop = UINavigationController(rootViewController: ShopVC)
        let navigationFriend = UINavigationController(rootViewController: FriendVC)
        let navigationInfo = UINavigationController(rootViewController: InfoVC)
        
//    
//        navigationHome.navigationBar.prefersLargeTitles = true
//        navigationShop.navigationBar.prefersLargeTitles = true
//        navigationFriend.navigationBar.prefersLargeTitles = true
//        navigationInfo.navigationBar.prefersLargeTitles = true
        
        setViewControllers([navigationHome, navigationShop, navigationFriend, navigationInfo], animated: false)
        
        self.tabBar.tintColor = .brandGreen
    }


    
}
