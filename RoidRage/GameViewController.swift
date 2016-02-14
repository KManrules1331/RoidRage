//
//  GameViewController.swift
//  RoidRage
//
//  Created by igmstudent on 11/18/15.
//  Copyright (c) 2015 Alpaca. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var level : Int!
    
    override func viewDidLoad() {
        if let scene = GameScene(fileNamed: "GameScene") {
            super.viewDidLoad()
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
 
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
        
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
        
            // Pass along access to this vc
            scene.refVC = self
        
            skView.presentScene(scene)
            
            scene.reset(level)
        }
    
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
        let skView = self.view as! SKView;
        skView.presentScene(nil);
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        let skView = self.view as! SKView;
        if let scene = skView.scene as? GameScene
        {
            scene.reset(level);
        }
    }
}
