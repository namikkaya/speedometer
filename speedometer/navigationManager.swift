//
//  navigationManager.swift
//  speedometer
//
//  Created by namik kaya on 21.08.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import UIKit
import GoogleMobileAds
class navigationManager: UINavigationController,GADRewardBasedVideoAdDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(), withAdUnitID: "ca-app-pub-3940256099942544/1712485313")
        GADRewardBasedVideoAd.sharedInstance().delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///////////////////////////////////////////////////////////////////
    //*****************************************************************
    // GADRewardBasedVideoAdDelegate ÖDÜLLÜ REKLAM
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didRewardUserWith reward: GADAdReward) {
        print("ödül alındı: \(reward.type), amount \(reward.amount).")
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd:GADRewardBasedVideoAd) {
        print("Ödüllü reklam hazır.")
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Ödüllü reklam açıldı.")
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Ödüllü reklam oynatılıyor.")
    }
    
    func rewardBasedVideoAdDidCompletePlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Ödüllü reklam oynatılması başarılı.")
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Ödüllü reklam kapatıldı.")
        print("Yeni istek yapılıyor.")
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(), withAdUnitID: "ca-app-pub-3940256099942544/1712485313")
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd) {
        print("Ödüllü reklam video bırakılcak")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd,
                            didFailToLoadWithError error: Error) {
        print("Ödüllü reklam hata alındı")
    }
    
    //-----------------------------------------------------------------

}
