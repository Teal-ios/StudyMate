//
//  MainViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/12.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let HomeVC = HomeViewController()
        let ShopVC = ShopViewController()
        let FriendVC = FriendViewController()
        let InfoVC = InfoViewController()
        
        //각 tab bar의 viewcontroller 타이틀 설정
        HomeVC.title = MainEnum.home.text
        ShopVC.title = MainEnum.shop.text
        FriendVC.title = MainEnum.friend.text
        FriendVC.title = MainEnum.friend.text
        InfoVC.title = MainEnum.myInfo.text
        
        HomeVC.tabBarItem.image = ImageEnum.tabHome.image
        ShopVC.tabBarItem.image = ImageEnum.tabShop.image
        FriendVC.tabBarItem.image = ImageEnum.tabFriend.image
        InfoVC.tabBarItem.image =  ImageEnum.tabInfo.image

        let navigationHome = UINavigationController(rootViewController: HomeVC)
        let navigationShop = UINavigationController(rootViewController: ShopVC)
        let navigationFriend = UINavigationController(rootViewController: FriendVC)
        let navigationInfo = UINavigationController(rootViewController: InfoVC)
        
        setViewControllers([navigationHome, navigationShop, navigationFriend, navigationInfo], animated: false)
        
        self.tabBar.tintColor = .brandGreen
    }
}
