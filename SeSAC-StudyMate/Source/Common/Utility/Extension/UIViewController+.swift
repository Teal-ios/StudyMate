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
        sceneDelegate?.window?.makeKeyAndVisible()

    }
    
    func showToast(_ message: String) {
        let toastLabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.size.width/2-(UIScreen.main.bounds.size.width-32)/2,
                                               y: 70,
                                               width: UIScreen.main.bounds.size.width-32,
                                               height: 40)).then {
            $0.backgroundColor = UIColor.init(red: 51, green: 51, blue: 51, alpha: 0.89)
            $0.textColor = .white
            $0.font = UIFont.Body4_R12
            $0.textAlignment = .center
            $0.text = message
            $0.layer.cornerRadius = 10
            $0.clipsToBounds  =  true
            view.addSubview($0)
        }
        
        UIView.animate(withDuration: 2, delay: 0.2, options: .curveEaseIn) {
            toastLabel.alpha = 0.0
        } completion: { _ in
            toastLabel.removeFromSuperview()
        }
    }
}
