//
//  LevelInfo.swift
//  RoidRage
//
//  Created by igmstudent on 12/13/15.
//  Copyright © 2015 Alpaca. All rights reserved.
//

import Foundation
import SpriteKit

struct LevelData {
    
    var lives : Int
    var planetDiameter : CGFloat
    var planetGravity : Scalar
    var planetImgName : String
    var asteroidVelocity : Float
    var asteroidSpawnRate : NSTimeInterval
    var missileCost : Int
    var startingScore : Int
    var scoreToWin : Int
    
    
    init(currentLevel: Int){
        
        switch currentLevel{
        case 1:
            lives = 4
            planetDiameter = 100
            planetGravity = 4.0
            asteroidVelocity = 20
            asteroidSpawnRate = 1.5
            missileCost = 1;
            startingScore = 5;
            scoreToWin = 30;
            planetImgName = "Planet_1"
        case 2:
            lives = 4
            planetDiameter = 200
            planetGravity = 5.0
            asteroidVelocity = 20
            asteroidSpawnRate = 1.25
            missileCost = 1;
            startingScore = 3;
            scoreToWin = 30;
            planetImgName = "Planet_2"
        case 3:
            lives = 4
            planetDiameter = 75
            planetGravity = 16.0
            asteroidVelocity = 75
            asteroidSpawnRate = 0.75
            missileCost = 2;
            startingScore = 6;
            scoreToWin = 30;
            planetImgName = "Planet_3"
        case 4:
            lives = 4
            planetDiameter = 300
            planetGravity = 20.0
            asteroidVelocity = 20
            asteroidSpawnRate = 1.00
            missileCost = 2;
            startingScore = 4;
            scoreToWin = 30;
            planetImgName = "Planet_4"
            
        default:
            print("Error loading level data")
            
            lives = 4
            planetDiameter = 100
            planetGravity = 4.0
            asteroidVelocity = 20
            asteroidSpawnRate = 1.5
            missileCost = 1;
            startingScore = 5;
            scoreToWin = 30;
            planetImgName = "Planet_01"
        }
    }
    
}