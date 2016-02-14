//
//  Planet.swift
//  RoidRage
//
//  Created by igmstudent on 11/20/15.
//  Copyright © 2015 Alpaca. All rights reserved.
//

import SpriteKit

class Planet {
    
    var position : Vector2 {
        get {
            return Vector2(self.sprite.position);
        }
    }
    
    var radius : Scalar {
        get {
            return r
        }
    }
    
    var Score : Int {
        get {
            return self.score;
        }
    }
    
    var imgName : String!
    
    private var sprite : SKSpriteNode;
    private var scoreLabel : SKLabelNode;
    private var score = 5;
    private var missileCost = 1;
    private var r : Scalar = 0;
    
    init(scene: SKScene, position: CGPoint, diameter: CGFloat, imgName: String, startingScore: Int, missileCost: Int)
    {
        self.imgName = imgName;
        self.sprite = SKSpriteNode(imageNamed: imgName);
        self.sprite.position = position;
        self.sprite.xScale = diameter / self.sprite.frame.width
        self.sprite.yScale = diameter / self.sprite.frame.height;
        self.sprite.zPosition = DrawOrder.Sprites;
        
        self.r = Scalar(diameter * 0.5);
        
        self.sprite.physicsBody = SKPhysicsBody(circleOfRadius: diameter / 2);
        self.sprite.physicsBody?.categoryBitMask = PhysicsCategory.Planet;
        self.sprite.physicsBody?.contactTestBitMask = PhysicsCategory.Asteroid;
        self.sprite.physicsBody?.collisionBitMask = PhysicsCategory.None;
        
        self.score = startingScore;
        self.missileCost = missileCost;
        
        scene.addChild(self.sprite);
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster");
        scoreLabel.text = "\(score)";
        scoreLabel.fontSize = 50;
        scoreLabel.fontColor = SKColor.whiteColor();
        scoreLabel.position = position;
        scoreLabel.zPosition = DrawOrder.Labels;
        
        scene.addChild(scoreLabel);
    }
    
    deinit {
        sprite.removeFromParent();
        scoreLabel.removeFromParent();
    }
    
    func collidedWithAsteroid(life: Int)
    {
        //Here, we can decrease earth health, show it with assets or something.
        switch life{
        case 3 :
            self.sprite.texture = SKTexture(imageNamed: ("\(imgName)_Dmg1"));
        case 2:
            self.sprite.texture = SKTexture(imageNamed: ("\(imgName)_Dmg2"));
        case 1:
            self.sprite.texture = SKTexture(imageNamed: ("\(imgName)_Dmg3"));
        case 0:
            self.sprite.texture = SKTexture(imageNamed: ("\(imgName)_Dmg3"));
        default :
            self.sprite.texture = SKTexture(imageNamed: (imgName));
        }
        
    }
    func preparesMissile() -> Bool
    {
        if score >= missileCost
        {
            score -= missileCost;
            scoreLabel.text = "\(score)";
            return true;
        }
        return false;
    }
    func missileHitAsteroid()
    {
        //Here, we will update the score text
        score += 3;
        scoreLabel.text = "\(score)";
    }
    
    func update(deltaTime: CFTimeInterval)
    {
        //Here we can update values, or something.
        self.sprite.zRotation = self.sprite.zRotation + CGFloat((M_PI / 60) * deltaTime);
    }
}