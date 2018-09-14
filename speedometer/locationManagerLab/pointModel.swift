//
//  pointModel.swift
//  speedometer
//
//  Created by namik kaya on 12.08.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import Foundation

struct pointModel {
    var lat:Double
    var long:Double
    var speed:Double
    var currentDate:Date
    
    init(lat:Double, long:Double, speed:Double, currentDate:Date) {
        self.lat = lat
        self.long = long
        self.speed = speed
        self.currentDate = currentDate
    }
    
}
