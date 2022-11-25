//
//  HomewViewModel.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/25.
//

import Foundation
import CoreLocation
import MapKit
import RxSwift
import RxCocoa

class HomeViewModel {
    var searchData = PublishRelay<SearchResponse>()
    let sesacCoordinate = CLLocationCoordinate2D(latitude: 37.51818789942772, longitude: 126.88541765534976)
    var currentLocation: CLLocation!

    func requestSearchData() {
        SearchAPI.shared.requestSearchData { data, error, statusCode in
            print("🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷🔷",data, statusCode, error)
            
            switch statusCode {
            case 200:
                guard let data = data else { return }
                self.searchData.accept(data)
                
            default:
                print("에러당에러야")
            }
            print(statusCode)
        }
    }
    
    func addAnnotation(map: MKMapView, data: SearchResponse) {
        data.fromQueueDB.forEach {
            let coordinate = CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.long)
            guard let image = Annotation(rawValue: $0.sesac) else { return }
            let annotation = CustomAnnotation(sesac_image: image, coordinate: coordinate)
            annotation.coordinate = coordinate
            map.addAnnotation(annotation)
        }
        data.fromQueueDBRequested.forEach {
            let coordinate = CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.long)
            guard let image = Annotation(rawValue: $0.sesac) else { return }
            let annotation = CustomAnnotation(sesac_image: image, coordinate: coordinate)
            annotation.coordinate = coordinate
            map.addAnnotation(annotation)
        }
    }
}

