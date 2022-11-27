//
//  HomeViewController.swift
//  SeSAC-StudyMate
//
//  Created by 이병현 on 2022/11/14.
//

import UIKit
import MapKit
import CoreLocation
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController,  CLLocationManagerDelegate {
    
    let viewModel = HomeViewModel()
    let mapView = HomeView()
    let locationManager = CLLocationManager()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        mapView.map.delegate = self
        locationManager.delegate = self
        
        buttonActions()
//        myQueueState()
        viewModel.requestSearchData(lat: 37.517829, long: 126.886270)
        bind()
        
    }
    
    private func bind() {
        viewModel.searchData
            .asDriver(onErrorJustReturn: SearchResponse(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
            .drive(onNext: { [weak self] value in
                guard let self = self else { return }
                self.viewModel.addAnnotation(map: self.mapView.map, data: value)
            })
    }


    @objc func findMyLocation() {
        
        guard let currentLocation = locationManager.location else {
            checkUserLocationServicesAuthorization()
            return
        }
        
        mapView.map.showsUserLocation = true
        mapView.map.setUserTrackingMode(.follow, animated: true)
        
    }
    
    @objc func findSeSAC() {
        transition(StudyViewController(), transitionStyle: .push)
    }

    func buttonActions() {
        mapView.gpsButton.addTarget(self, action: #selector(findMyLocation), for: .touchUpInside)
        mapView.statusButton.addTarget(self, action: #selector(findSeSAC), for: .touchUpInside)
    }
    
    func myQueueState() {
        MyQueueStateAPI.shared.requestMyQueueData { data, error, statusCode in
            print("##########",data)
            print("##########",statusCode)
        }
    }
}

extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        print(mapView.centerCoordinate)
        mapView.removeAnnotations(mapView.annotations)
        viewModel.requestSearchData(lat: mapView.centerCoordinate.latitude, long: mapView.centerCoordinate.longitude)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? CustomAnnotation else { return nil }
        
        var annotationView = self.mapView.map.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.identifier)
            annotationView?.canShowCallout = false
            annotationView?.contentMode = .scaleAspectFit
        } else {
            annotationView?.annotation = annotation
        }
        
        let sesacImage: UIImage!
        let size = CGSize(width: 120, height: 120)
        UIGraphicsBeginImageContext(size)
        
        switch annotation.sesac_image {
            
        case .basic:
            sesacImage = Annotation.basic.imageName
        case .strong:
            sesacImage = Annotation.strong.imageName
        case .mint:
            sesacImage = Annotation.mint.imageName
        case .purple:
            sesacImage = Annotation.purple.imageName
        case .gold:
            sesacImage = Annotation.gold.imageName
        }
        
        
        sesacImage.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        annotationView?.image = resizedImage
        return annotationView
    }
}

//MARK: 권한 설정

extension HomeViewController {
    func checkCurrentLocationAuthorization(authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        case .restricted:
            print("restricted")
            goSetting()
        case .denied:
            print("denided")
            goSetting()
        case .authorizedAlways:
            print("always")
        case .authorizedWhenInUse:
            print("wheninuse")
            locationManager.startUpdatingLocation()
        @unknown default:
            print("unknown")
        }
        if #available(iOS 14.0, *) {
            let accuracyState = locationManager.accuracyAuthorization
            switch accuracyState {
            case .fullAccuracy:
                print("full")
            case .reducedAccuracy:
                print("reduced")
            @unknown default:
                print("Unknown")
            }
        }
    }
    
    func goSetting() {
        
        let alert = UIAlertController(title: "위치권한 요청", message: "위치 기반 서비스를 위해 항상 위치 권한이 필요합니다.", preferredStyle: .alert)
        let settingAction = UIAlertAction(title: "설정", style: .default) { action in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            // 열 수 있는 url 이라면, 이동
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { UIAlertAction in
            
        }
        
        alert.addAction(settingAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func checkUserLocationServicesAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        if #available(iOS 14, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization(authorizationStatus: authorizationStatus)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
}

//MARK: - Map
extension HomeViewController {
    private func setRegion(center: CLLocationCoordinate2D) {
        print("region설정")
        print("센터센터: \(center)")
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.map.setRegion(region, animated: true)
    }
}
