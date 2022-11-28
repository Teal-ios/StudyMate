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

        }
    }
}
