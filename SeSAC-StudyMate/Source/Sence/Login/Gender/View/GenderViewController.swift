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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                
                vc.mainview.baseButton.backgroundColor == .brandGreen ? self.transition(OnBoardingViewController(), transitionStyle: .presentFullScreen) : vc.mainview.makeToast("성별을 선택해 주세요")

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
        print(viewModel.inputGender)
    }
}

