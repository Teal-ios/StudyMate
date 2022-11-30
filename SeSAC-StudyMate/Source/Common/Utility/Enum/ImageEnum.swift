//
//  ImageEnum.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/28.
//

import UIKit

enum ImageEnum: Int {
    case MatchStateMatching
    case MatchStateMatched
    case MatchStateState
    
    case SeSACFace1
    case SeSACFace2
    case SeSACFace3
    case SeSACFace4
    case SeSACFace5
    
    case background_1
    case background_2
    case background_3
    case background_4
    case background_5
    
    case arrow
    case splashLogo
    case txt
    case moreArrow
    case moreArrow_1
    case moreArrow_2
    
    case filterControl
    case mapmaker
    case place
    case delete
    
    case tabHome
    case tabShop
    case tabFriend
    case tabInfo
    
    case emptyImage_near
    case emptyImage_request
}

extension ImageEnum {
    
    var image: UIImage? {
        switch self {
        case .MatchStateMatching:
            return UIImage(named: "Property 1=matching")
        case .MatchStateMatched:
            return UIImage(named: "Property 1=matched")
        case .MatchStateState:
            return UIImage(named: "Property 1=default")
            
        case .SeSACFace1:
            return UIImage(named: "sesac_face_1")
        case .SeSACFace2:
            return UIImage(named: "sesac_face_2")
        case .SeSACFace3:
            return UIImage(named: "sesac_face_3")
        case .SeSACFace4:
            return UIImage(named: "sesac_face_4")
        case .SeSACFace5:
            return UIImage(named: "sesac_face_5")

        case .arrow:
            return UIImage(named: "arrow")
        case .splashLogo:
            return UIImage(named: "splash_logo")
        case .txt:
            return UIImage(named: "txt")
        
        case .background_1:
            return UIImage(named: "sesac_background_1")
        case .background_2:
            return UIImage(named: "sesac_background_2")
        case .background_3:
            return UIImage(named: "sesac_background_3")
        case .background_4:
            return UIImage(named: "sesac_background_4")
        case .background_5:
            return UIImage(named: "sesac_background_5")

        case .moreArrow:
            return UIImage(named: "more_arrow")
        case .moreArrow_1:
            return UIImage(named: "more_arrow 1")
        case .moreArrow_2:
            return UIImage(named: "more_arrow 2")
        case .filterControl:
            return UIImage(named: "filter_control")

        case .mapmaker:
            return UIImage(named: "map_marker")
        case .place:
            return UIImage(named: "place")
        case .delete:
            return UIImage(systemName: "close_small")
        case .tabHome:
            return UIImage.init(named: "tabHome.gray")
        case .tabShop:
            return UIImage.init(named: "tabShop.gray")
        case .tabFriend:
            return UIImage.init(named: "tabFriend.gray")
        case .tabInfo:
            return UIImage.init(named: "tabInfo.gray")
        case .emptyImage_near:
            return UIImage(named: "empty_img (1)")
        case .emptyImage_request:
            return UIImage(named: "empty_img")
        }
    }
}
