//
//  GameOverScene.swift
//  RoidRage
//
//  Created by igmstudent on 11/21/15.
//  Copyright © 2015 Alpaca. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene : SKScene {
    
    init(size: CGSize, won: Bool, refGameVC: UIViewController) {
        
        super.init(size: size);
        
        backgroundColor = SKColor.whiteColor();
        let message = won ? "You Won!" : "You Lose"
        
        let label = SKLabelNode(fontNamed: "Chalkduster");
        label.text = message;
        label.fontSize = 40;
        label.fontColor = SKColor.blackColor();
        label.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5);
        addChild(label);
        
        let splashScreen = SKSpriteNode(imageNamed: "PlanetDestroyed")
        self.addChild(splashScreen)
        
        runAction(SKAction.sequence([
            SKAction.waitForDuration(3.0),
            SKAction.runBlock() {
                
                let reveal = SKTransition.flipHorizontalWithDuration(0.5);
                let scene = GameScene(fileNamed: "GameScene");
                scene!.size = size;
                scene!.scaleMode = .AspectFill;
                self.view?.presentScene(scene!, transition: reveal);
            }]));
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
