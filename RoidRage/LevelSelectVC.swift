//
//  LevelSelectVC.swift
//  RoidRage
//
//  Created by igmstudent on 11/22/15.
//  Copyright © 2015 Alpaca. All rights reserved.
//

import UIKit

class LevelSelectVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    // Start level 1
    @IBAction func Lvl1Pressed(sender: AnyObject) {
        let game = storyboard?.instantiateViewControllerWithIdentifier("GameView") as! GameViewController;
        game.level = 1;
        self.navigationController?.pushViewController(game, animated: true);
    }
    
    // Start level 2
    @IBAction func Lvl2Pressed(sender: AnyObject) {
        let game = storyboard?.instantiateViewControllerWithIdentifier("GameView") as! GameViewController;
        game.level = 2;
        self.navigationController?.pushViewController(game, animated: true);
    }
    
    // Start level 3
    @IBAction func Lvl3Pressed(sender: AnyObject) {
        let game = storyboard?.instantiateViewControllerWithIdentifier("GameView") as! GameViewController;
        game.level = 3;
        self.navigationController?.pushViewController(game, animated: true);
    }
    
    
    // Start level 4
    @IBAction func Lvl4Pressed(sender: AnyObject) {
        let game = storyboard?.instantiateViewControllerWithIdentifier("GameView") as! GameViewController;
        game.level = 4;
        self.navigationController?.pushViewController(game, animated: true);
    }
    
    
    @IBAction func MenuBtn(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true);
    }
    

}
