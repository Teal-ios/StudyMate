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

protocol locationDelegate: AnyObject {
    func location(lat: Double, long: Double)
}

class HomeViewModel {
    var locationDelegate: locationDelegate?
    var searchData = PublishRelay<SearchResponse>()
    var currentLocation = BehaviorSubject<CLLocationCoordinate2D>(value: CLLocationCoordinate2D(latitude: 37.51818789942772, longitude: 126.88541765534976))

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
    
    func moveSearchRequest() {
        
    }
    
    func addAnnotation(map: MKMapView, data: SearchResponse) {
        data.fromQueueDB.forEach {
            let coordinate = CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.long)
            guard let image = Annotation(rawValue: $0.sesac) else { return }
            let annotation = CustomAnnotation(sesac_image: image, coordinate: coordinate)
            annotation.coordinate = coordinate
            map.addAnnotation(annotation)
            print("인터넷호출되구이따요")
        }
        data.fromQueueDBRequested.forEach {
            let coordinate = CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.long)
            guard let image = Annotation(rawValue: $0.sesac) else { return }
            let annotation = CustomAnnotation(sesac_image: image, coordinate: coordinate)
            annotation.coordinate = coordinate
            map.addAnnotation(annotation)
        }
    }
    
    func resetRegion(map: MKMapView, coordinate: CLLocationCoordinate2D) {
        map.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        
        var lat = map.centerCoordinate.latitude
        var long = map.centerCoordinate.longitude
        
        locationDelegate?.location(lat: lat, long: long)
    }
}

