//
//  locationManager.swift
//  speedometer
//
//  Created by namik kaya on 6.08.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

enum myLocationErrorCode: Error {
    case notDetermined // belirsiz
    case authorizedAlways // her zaman
    case authorizedWhenInUse // uygulama çalışırken
    case restricted // kısıtlı
    case denied // reddedildi
}

enum myLocationPermisionPolicy:String {
    case authorizedAlways
    case authorizedWhenInUse
}

protocol myLocationManagerDelegate:class {
    /// locasyon hatasını döndürür.
    func myLocationError(code:myLocationErrorCode)
    /// lokasyon için alınan izni döndürür.
    func myLocationPermission(code:myLocationPermisionPolicy)
    /// lokasyondan gps kontrollü hız bilgisini döndürür
    func myLocationSpeed(speed:Int)
    /// anlık lokasyonu döndürür.
    func myLocation(locations: [CLLocation])
}

class locationManagerObject:NSObject, CLLocationManagerDelegate{
    
    weak var delegate: myLocationManagerDelegate?
    
    var pointData:[pointModel] = []
    
    private var startLocation: CLLocation!
    private var lastLocation: CLLocation!
    
    var traveledDistance: Double = 0
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        addListener()
    }
    
    deinit {
        removeListener()
    }
    
    private func addListener() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(locationManagerObject.deActiveApp(_:)),
                                               name: NSNotification.Name(rawValue: staticName.app_deActive),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(locationManagerObject.activeApp(_:)),
                                               name: NSNotification.Name(rawValue: staticName.app_active),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(locationManagerObject.recordChangeStatus(_:)),
                                               name: NSNotification.Name(rawValue: staticName.app_record_status),
                                               object: nil)
    }
    
    private func removeListener(){
         NotificationCenter.default.removeObserver(self)
    }
    
    @objc func deActiveApp(_ notification: Notification){
        
    }
    
    @objc func activeApp(_ notification: Notification){
        
    }
    
    @objc func recordChangeStatus(_ notification: Notification){
        print("locationManagerObject KAYDETME DURUMU DEĞİŞTİ : \(recording.status)")
        
        if(!recording.status){
            resetData()
        }
    }
    
    private var manager:CLLocationManager = {
        let man = CLLocationManager()
        man.requestWhenInUseAuthorization()
        man.desiredAccuracy = kCLLocationAccuracyBest
        man.activityType = .fitness
        man.startMonitoringSignificantLocationChanges()
        man.distanceFilter = 10// mesafe filitresi metre cinsi
        man.startUpdatingLocation()
        man.allowsBackgroundLocationUpdates = true
        man.pausesLocationUpdatesAutomatically = false
        return man
    }()
    
    /// CLLocationManager => manager geri döndürülür.
    func getManager()->CLLocationManager {
        return manager
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            delegate?.myLocationError(code: .notDetermined)
            break
        case.authorizedAlways:
            delegate?.myLocationPermission(code: .authorizedAlways)
            break
        case .authorizedWhenInUse:
            delegate?.myLocationPermission(code: .authorizedWhenInUse)
            break
        case .restricted:
            delegate?.myLocationError(code: .restricted)
            break
        case .denied:
            delegate?.myLocationError(code: .denied)
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        var speed: CLLocationSpeed = CLLocationSpeed()
        speed = (manager.location!.speed)
        
        let speedToMPH = (speed * 2.23694) // mil saat
        
        let speedToKPH = speed * 3.6 // kph
        let intSpeed = Int(speedToKPH)
        
        delegate?.myLocationSpeed(speed: intSpeed)
        delegate?.myLocation(locations: locations)
        
        if(recording.status){
            if startLocation == nil {
                startLocation = locations.first
            } else if let locationC = locations.last {
                if(lastLocation != nil){
                     traveledDistance += lastLocation.distance(from: locationC)
                }
                lastLocation = locations.last
                print("Yol: \(traveledDistance)")
            }
            
            
            let lat:Double = manager.location!.coordinate.latitude as Double
            let long:Double = manager.location!.coordinate.longitude as Double
            let currentDateTime = Date()
            let tempData = pointModel(lat: lat, long: long, speed: speed, currentDate: currentDateTime)
            pointData.append(tempData)
        }
        
    }
    
    
    func resetData(){
        pointData.removeAll()
        traveledDistance = 0
    }
    
}
