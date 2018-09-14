//
//  showResultViewController.swift
//  speedometer
//
//  Created by namik kaya on 21.08.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import UIKit
import GoogleMobileAds

class showResultViewController: UIViewController {
    
    
    private var sing:singleton!
    override func viewDidLoad() {
        super.viewDidLoad()
        sing = singleton.sharedInstance
        
        if sing.gecisReklami.isReady {
            sing.gecisReklami.present(fromRootViewController: self)
        } else {
            print("Geçiş reklamı hazır değil")
        }
        
        // ÖDÜLLÜ REKLAM
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            //GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
            print("ödüllü reklam hazır")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    @IBAction func openRewardAdVideo(_ sender: Any) {
        if GADRewardBasedVideoAd.sharedInstance().isReady == true {
            GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
        }else{
            print("ödüllü reklam hazır değil")
        }
    }
}
