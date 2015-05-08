//
//  Bird.swift
//  flappy bird
//
//  Created by Thắng on 4/26/15.
//  Copyright (c) 2015 Trương Minh Thắng. All rights reserved.
//

import Foundation
import UIKit
class Bird {
    var bird = UIImage(named: "bird")
    var birdDead = UIImage(named: "birdDead")
    var birdView : UIImageView!
    var gravity: UIGravityBehavior!
    var i = 0

    init(){
        birdView = UIImageView(image: bird)
        gravity = UIGravityBehavior(items: [birdView])

    }
    func fly(animator: UIDynamicAnimator) {
        var push = UIPushBehavior(items: [birdView], mode: UIPushBehaviorMode.Instantaneous)
        push.setAngle(CGFloat(-M_PI_2), magnitude: CGFloat(0.8))
        
        for item in animator.behaviors {
            
            animator.removeBehavior(item as! UIDynamicBehavior)
        }
        animator.addBehavior(push)
        animator.addBehavior(gravity)
    }
    func dead(VCCollision: UICollisionBehavior, animator: UIDynamicAnimator){
        if i == 0 {
            var view = birdView.superview
            var point = birdView.center
            birdView.removeFromSuperview()

            VCCollision.removeItem(birdView)
            animator.removeBehavior(gravity)
            birdView = nil
            
            birdView = UIImageView(image: birdDead)
            gravity = UIGravityBehavior(items: [birdView])

            birdView.center = point
            view?.insertSubview(birdView, atIndex: view!.subviews.count - 1)
            VCCollision.addItem(birdView)
            animator.addBehavior(gravity)

            
            
        }
    }
}