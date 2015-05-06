//
//  ViewController.swift
//  flappy bird
//
//  Created by Thắng on 4/24/15.
//  Copyright (c) 2015 Trương Minh Thắng. All rights reserved.
//

import UIKit
class ViewController : UIViewController, UICollisionBehaviorDelegate{
    
    
    // tạo class bird
    var bird : Bird!
    // tạo class screen
    var screen : Screen!
    
    // tạo bộ timer để chạy screen và ống khói. Bộ timer này có thể là nil
    var timer : NSTimer?
    var timerFlag = 0
    var nanosec = 1 / 100
    var dx : CGFloat {
        return view.bounds.width / 600
    }
    // tạo hàm mà timer gọi tới
    func move (timer: NSTimer){
        screen.move(dx)
        
        
    }
    // tạo gestrue tap
    var tap : UITapGestureRecognizer!
    
    func handleTap(tap: UITapGestureRecognizer){
        // phát ra âm thanh
        // bắt đầu chạy
        if timerFlag == 0 {
            timer = NSTimer.scheduledTimerWithTimeInterval(
                Double(nanosec),
                target: self,
                selector: "move:",
                userInfo: nil,
                repeats: true
            )
            timerFlag++
            
        }
        
        var push = UIPushBehavior(items: [bird.birdView], mode: UIPushBehaviorMode.Instantaneous)
        push.setAngle(CGFloat(-M_PI_2), magnitude: CGFloat(0.8))
        
        for item in animator.behaviors {
            
            animator.removeBehavior(item as! UIDynamicBehavior)
        }
        
        animator.addBehavior(gravity)
        animator.addBehavior(push)
        collision.collisionDelegate = self
        animator.addBehavior(collision)
        
        
        
    }
    // tạo va chạm
    var animator : UIDynamicAnimator!
    var collision : UICollisionBehavior!
    var gravity: UIGravityBehavior!
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint){
        // nếu chạm vào thì chết
        birdDead()
        
        
    }
    
    func birdDead(){
        // dừng dịch chuyển
        
        view.removeGestureRecognizer(tap)
        if timer?.valid == true {
            timer?.invalidate()
            timer = nil
            // hiển thị GameOver
            
            
            gameOver()
        }
        if bird.birdView.center.y > (view.bounds.height - 20) || bird.birdView.center.y < 0 {
            animator.removeAllBehaviors()
            bird.birdView.center.y =  view.bounds.height - 20
            var transfrom = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
            bird.birdView.transform = transfrom
            
            
            
        }
    }
    // tạo nút pause
    var btnPause : UIButton!
    func pause (sender : UIButton){
        // dừng hình
        if timer?.valid == true {
            timer?.invalidate()
            timer = nil
        }
        else {
            timer = NSTimer.scheduledTimerWithTimeInterval(
                Double(nanosec),
                target: self,
                selector: "move:",
                userInfo: nil,
                repeats: true
            )
            
        }
        // hiện fillter. Có nút play ở giữa
        
    }
    var gameover : Gameover!
    func gameOver(){
        gameover = Gameover(frame: view.frame)
        
        gameover.replay.addTarget(self,
            action: "newgame", forControlEvents: UIControlEvents.TouchDown)
        view.addSubview(gameover)
        
    }
    
    func newgame(){
        resetAllThing()
        setNewgame()
    }
    func resetAllThing(){
        timerFlag = 0
        if bird != nil {
            bird.birdView.removeFromSuperview()
            bird = nil
        }
        
        if tap != nil {
            view.removeGestureRecognizer(tap)
            
        }
        if (btnPause != nil){
            btnPause.removeFromSuperview()
        }
    }
    func setNewgame(){
        animator = UIDynamicAnimator (referenceView: view)
        
        tap = UITapGestureRecognizer(target: self, action: "handleTap:")
        view.addGestureRecognizer(tap)
        bird = Bird()
        bird.birdView.center.x = view.bounds.width / 3
        bird.birdView.center.y = view.center.y
        gravity = UIGravityBehavior(items: [bird.birdView])
        collision = UICollisionBehavior(items: [bird.birdView])
        screen = Screen(frame: view.frame, collision: collision)
        view.addSubview(screen)
        screen.newgame()
        view.addSubview(bird.birdView)
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        newgame()
        
        
        
        
        
    }
}