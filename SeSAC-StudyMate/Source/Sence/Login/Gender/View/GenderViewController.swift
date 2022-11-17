//
//  GenderViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/09.
//

import UIKit
import RxSwift
import RxCocoa
import Toast
import FirebaseAuth

class GenderViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let mainview = GenderView()
    let viewModel = GenderViewModel()
    let disposeBag = DisposeBag()
    var genderList = [["여자", "woman"], ["남자", "man"]]
    var gender = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviSet()
        collectionViewConfiguration()
        bind()
    }
    
    override func loadView() {
        super.view = mainview
        mainview.backgroundColor = .white
    }
    
    
    
    func bind() {
        viewModel.genderValidation
            .asDriver(onErrorJustReturn: false)
            .map { $0 == true ? UIColor.brandGreen : UIColor.grayScale6 }
            .drive(mainview.baseButton.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        mainview.baseButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                
                vc.mainview.baseButton.backgroundColor == .brandGreen ? vc.postServer() : vc.mainview.makeToast(toastMessage.notChoiceGenderError.description)
                
            }
    }
    

    
    func postServer() {
        UserAPI.shared.postData { statusCode, error in
            
            guard let statusCode = statusCode else { return }
            print("제발나와라이이이잉🔵🔵🔵🔵",statusCode)
            switch statusCode {
            case 200:
                self.mainview.makeToast("\(APIError(rawValue: statusCode)?.rawValue)")
                self.transition(MainTabBarViewController(), transitionStyle: .rootViewChanged)
            case 201:
                self.mainview.makeToast("\(APIError(rawValue: statusCode)?.rawValue)")
                let viewControllers: [UIViewController] = self.navigationController?.viewControllers as! [UIViewController]
                self.navigationController!.popToViewController(viewControllers[viewControllers.count - 4], animated: true)
            case 202:
                self.mainview.makeToast("\(APIError(rawValue: statusCode)?.rawValue)")
                let viewControllers: [UIViewController] = self.navigationController?.viewControllers as! [UIViewController]
                self.navigationController!.popToViewController(viewControllers[viewControllers.count - 4], animated: true)
                
            case 401:
                self.mainview.makeToast("\(APIError(rawValue: statusCode)?.rawValue)")
                self.idTokenRefresh()
            case 500:
                self.mainview.makeToast("\(APIError(rawValue: statusCode)?.rawValue)")
            case 501:
                self.mainview.makeToast("\(APIError(rawValue: statusCode)?.rawValue)")
                
            default:
                return self.mainview.makeToast("등록되지 않은 에러입니다.")
            }
        }
    }
    
    func idTokenRefresh() {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
          if let error = error {
            print(error)
            return;
          }
            UserDefaultsHelper.standard.idToken = idToken
            print("refresh완료")
            self.transition(MainTabBarViewController(), transitionStyle: .rootViewChanged)
        }
    }
    func collectionViewConfiguration() {
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        mainview.collectionView.topAnchor.constraint(equalTo: self.mainview.baseSecondLabel.bottomAnchor).isActive = true
        mainview.collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        mainview.collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        mainview.collectionView.bottomAnchor.constraint(equalTo: self.mainview.baseButton.topAnchor).isActive = true
        mainview.collectionView.delegate = self
        mainview.collectionView.dataSource = self
    }
    
    func seccessLogin(gender: Int) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        
        let vc = MainTabBarViewController()
        UIView.transition(with: (sceneDelegate?.window)!, duration: 0.6, options: [.transitionCrossDissolve], animations: nil, completion: nil)
        let navi = UINavigationController(rootViewController: vc)
        sceneDelegate?.window?.rootViewController = navi
        sceneDelegate?.window?.makeKeyAndVisible()
        self.viewModel.successGender(gender: gender)
    }
}



extension GenderViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        genderList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenderCollectionViewCell.reuseIdentifier, for: indexPath) as? GenderCollectionViewCell else { return UICollectionViewCell() }
        
        cell.genderLabel.text = genderList[indexPath.row][0]
        cell.genderImg.image = UIImage(named: genderList[indexPath.row][1])
        cell.clipsToBounds = true
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.genderValidationCheck(text: indexPath.row)
        gender = indexPath.row
        print(gender)
        
    }
}

