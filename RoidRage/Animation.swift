//
//  Animation.swift
//  RoidRage
//
//  Created by igmstudent on 12/13/15.
//  Copyright © 2015 Alpaca. All rights reserved.
//

import SpriteKit

class Animation : SKSpriteNode
{
    var animationFrames : [SKTexture];
    var animationID = NSUUID().UUIDString;
    
    init(atlasName: String, baseAnimationName: String)
    {
        let animationAtlas = SKTextureAtlas(named: atlasName);
        animationFrames = [SKTexture]();
        
        let numFrames = animationAtlas.textureNames.count;
        for var i = 0; i < numFrames; ++i
        {
            let textureName = "\(baseAnimationName)\(i+1)";
            animationFrames.append(animationAtlas.textureNamed(textureName));
        }
        
        let firstFrame = animationFrames[0];
        super.init(texture: firstFrame, color: UIColor.clearColor(), size: firstFrame.size());
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func playOnce()
    {
        runAction(SKAction.animateWithTextures(animationFrames, timePerFrame: 0.1, resize: false, restore: true), withKey: "\(animationID)Play");
    }
    
    func play()
    {
        runAction(SKAction.repeatActionForever(
            SKAction.animateWithTextures(
                animationFrames,
                timePerFrame: 0.1,
                resize: false,
                restore: true)),
            withKey: "\(animationID)Play");
    }
    
    func stop()
    {
        removeActionForKey("\(animationID)Play");
    }
}
