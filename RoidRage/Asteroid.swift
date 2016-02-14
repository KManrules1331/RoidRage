//
//  Asteroid.swift
//  RoidRage
//
//  Created by igmstudent on 11/20/15.
//  Copyright © 2015 Alpaca. All rights reserved.
//

import SpriteKit

class Asteroid {
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
    var Radius : Scalar {
        return radius;
    }
    
    private var sprite : SKSpriteNode;
    private var radius : Scalar;
    private var velocity : Vector2;
    
    init(scene: SKScene, position: CGPoint, diameter: CGFloat, initialVelocity: CGVector)
    {
        if diameter > 50
        {
            self.sprite = SKSpriteNode(imageNamed: "LargeAsteroid");
        }
        else
        {
            //Select randomized asteroid image
            let imageRoll = random() % 3;
            switch(imageRoll)
            {
            case 0:
                self.sprite = SKSpriteNode(imageNamed:"Asteroid_01");
                break;
            case 1:
                self.sprite = SKSpriteNode(imageNamed:"Asteroid_02");
                break;
            case 2:
                self.sprite = SKSpriteNode(imageNamed:"Asteroid_03");
                break;
            default:
                self.sprite = SKSpriteNode(imageNamed:"Asteroid_01");
                break;
            }
            
        }
        self.sprite.position = position;
        self.sprite.xScale = diameter / self.sprite.frame.width
        self.sprite.yScale = diameter / self.sprite.frame.height;
        self.sprite.zPosition = DrawOrder.Sprites;
        
        self.sprite.physicsBody = SKPhysicsBody(circleOfRadius: diameter / 2);
        self.sprite.physicsBody?.categoryBitMask = PhysicsCategory.Asteroid;
        self.sprite.physicsBody?.contactTestBitMask = PhysicsCategory.Planet | PhysicsCategory.Projectile;
        self.sprite.physicsBody?.collisionBitMask = PhysicsCategory.None;
        
        velocity = Vector2(Scalar(initialVelocity.dx), Scalar(initialVelocity.dy));
        radius = Scalar(diameter / 2);
        
        scene.addChild(self.sprite);
    }
    
    deinit
    {
        self.sprite.removeFromParent();
    }
    
    func collidedWithMissile(scene: SKScene) -> [Asteroid]
    {
        return subdivide(scene);
    }
    func collidedWithEarth()
    {
        
    }
    
    func subdivide(scene: SKScene) -> [Asteroid]
    {
        if (radius <= 25)
        {
            return [Asteroid]();
        }
        //Subdivide!
        var asteroids = [Asteroid]();
        
        //Asteroid splits in 2
        let separationVector = Vector2(0.0, 1.0);
        let separationVec1 = separationVector.rotatedBy(-Scalar.Pi / 2);
        let separationVec2 = separationVector.rotatedBy(Scalar.Pi / 2);
        
        //Distance new asteroid positions from center
        let position1 = position + separationVec1.normalized() * radius / 2;
        let position2 = position + separationVec2.normalized() * radius / 2;
        
        //Adjust velocities
        let velocity1 = velocity + separationVec1.normalized() * 8;
        let velocity2 = velocity + separationVec2.normalized() * 8;
        
        asteroids.append(Asteroid(scene: scene, position: CGPoint(position1), diameter: CGFloat(radius), initialVelocity: CGVector(velocity1)));
        asteroids.append(Asteroid(scene: scene, position: CGPoint(position2), diameter: CGFloat(radius), initialVelocity: CGVector(velocity2)));
        
        return asteroids;
    }
    
    func update(deltaTime: CFTimeInterval, planetPosition: Vector2, gravityForce: Scalar)
    {
        //Here we can update values, or something.
        var position = Vector2(Scalar(self.sprite.position.x), Scalar(self.sprite.position.y));
        let toPlanet = planetPosition - position;
        let toPlanetDir = toPlanet.normalized();
        let acceleration = toPlanetDir * gravityForce / (radius * 0.02);
        velocity = velocity + acceleration * Scalar(deltaTime);
        position = position + (velocity * Scalar(deltaTime));
        self.sprite.position = CGPoint(x: CGFloat(position.x), y: CGFloat(position.y));
        
        //Update Rotation
        self.sprite.zRotation = self.sprite.zRotation + CGFloat((M_PI / 45) * deltaTime);
    }
}