//
//  toogleButton.swift
//  speedometer
//
//  Created by namik kaya on 12.08.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import UIKit

@IBDesignable class toogleButton: UIButton {
    var isOn:Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initButton()
    }
    
    func initButton(){
        self.backgroundColor = UIColor.green
        
        addTarget(self, action: #selector(toogleButton.buttonPressed), for: .touchUpInside)
    }
    
    @objc func buttonPressed(){
        activeButton(bool: !isOn)
    }
    
    func activeButton(bool:Bool){
        isOn = bool
        let color = bool ? UIColor.red : UIColor.green
        let titleString = bool ? "Stop" : "Start"
        //self.setImage(img, for: .normal)
        self.setTitle(titleString, for: .normal)
        self.backgroundColor = color
    }

}
