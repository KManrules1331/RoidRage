//
//  Explosion.swift
//  RoidRage
//
//  Created by igmstudent on 12/13/15.
//  Copyright © 2015 Alpaca. All rights reserved.
//

import SpriteKit

class Explosion : Animation {
    var playing = false;
    
    init(position: Vector2, angle: Scalar, scale: Vector2)
    {
        super.init(atlasName: "ExplosionAnimation", baseAnimationName: "explosion_");
        self.position = CGPoint(position);
        self.zRotation = CGFloat(angle);
        self.zPosition = DrawOrder.Sprites
        self.xScale = CGFloat(scale.x) / self.frame.width;
        self.yScale = CGFloat(scale.y) / self.frame.height;
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func playExplosion(scene: SKScene) {
        playing = true;
        runAction(SKAction.playSoundFileNamed("explosionSound.caf", waitForCompletion: false));
        scene.addChild(self);
        runAction(SKAction.sequence([
            SKAction.animateWithTextures(animationFrames, timePerFrame: 0.1, resize: false, restore: true),
            SKAction.runBlock({self.endExplosion()})
        ]));
    }
    
    private func endExplosion() {
        removeFromParent();
        playing = false;
    }
}
