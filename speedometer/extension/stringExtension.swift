//
//  stringExtension.swift
//  speedometer
//
//  Created by namik kaya on 7.08.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var convertSpeed: [Character] {
        var newString = self
        if (self.count == 1){
            newString = "00"+self
        }
        
        if(self.count == 2){
            newString = "0"+self
        }
        
        if(self.count == 3){
            newString = self
        }
        
        let characters = Array(newString)
        return characters
    }
    
    var attrKmh:NSMutableAttributedString{
        let attributedString = NSMutableAttributedString(string: "topSpeed: " + self + " km/s\n")
        
        let attributes0: [NSAttributedStringKey : Any] = [
            .foregroundColor: UIColor(red: 230/255, green: 0/255, blue: 0/255, alpha: 1.0)
        ]
        attributedString.addAttributes(attributes0, range: NSRange(location: 0, length: 10))
        
        // burası km
        
        var range1 = NSRange(location: 10, length: 4)
        var range2 = NSRange(location: 14, length: 4)
        if(self.count == 3 ){
            range1 = NSRange(location: 10, length: 4)
            range2 = NSRange(location: 14, length: 4)
        }
        if(self.count == 2){
            range1 = NSRange(location: 10, length: 3)
            range2 = NSRange(location: 13, length: 4)
        }
        
        if(self.count == 1){
            range1 = NSRange(location: 10, length: 1)
            range2 = NSRange(location: 12, length: 4)
        }
        /*
        if(self.count == 1){
            range1 = NSRange(location: 10, length: 2)
        }*/

        
        let attributes1: [NSAttributedStringKey : Any] = [
            .foregroundColor: UIColor(red: 230/255, green: 0/255, blue: 0/255, alpha: 1.0),
            .font: UIFont(name: "HelveticaNeue-Bold", size: 45)!
        ]
        attributedString.addAttributes(attributes1, range: range1)
        
        let attributes2: [NSAttributedStringKey : Any] = [
            .foregroundColor: UIColor(red: 230/255, green: 0/255, blue: 0/255, alpha: 1.0)
        ]
        attributedString.addAttributes(attributes2, range: range2)
        
        return attributedString
    }
}
