//
//  ViewController.swift
//  speedometer
//
//  Created by namik kaya on 5.08.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import UIKit
import MapKit
import GoogleMobileAds

class ViewController: UIViewController, myLocationManagerDelegate, GADBannerViewDelegate {
    
    let TAG:String = "ViewController"
    
    let googleBannerID:String = "ca-app-pub-3940256099942544/2934735716"
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var gBannerView: UIView!
    
    /// manager alınır.
    private var manager:locationManagerObject = locationManagerObject()
    /// locationManager kontrol edilebilsin diye
    private var locMan:CLLocationManager?
    
    private var mapViewManager:mapViewObject?
    private var topSpeed:Int = 0
    
    @IBOutlet weak var topSpeedLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var speedDisplay: speedDisplay!
    
    private var sing:singleton!
    
    var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sing = singleton.sharedInstance
        
        mapViewManager = mapViewObject(mapView: mapView)
        
        locMan = manager.getManager()
        manager.delegate = self
        initGoogleBanner()
    }
    
    func initGoogleBanner(){
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        gBannerView.addSubview(bannerView)
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        
        bannerView.load(GADRequest())
        bannerView.delegate = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addListener()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeListener()
    }
    
    /// Dinleyicileri başlatır
    private func addListener() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.deActiveApp(_:)),
                                               name: NSNotification.Name(rawValue: staticName.app_deActive),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.activeApp(_:)),
                                               name: NSNotification.Name(rawValue: staticName.app_active),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ViewController.recordChangeStatus(_:)),
                                               name: NSNotification.Name(rawValue: staticName.app_record_status),
                                               object: nil)
    }
    
    /// Dinleyicileri bitirir.
    private func removeListener() {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// Uygulama arka plana atıldığında
    @objc func deActiveApp(_ notification: Notification){
        
    }
    /// Uygulama tekrar aktif olduğunda
    @objc func activeApp(_ notification: Notification){
        
    }
    
    /// Kaydetme durumu değiştirildiğinde
    @objc func recordChangeStatus(_ notification: Notification){
        print("KAYDETME DURUMU DEĞİŞTİ: \(recording.status)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    ///////////////////////////////////////////////////////////////////
    //*****************************************************************
    // myLocationManager
    
    ///myLocationError hata döndürür
    func myLocationError(code: myLocationErrorCode) {
        print("error code: \(code)")
    }
    
    ///hangi izin alındıysa döndürür
    func myLocationPermission(code: myLocationPermisionPolicy) {
        print("izin tipi: \(code)")
    }
    
    ///hangi izin alındıysa döndürür
    func myLocationSpeed(speed: Int) {
        if recording.status == false {
            let speedString:String = "000"
            speedDisplay.setDisplayText = speedString.convertSpeed
            
            let topSpeedString:String = "0"
            topSpeedLabel.attributedText = topSpeedString.attrKmh
            
            return
        }
        
        if (speed < 0){ return }
        
        if (speed > topSpeed){
            topSpeed = speed
            
        }
        let speedString:String = String(speed)
        speedDisplay.setDisplayText = speedString.convertSpeed
        topSpeedLabel.attributedText = String(topSpeed).attrKmh
    }
    
    /// Anlık lokasyon gelir
    func myLocation(locations: [CLLocation]) {
        mapViewManager?.addMapPoint(coor: locations.last!)
    }
    
    //-----------------------------------------------------------------
    
    
    
    ///////////////////////////////////////////////////////////////////
    //*****************************************************************
    // GADBannerViewDelegate
    
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
    //-----------------------------------------------------------------
    
    ///////////////////////////////////////////////////////////////
    /// Bütün dataları sıfırlar
    private func resetData(){
        topSpeed = 0
    }
    
    /// Başlat bitir button
    @IBAction func START_BUTTON_ACTION(_ sender: Any) {
        if ((sender as! toogleButton).isOn){
            recording.status = true
        }else{
            let getPoint:[pointModel] = manager.pointData
            print("Stop edilmeden önce datalar alındı : \(getPoint)")
            recording.status = false
            
            let vc = self.storyboard?.instantiateViewController(
                withIdentifier: "showResultVC") as! showResultViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

