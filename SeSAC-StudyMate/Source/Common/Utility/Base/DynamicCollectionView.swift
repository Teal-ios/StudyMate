//
//  DynamicCollectionView.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/24.
//

import UIKit

class DynamicCollectionView: UICollectionView {
    override var intrinsicContentSize: CGSize {
      return self.contentSize
    }

    override var contentSize: CGSize {
      didSet {
          self.invalidateIntrinsicContentSize()
      }
    }
}
