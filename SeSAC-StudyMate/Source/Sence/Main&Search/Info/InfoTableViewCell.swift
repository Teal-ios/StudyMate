//
//  InfoTableViewCell.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/14.
//

import UIKit

final class InfoTableViewCell: BaseTableViewCell {
    let containView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let iconImgView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    let explainLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .Title2_R16
        label.textAlignment = .left
        return label
    }()
    
    let nextButton = UIButton().then {
        $0.isHidden = true
        $0.setImage(ImageEnum.moreArrow.image, for: .normal)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureUI() {
        [containView, iconImgView, nextButton, explainLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        containView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide).inset(4)
        }
        
        iconImgView.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.left.equalTo(50)
            make.leading.equalTo(safeAreaLayoutGuide).offset(8)
            make.centerY.equalTo(containView)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerY.equalTo(containView)
            make.trailing.equalTo(containView.snp.trailing)
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        explainLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImgView.snp.trailing).offset(12)
            make.centerY.equalTo(containView)
            
        }
    }
    
}
