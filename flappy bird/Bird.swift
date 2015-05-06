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
    var birdView : UIImageView!
    init(){
        birdView = UIImageView(image: bird)
    }
}