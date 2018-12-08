//
//  Animations.swift
//  Button Animations
//
//  Created by Berdil İlyada Karacam on 9.12.2018.
//  Copyright © 2018 Berdil İlyada Karacam. All rights reserved.
//

import UIKit

class Animations {
    
    class func shake(view:UIView){
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        
        let fromPoint = CGPoint(x: view.center.x - 5, y: view.center.y)
        let fromValue = NSValue(cgPoint: fromPoint)
        
        let toPoint = CGPoint(x: view.center.x + 5, y: view.center.y)
        let toValue = NSValue(cgPoint: toPoint)
        
        shake.fromValue = fromValue
        shake.toValue = toValue
        
        view.layer.add(shake, forKey: "position")
    }
    
    class func pulse(view:UIView){
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        view.layer.add(pulse, forKey: "pulse")
    }
    
    class func flash(view:UIView){
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        
        flash.repeatCount = 3
        
        view.layer.add(flash, forKey: nil)
    }
}
