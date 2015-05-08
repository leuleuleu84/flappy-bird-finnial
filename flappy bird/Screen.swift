//
//  Screen.swift
//  flappy bird
//
//  Created by Thắng on 4/26/15.
//  Copyright (c) 2015 Trương Minh Thắng. All rights reserved.
//

import Foundation
import UIKit

class Screen : UIView {
    var imgScreen = UIImage(named: "background")
    var background1 : UIImageView!
    var background2 : UIImageView!
    var collision: UICollisionBehavior!
    var chimney1 : Chimney!
    var chimney2 : Chimney!
    
    var frameRight : CGRect!
    var frameLeft: CGRect!
    var ordinateX :CGFloat = 1000
    var lb_score : UILabel!
    func resetAllThing(){
        flagScore1 = 0
        flagScore2 = 0
        if chimney1 != nil || chimney2 != nil {
            removeChimney()
        }
        if lb_score != nil {
            lb_score.removeFromSuperview()
        }

    }
    func setNewgame(){
        chimney1 = Chimney(ordinateX: ordinateX, screenHeight: super.bounds.height)
        
        ordinateX += (super.bounds.width + chimney1.width) / 2
        
        chimney2 = Chimney(ordinateX: ordinateX, screenHeight: super.bounds.height)
        makeScoreLabel()
    }
    func newgame(){
        resetAllThing()
        setNewgame()
       
    }
    func makeScoreLabel(){
        lb_score = UILabel(frame: CGRect(x: 10, y: 40, width: 80, height: 40))
        lb_score.textAlignment = NSTextAlignment.Left
        lb_score.text = "Score: 0"
        lb_score.font = UIFont(name: ".System", size: 38)
        lb_score.textColor = UIColor.whiteColor()
        super.addSubview(lb_score)
    }
    var score :Int = 0 {
        didSet{
            lb_score.text = "Score :  " + String(score)
        }
       
    }
    var flagScore1 :Int = 0
    var flagScore2 :Int = 0
    init(frame: CGRect, collision: UICollisionBehavior) {
        super.init(frame: frame)
        self.collision = collision
        frameLeft = CGRect(x: -super.bounds.width, y: 0, width: super.bounds.width, height: super.bounds.height)
        frameRight = CGRect(x: super.bounds.width, y: 0, width: super.bounds.width, height: super.bounds.height)
        background1 = UIImageView(image: imgScreen)
        background1.frame = super.frame

        super.addSubview(background1)
        newgame()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addChimney(){
        super.addSubview(chimney1.chimneyTop)
        super.addSubview(chimney1.chimneyBottom)
        super.addSubview(chimney2.chimneyTop)
        super.addSubview(chimney2.chimneyBottom)
        chimney1.chimneyTop.backgroundColor = UIColor.grayColor()
        chimney1.chimneyBottom.backgroundColor = UIColor.grayColor()
        chimney2.chimneyTop.backgroundColor = UIColor.grayColor()
        chimney2.chimneyBottom.backgroundColor = UIColor.grayColor()
        super.bringSubviewToFront(lb_score)


        
        collision.addBoundaryWithIdentifier("chimney1Top", forPath: UIBezierPath(rect: chimney1.frameTop))
        collision.addBoundaryWithIdentifier("chimney1Bottom", forPath: UIBezierPath(rect: chimney1.frameBottom))
        collision.addBoundaryWithIdentifier("chimney2Top", forPath: UIBezierPath(rect: chimney2.frameTop))
        collision.addBoundaryWithIdentifier("chimney2Bottom", forPath: UIBezierPath(rect: chimney2.frameBottom))
        collision.addBoundaryWithIdentifier("deadLine", fromPoint: CGPoint(x: -super.bounds.width, y: super.bounds.height), toPoint: CGPoint(x: super.bounds.width, y: super.bounds.height))

    }
    func removeChimney(){
        chimney1.chimneyTop.removeFromSuperview()
        chimney1.chimneyBottom.removeFromSuperview()
        chimney2.chimneyTop.removeFromSuperview()
        chimney2.chimneyBottom.removeFromSuperview()
        collision.removeAllBoundaries()
        
    }
    func moveChimney(dx: CGFloat){
        removeChimney()
        chimney1.move(dx)
        addChimney()

        removeChimney()
        chimney2.move(dx)
        addChimney()
        
        if chimney1.chimneyBottom.center.x <= (super.bounds.width / 3) && flagScore1 == 0
        {
                score++
            flagScore1++
        }
        if chimney2.chimneyBottom.center.x <= (super.bounds.width / 3) && flagScore2 == 0
        {
            score++
            flagScore2++

            
        }

    }
    
    func makeChimney1(){
        ordinateX = super.bounds.width
        removeChimney()
        chimney1 = nil
        chimney1 = Chimney(ordinateX: ordinateX, screenHeight: super.bounds.height)
        addChimney()
        flagScore1--
        
    }
    func makeChimney2(){
        ordinateX = super.bounds.width
        removeChimney()
        chimney2 = nil
        chimney2 = Chimney(ordinateX: ordinateX, screenHeight: super.bounds.height)
        addChimney()
        flagScore2--

        
    }
    func move(dx: CGFloat){
        // move đồng thời 2 cái background và chimney
       
        moveChimney(dx)
        checkChimneyBound()

        
    }
    
    func checkChimneyBound(){

        if chimney1.chimneyBottom.center.x <= -30 {
            makeChimney1()
        }
        if chimney2.chimneyBottom.center.x <= -30 {
            makeChimney2()
        }
    }
    func checkBounds(view: UIView){
        if view.center.x <= -super.bounds.width / 2 {
            view.frame = frameRight

        }
        
    }
    
    
    
}