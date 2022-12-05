//
//  ChattingHeaderView.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/12/05.
//

import UIKit
import SnapKit

final class ChattingHeaderView: BaseView {
    let dataContainView = UIView().then {
        $0.backgroundColor = UIColor.grayScale7
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
    }
}
