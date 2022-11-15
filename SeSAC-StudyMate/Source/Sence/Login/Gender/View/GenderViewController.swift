//
//  GenderViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/09.
//

import UIKit
import RxSwift
import RxCocoa

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
            
//            if statusCode == 200 {
//
//            } else if statusCode == 401 {
//                self.showToast("토큰만료!!!!")
//                print("🟢🟢🟢🟢🟢🟢🟢🟢토큰만료")
//            }
//
            
            guard let apiError = APIError(rawValue: statusCode) else { return }
            
            print(apiError)
            guard let errorDescription = apiError.errorDescription else { return }
            
            print(errorDescription)
            
            
            
            
            switch apiError {
            case .success:
                self.showToast("\(statusCode)")
                self.seccessLogin(gender: self.gender)
                print("🟢🟢🟢🟢🟢🟢🟢🟢\(statusCode)")
            case .alreadyUser:
                print("🟢🟢🟢🟢🟢🟢🟢🟢\(errorDescription)")
                self.showToast(errorDescription)
            case .nicknameError:
                print("🟢🟢🟢🟢🟢🟢🟢🟢\(errorDescription)")
                self.showToast(errorDescription)
            case .expiredTokenError:
                self.showToast(errorDescription)
                print("🟢🟢🟢🟢🟢🟢🟢🟢\(errorDescription)")
            case .notCurrentUserError:
                self.showToast(errorDescription)
                print("🟢🟢🟢🟢🟢🟢🟢🟢\(errorDescription)")

            case .serverError:
                self.showToast(errorDescription)
                print("🟢🟢🟢🟢🟢🟢🟢🟢\(errorDescription)")

            case .clientError:
                self.showToast(errorDescription)
                print("🟢🟢🟢🟢🟢🟢🟢🟢\(errorDescription)")

            }
            
            
            
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

