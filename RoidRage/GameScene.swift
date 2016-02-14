//
//  GameScene.swift
//  RoidRage
//
//  Created by igmstudent on 11/18/15.
//  Copyright (c) 2015 Alpaca. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var planet : Planet!
    var asteroids : [Asteroid] = [];
    var missiles : [Missile] = [];
    var explosions : [Explosion] = [];
    var prevFrameTimeStamp : CFTimeInterval = CFTimeInterval();
    
    // Editable vars for different levels
    var levelInfo : LevelData!
    
    // Ref to the VC that controlls this game secene
    weak var refVC : UIViewController?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        physicsWorld.gravity = CGVectorMake(0, 0);
        physicsWorld.contactDelegate = self;
        
        let background = SKSpriteNode(imageNamed: "GameBackground", normalMapped: true);
        background.size = size;
        background.position = CGPointMake(size.width / 2, size.height / 2);
        background.zPosition = DrawOrder.Background;
        
        addChild(background);
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            if planet.preparesMissile() {
                let location = Vector2(touch.locationInNode(self));
            
                let direction = (location - planet.position).normalized();
                let spawnPosition = planet.position + (direction * planet.radius);
            
                let CGDirection = CGVector(direction);
            
                missiles.append(Missile(scene: self, position: CGPoint(spawnPosition), direction: CGDirection));
            }
        }
    }
    
    func addAsteroid() {
        let top = random() & 0x1;
        var randomPos = Vector2(Scalar(0), Scalar(0));
        var velocity : CGVector;
        if top != 0 {
            randomPos.y = 0;
        }
        else {
            randomPos.y = Scalar(size.height);
        }
        randomPos.x = Math.randomScalar(Scalar(0.0), max: Scalar(size.width));
        
        //Roll for size
        let sizeRoll = random() % 10;
        var diameter : CGFloat;
        if sizeRoll == 0
        {
            //Large asteroid
            diameter = 100;
        }
        else
        {
            //Small asteroid
            diameter = 50;
        }
        
        let direction = (planet.position - randomPos).normalized();
        //Randomize direction a bit
        
        let randomAngle = Math.randomScalar(Scalar(-M_PI_4), max: Scalar(M_PI_4));
        let velDir = direction.rotatedBy(randomAngle)
        velocity = CGVector(dx: CGFloat(velDir.x * levelInfo.asteroidVelocity), dy: CGFloat(velDir.y * levelInfo.asteroidVelocity));
        
        asteroids.append(Asteroid(scene: self, position: CGPoint(randomPos), diameter: diameter, initialVelocity: velocity));
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        //Determine Delta Time
        var deltaTime = currentTime - prevFrameTimeStamp;
        if deltaTime > 0.1
        {
            deltaTime = 0.1;
        }
        
        planet.update(deltaTime);
        //Get planet position and gravity
        let planetGravity = Scalar(levelInfo.planetGravity);
        
        for asteroid in asteroids
        {
            asteroid.update(deltaTime, planetPosition: planet.position, gravityForce: planetGravity);
        }
        for missile in missiles
        {
            missile.update(deltaTime);
        }
        
        //Save time stamp
        prevFrameTimeStamp = currentTime;
        
        //Clean explosions when done playing
        for var i = 0; i < explosions.count; ++i {
            if !explosions[i].playing {
                explosions.removeAtIndex(i);
                --i;
            }
        }
        
        if(levelInfo.lives <= 0){
            levelInfo.lives = 1;
            onLoss()
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        // 1
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask
        {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else
        {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        // 2
        if ((firstBody.categoryBitMask & PhysicsCategory.Planet != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Asteroid != 0))
        {
            for i in 0..<asteroids.count {
                if asteroids[i].physicsBody == secondBody {
                    asteroids[i].collidedWithEarth();
                    asteroids.removeAtIndex(i);
                    break;
                }
            }
            levelInfo.lives--;
            planet.collidedWithAsteroid(levelInfo.lives);
        }
        
        else if ((firstBody.categoryBitMask & PhysicsCategory.Asteroid != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Projectile != 0))
        {
            planet.missileHitAsteroid();
            
            for i in 0..<missiles.count {
                if missiles[i].physicsBody == secondBody {
                    missiles[i].collidedWithAsteroid();
                    missiles.removeAtIndex(i);
                    break;
                }
            }
            
            for i in 0..<asteroids.count {
                if asteroids[i].physicsBody == firstBody {
                    //Add explosion effect
                    let explosionEffect = Explosion(position: asteroids[i].position, angle: 0, scale: Vector2(Scalar(50), Scalar(50)));
                    explosionEffect.playExplosion(self);
                    explosions.append(explosionEffect);
                    
                    let newAsteroids = asteroids[i].collidedWithMissile(self);
                    asteroids.appendContentsOf(newAsteroids);
                    asteroids.removeAtIndex(i);
                    break;
                }
            }
            
            if planet.Score >= levelInfo.scoreToWin {
                onWin();
            }
        }
        
    }
    
    func onLoss() {
        cleanUp()
        
        let lossVC = refVC?.storyboard?.instantiateViewControllerWithIdentifier("LossMenu") as! LossMenuVC
        refVC?.navigationController?.pushViewController(lossVC, animated: true);
       
        /*let reveal = SKTransition.flipHorizontalWithDuration(0.5);
        let gameOverScene = GameOverScene(size: self.size, won: false);
        self.view?.presentScene(gameOverScene, transition: reveal);*/
    }
    
    func onWin() {
        cleanUp()
        
        let winVC = refVC?.storyboard?.instantiateViewControllerWithIdentifier("WinMenu") as! WinMenuVC
        refVC?.navigationController?.pushViewController(winVC, animated: true)
    }
    
    func cleanUp() {
        asteroids.removeAll();
        missiles.removeAll();
        
        removeActionForKey("mainAction")
    }
    
    func reset(levelToplay: Int) {
        cleanUp();
        
        // "Load" level data
        levelInfo = LevelData(currentLevel: levelToplay);
        
        planet = Planet(scene: self, position: CGPoint(x: size.width / CGFloat(2.0), y: size.height / CGFloat(2.0)), diameter: levelInfo.planetDiameter, imgName: levelInfo.planetImgName, startingScore: levelInfo.startingScore, missileCost: levelInfo.missileCost);
        
        runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.runBlock(addAsteroid), SKAction.waitForDuration(1.5)])), withKey: "mainAction");
    }
}
