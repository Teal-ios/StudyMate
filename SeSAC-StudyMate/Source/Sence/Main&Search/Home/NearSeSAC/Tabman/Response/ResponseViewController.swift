//
//  ResponseViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/30.
//
import UIKit

class ResponseViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = UIImageView(image: ImageEnum.emptyImage_near.image)
    }
}
