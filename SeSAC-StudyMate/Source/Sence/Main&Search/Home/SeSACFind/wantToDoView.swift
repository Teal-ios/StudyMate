//
//  wantToDoView.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/18.
//

import UIKit

import SnapKit
import Then

final class wantToDoView: BaseView {
    
    // MARK: - Property
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>?
    
    private lazy var studyStackView = UIStackView(arrangedSubviews: [studyLabel, studyCollectionView]).then {
        $0.axis = .vertical
        $0.spacing = 16
        $0.alignment = .fill
        
    }

    private let studyLabel = UILabel().then {
        $0.textColor = UIColor.black
        $0.font = UIFont.Title6_R12
        $0.text = "내가 하고 싶은"
        
    }

    lazy var studyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout()).then {
        $0.isScrollEnabled = false
    }
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureDataSource()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure UI & Layout
    
    override func configureLayout() {
        self.addSubviews([studyStackView])
        
        studyStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        studyLabel.snp.makeConstraints { make in
            make.height.equalTo(18)
        }
        
        studyCollectionView.snp.makeConstraints { make in
            make.height.equalTo(112)
        }
    }
    
    // MARK: - Custom Method
    
    override func setupDelegate() {
        studyCollectionView.delegate = self
        studyCollectionView.register(wantToDoCollectionViewCell.self, forCellWithReuseIdentifier: wantToDoCollectionViewCell.reuseIdentifier)
    }
}

// MARK: - CollectionView Layout
extension wantToDoView: UICollectionViewDelegate {
    
    private func configureCollectionViewLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        
        return UICollectionViewCompositionalLayout.init(sectionProvider: { sectionIndex, environment in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(128), heightDimension: .estimated(128))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.edgeSpacing = .init(leading: .fixed(8), top: .fixed(8), trailing: .fixed(8), bottom: .fixed(8))
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(128))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }, configuration: configuration)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let layout = configureCollectionViewLayout()
        return layout
    }
}

// MARK: - Configure DataSource / UICollectionViewDelegate
extension wantToDoView {
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<wantToDoCollectionViewCell, String> { cell, indexPath, itemIdentifier in
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: studyCollectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration, for: indexPath, item: itemIdentifier)
            cell.setupData(itemIdentifier)
            
            return cell
        })
        
        var snapShot = NSDiffableDataSourceSnapshot<Int, String>()
        snapShot.appendSections([0])
        snapShot.appendItems([" 코딩 ", " 모든게 다 새삥 ", " 보세옷을 걸쳐도 "], toSection: 0)
        dataSource?.apply(snapShot)
        
    }
}
