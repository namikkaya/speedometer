//
//  mapViewObject.swift
//  speedometer
//
//  Created by namik kaya on 8.08.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import Foundation
import MapKit

protocol mapViewObjectDelegate:class {
    
}

class mapViewObject: NSObject, MKMapViewDelegate {
    weak var mapView:MKMapView!
    
    /// Yürünen yolu çizdiren koordinatları tutar
    var checkPoint:[CLLocation] = []
    
    var startStatus:Bool = false
    
    
    override init() {
        super.init()
    }
    
    init(mapView:MKMapView) {
        super.init()
        self.mapView = mapView
        self.configurationMapView()
        addListener()
    }
    private func addListener() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(mapViewObject.deActiveApp(_:)),
                                               name: NSNotification.Name(rawValue: staticName.app_deActive),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(mapViewObject.activeApp(_:)),
                                               name: NSNotification.Name(rawValue: staticName.app_active),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(mapViewObject.recordChangeStatus(_:)),
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
        
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.userTrackingMode = .followWithHeading
        
        if(!recording.status){
            resetData()
        }
    }
    
    private func configurationMapView () {
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        if let coor = mapView.userLocation.location?.coordinate{
            mapView.setCenter(coor, animated: true)
        }
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.userTrackingMode = .followWithHeading
        mapView.userLocation.title = "Anlık Konum"
        
        mapView.isUserInteractionEnabled = false
    }
    
    func addMapPoint(coor:CLLocation){
        if (!recording.status){
            return
        }
        
        if checkPoint.count > 1 {
            let loc1: CLLocation = checkPoint.last!
            let loc2: CLLocation = coor
            let CLLCoordType1 = CLLocationCoordinate2D(latitude: loc1.coordinate.latitude, longitude: loc1.coordinate.longitude)
            let CLLCoordType2 = CLLocationCoordinate2D(latitude: loc2.coordinate.latitude, longitude: loc2.coordinate.longitude)
            
            let polyline = MKPolyline(coordinates: [CLLCoordType1,CLLCoordType2], count: 2)
            mapView?.add(polyline)
        }
        checkPoint.append(coor)
        
        
        mapView.showsUserLocation = true
        mapView.showsCompass = true
        mapView.userTrackingMode = .followWithHeading
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = UIColor.blue
        polylineRenderer.lineWidth = 5
        return polylineRenderer
    }
    
    func zoomMap(byFactor delta: Double, loc:CLLocation) {
        var span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(loc.coordinate.latitude), longitude: Double(loc.coordinate.longitude)), span: span)
        span.latitudeDelta *= delta
        span.longitudeDelta *= delta
        region.span = span
        mapView.setRegion(region, animated: true)
        self.mapView.showsUserLocation = true
    }
    
    func resetData(){
        checkPoint.removeAll()
        self.mapView.removeOverlays(self.mapView.overlays)
    }
}
