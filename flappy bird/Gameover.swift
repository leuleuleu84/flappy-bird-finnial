//
//  Gameover.swift
//  flappy bird
//
//  Created by Thắng on 5/6/15.
//  Copyright (c) 2015 Trương Minh Thắng. All rights reserved.
//

import UIKit
class Gameover: UIView {
    var img = UIImage(named: "gameover")
    var gameoverView : UIImageView!
    var replay : UIButton!
    override init(frame: CGRect){
        super.init(frame: frame)
        var background = UIView(frame: super.frame)
        background.backgroundColor = UIColor.lightGrayColor()
        background.alpha = 0.5
        super.addSubview(background)
        
        gameoverView = UIImageView(image: img)
        gameoverView.frame = CGRect(x: 0, y: 0, width: super.bounds.width, height: 200)
        gameoverView.center = super.center
        gameoverView.center.y = super.center.y - 70
        super.addSubview(gameoverView)
        
        replay = UIButton.buttonWithType(.System) as! UIButton
        replay.setTitle("Replay", forState: UIControlState.Normal)
        replay.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        replay.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        replay.center = super.center
        super.addSubview(replay)

        super.bringSubviewToFront(gameoverView)
        super.bringSubviewToFront(replay)

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}