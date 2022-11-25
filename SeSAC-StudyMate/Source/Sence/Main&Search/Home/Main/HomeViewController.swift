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

class HomeViewController: BaseViewController, MKMapViewDelegate, CLLocationManagerDelegate { //LocationManager를 사용하기 위한 Delegate
    
    let viewModel = HomeViewModel()
    let mapView = HomeView()
    let locationManager = CLLocationManager() //위치를 조종하게(?) 도와주는 로케이션 매니저를 하나 고용합시다.
    let disposeBag = DisposeBag()
    
    override func loadView() {
        super.view = mapView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization() //권한요청도 알아서 척척!
        
        mapView.map.setRegion(MKCoordinateRegion(center: viewModel.sesacCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)), animated: true)
        
        
        mapView.map.delegate = self
        locationManager.delegate = self
        
//        addCustomPin()
        buttonActions()
        myQueueState()
        viewModel.requestSearchData()
        bind()
        
    }
    
    func bind() {
        viewModel.searchData
            .asDriver(onErrorJustReturn: SearchResponse(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
            .drive(onNext: { [weak self] value in
                guard let self = self else { return }
                self.viewModel.addAnnotation(map: self.mapView.map, data: value)

            })
    }
    
    
    
    //재사용 할 수 있는 어노테이션 만들기! 마치 테이블뷰의 재사용 Cell을 넣어주는 것과 같아요!
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let annotation = annotation as? CustomAnnotation else { return nil }
        
        var annotationView = self.mapView.map.dequeueReusableAnnotationView(withIdentifier: CustomAnnotationView.identifier)
        
        if annotationView == nil {
            //없으면 하나 만들어 주시고
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: CustomAnnotationView.identifier)
        } else {
            //있으면 등록된 걸 쓰시면 됩니다.
            annotationView?.annotation = annotation
        }
        
        switch annotation.sesac_image {
            
        case .basic:
            annotationView?.image = Annotation.basic.imageName
        case .strong:
            annotationView?.image = Annotation.strong.imageName
        case .mint:
            annotationView?.image = Annotation.mint.imageName
        case .purple:
            annotationView?.image = Annotation.purple.imageName
        case .gold:
            annotationView?.image = Annotation.gold.imageName
        }
        return annotationView
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
    
    //권한 설정을 위한 코드들
    
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
        
        let alert = UIAlertController(title: "위치권한 요청", message: "러닝 거리 기록을 위해 항상 위치 권한이 필요합니다.", preferredStyle: .alert)
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
