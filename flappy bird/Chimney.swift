//
//  ChimneyModel.swift
//  flappy bird
//
//  Created by Thắng on 4/26/15.
//  Copyright (c) 2015 Trương Minh Thắng. All rights reserved.
//

import Foundation
import UIKit

class Chimney {
    var width: CGFloat = 50
    var slotHeight: CGFloat = 200
    var screenHeight: CGFloat
    var frameTop: CGRect!
    var frameBottom: CGRect!
    var chimneyTop = UIView()
    var chimneyBottom = UIView()
    var x : CGFloat!
    var y0 : CGFloat!
    init (ordinateX: CGFloat, screenHeight: CGFloat){
        self.screenHeight = screenHeight
        x = ordinateX
        y0 = CGFloat(100 + arc4random_uniform(UInt32(screenHeight - 400)))
        frameTop = CGRect(
            x: x,
            y: 0,
            width: width,
            height: y0
        )
        
        frameBottom = CGRect(
            x: x,
            y: y0 + slotHeight,
            width: width,
            height: screenHeight - y0 - slotHeight
        )
        setFrame()
    }
    
    func move(dx: CGFloat){
        x! -= dx
        frameTop = CGRect(
            x: x,
            y: 0,
            width: width,
            height: y0
        )
        
        frameBottom = CGRect(
            x: x,
            y: y0 + slotHeight,
            width: width,
            height: screenHeight - y0 - slotHeight
        )
        setFrame()
        
    }
    func setFrame(){
        chimneyTop.frame = frameTop
        chimneyBottom.frame = frameBottom
    }
    
}