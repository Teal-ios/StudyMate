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
    var currentLocation = BehaviorSubject<CLLocationCoordinate2D>(value: CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270))
    var currentLocations: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
    

    func requestSearchData(lat: Double, long: Double) {
        SearchAPI.shared.requestSearchData(lat: lat, long: long) { data, error, statusCode in
            print("requestSearchData")
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
        print("인터넷호출되구이따요")
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
    
    func resetRegion(map: MKMapView, coordinate: CLLocationCoordinate2D) {
        map.setRegion(MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        
        var lat = map.centerCoordinate.latitude
        var long = map.centerCoordinate.longitude
        
        locationDelegate?.location(lat: lat, long: long)
    }
    
    
    func reloadAnnotation(map: MKMapView) {
        locationDelegate?.location(lat: map.centerCoordinate.latitude, long: map.centerCoordinate.longitude)
//        self.requestSearchData()
    }
    
    func reloadLocation(location: CLLocationCoordinate2D) {
        self.requestSearchData(lat: location.latitude, long: location.longitude)
    }
    
    func myQueueState() -> Int {
        var num = 0
        MyQueueStateAPI.shared.requestMyQueueData { data, error, statusCode in
            switch statusCode {
            case 200:
                // 생각해보기
                // Matched(rawValue: data?.matched)

                if data?.matched == Matched.matched.rawValue {
                    print("매칭 대기중 상태")
                    num = 1
                } else {
                    print("매칭 상태")
                    num = 2
                }
            default:
                print("미등록 에러")
                num = 0
            }
            print("myQueue 통신",statusCode, data)
        }
        return num
    }
}

