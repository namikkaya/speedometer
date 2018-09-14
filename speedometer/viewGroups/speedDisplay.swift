//
//  speedDisplay.swift
//  speedometer
//
//  Created by namik kaya on 8.08.2018.
//  Copyright © 2018 namik kaya. All rights reserved.
//

import UIKit
@IBDesignable class speedDisplay: UIView {
    private var view:UIView!
    private var nibName:String = "speedDisplay"
    
    @IBOutlet weak var hundreds: UILabel!
    @IBOutlet weak var tens: UILabel!
    @IBOutlet weak var units: UILabel!
    
    var setDisplayText:[Character] = ["c"] {
        didSet{
            
            if(String(setDisplayText[0]) == "0"){
                hundreds.text = ""
            }else{
                hundreds.text = String(setDisplayText[0])
            }
            
            if(String(setDisplayText[0]) == "0" && String(setDisplayText[1]) == "0"){
                tens.text = ""
            }else{
                tens.text = String(setDisplayText[1])
            }
            
            units.text = String(setDisplayText[2])
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib()-> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

}
