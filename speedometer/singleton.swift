//
//  singleton.swift
//  speedometer
//
//  Created by namik kaya on 21.08.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import Foundation
import GoogleMobileAds

class singleton: NSObject, GADInterstitialDelegate {
    
    
    let interstitialBannerId:String = "ca-app-pub-3940256099942544/4411468910"
    
    static let sharedInstance: singleton = {
        let instance = singleton()
        return instance
    }()
    
    override init() {
        super.init()
        gecisReklami = createAndLoadInterstitial()
    }
    
    
    ///////////////////////////////////////////////////////////////////
    //*****************************************************************
    // Geçiş reklamı delegate
    
    func createAndLoadInterstitial() -> GADInterstitial {
        let newInterstitial = GADInterstitial(adUnitID: interstitialBannerId)
        newInterstitial.delegate = self
        newInterstitial.load(GADRequest())
        return newInterstitial
    }
    
    private var interstitial: GADInterstitial!
    var gecisReklami:GADInterstitial {
        get{
            return interstitial
        }set{
            interstitial = newValue
        }
    }
    
    /// Başarılı reklam isteği
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("interstitialDidReceiveAd")
    }
    
    /// Başarısız reklam isteği
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("interstitial:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Geçiş reklamı hazır
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("interstitialWillPresentScreen")
    }
    
    /// Geçiş reklamının ekran animasyonu
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("interstitialWillDismissScreen")
    }
    
    /// Geçiş reklamının ekran animasyonu tamamlandı
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("interstitialDidDismissScreen")
        interstitial = createAndLoadInterstitial()
    }
    
    /// Başka bir uygulama açıldı. Uygulama arka plana itildi.
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("interstitialWillLeaveApplication")
    }
    
    //-----------------------------------------------------------------
    
}
