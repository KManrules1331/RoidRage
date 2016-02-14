//
//  Missile.swift
//  RoidRage
//
//  Created by igmstudent on 11/21/15.
//  Copyright © 2015 Alpaca. All rights reserved.
//

import Foundation
import SpriteKit

class Missile {
    
    var physicsBody : SKPhysicsBody? {
        return sprite.physicsBody;
    }
    var position : Vector2 {
        return Vector2(sprite.position);
    }
    var rotation : Scalar {
        return Scalar(sprite.zRotation);
    }
    var scale : Vector2 {
        return Vector2(Scalar(sprite.xScale), Scalar(sprite.yScale));
    }
    
    private var sprite : SKSpriteNode;
    private var velocity : Vector2;
    
    init(scene: SKScene, position: CGPoint, direction: CGVector)
    {
        let height = CGFloat(44);
        let width = CGFloat(10);
        let speed = CGFloat(40);
        self.sprite = SKSpriteNode(imageNamed:"Missile");
        
        self.sprite.position = position;
        self.sprite.xScale = width / self.sprite.frame.width;
        self.sprite.yScale = height / self.sprite.frame.height;
        self.sprite.zPosition = DrawOrder.Sprites;
        
        self.sprite.physicsBody = SKPhysicsBody(rectangleOfSize: self.sprite.size);
        self.sprite.physicsBody?.categoryBitMask = PhysicsCategory.Projectile;
        self.sprite.physicsBody?.contactTestBitMask = PhysicsCategory.Asteroid;
        self.sprite.physicsBody?.collisionBitMask = PhysicsCategory.None;
        
        //Determine the rotation of the missile
        let angle = atan2(-direction.dx, direction.dy);
        self.sprite.zRotation = CGFloat(angle);
        
        //Finally, set velocity and launch missile
        velocity = Vector2(Scalar(direction.dx * speed), Scalar(direction.dy * speed));
        
        scene.addChild(self.sprite);
    }
    
    deinit {
        self.sprite.removeFromParent();
    }
    
    func collidedWithAsteroid()
    {
        //Can do something special here ...
    }
    
    func update(deltaTime: CFTimeInterval)
    {
        //Do something here.
        self.sprite.position = CGPoint(position + (velocity * Scalar(deltaTime)));
    }
}