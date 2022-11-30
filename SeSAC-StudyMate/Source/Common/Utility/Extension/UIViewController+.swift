//
//  UIViewController+.swift
//  BHsplash
//
//  Created by 이병현 on 2022/10/31.
//

import UIKit
import Then

extension UIViewController {
    
    public func presentAlert(
        title: String,
        message: String? = nil,
        isIncludedCancel: Bool = false,
        completion: ( (UIAlertAction) -> Void )? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if isIncludedCancel {
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            alert.addAction(cancel)
        }
        
        let ok = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

extension UIViewController {
    
    public enum TransitionStyle {
        case present
        case presentNavigation
        case push
        case presentFullScreen
        case presentCrossDisolve
        case rootViewChanged
        case overFullScreen
    }
    
    public func transition<T: UIViewController>(_ viewController: T, transitionStyle: TransitionStyle = .present, handler: ( (T) -> Void)? = nil) {
        
        handler?(viewController)
        
        switch transitionStyle {
        case .present:
            self.present(viewController, animated: true)
            
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: viewController)
            self.present(nav, animated: true)
            
        case .push:
            self.navigationController?.pushViewController(viewController, animated: true)
            
        case .presentFullScreen:
            let nav = UINavigationController(rootViewController: viewController)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true)
            
        case .presentCrossDisolve:
            viewController.modalPresentationStyle = .overFullScreen
            viewController.modalTransitionStyle = .crossDissolve
            self.present(viewController, animated: true)
            
        case .overFullScreen:
            let nav = UINavigationController(rootViewController: viewController)
            nav.modalPresentationStyle = .overFullScreen
            self.present(nav, animated: true)
            
        case .rootViewChanged:
            changeRootVC()
        }
    }
    
    func changeRootVC() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let vc = MainTabBarViewController()
        UIView.transition(with: (sceneDelegate?.window)!, duration: 0.6, options: [.transitionCrossDissolve], animations: nil, completion: nil)
        let navi = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.rootViewController = navi
        navi.isNavigationBarHidden = true
        sceneDelegate?.window?.makeKeyAndVisible()

    }
}
