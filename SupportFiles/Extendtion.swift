//
//  Extendtion.swift
//  workDictionary
//
//  Created by Fan Wu on 11/12/18.
//  Copyright © 2018 8184. All rights reserved.
//

import Foundation
import UIKit

// MARK: UIView
extension UIView {
    
    //start wiggle animation
    func startWiggle(wiggleBounceY: Double = 4, wiggleBounceDuration: Double = 0.12, wiggleBounceDurationVariance: Double = 0.025, wiggleRotateAngle: Double = 0.06, wiggleRotateDuration: Double = 0.1, wiggleRotateDurationVariance: Double = 0.025) {
        func randomize(interval: TimeInterval, withVariance variance: Double) -> Double {
            let random = (Double(arc4random_uniform(1000)) - 500.0) / 500.0
            return interval + variance * random
        }
        
        //Create rotation animation
        let rotationAnim = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotationAnim.values = [-wiggleRotateAngle, wiggleRotateAngle]
        rotationAnim.autoreverses = true
        rotationAnim.duration = randomize(interval: wiggleRotateDuration, withVariance: wiggleRotateDurationVariance)
        rotationAnim.repeatCount = HUGE
        
        //Create bounce animation
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        bounceAnimation.values = [wiggleBounceY, 0]
        bounceAnimation.autoreverses = true
        bounceAnimation.duration = randomize(interval: wiggleBounceDuration, withVariance: wiggleBounceDurationVariance)
        bounceAnimation.repeatCount = HUGE
        
        //Apply animations to view
        UIView.animate(withDuration: 0) {
            self.layer.add(rotationAnim, forKey: "rotation")
            self.layer.add(bounceAnimation, forKey: "bounce")
            self.transform = .identity
        }
    }
    
    //stop wiggle animation
    func stopWiggle(){ layer.removeAllAnimations() }
}
