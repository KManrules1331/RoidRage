//
//  MainMenuVC.swift
//  RoidRage
//
//  Created by igmstudent on 11/22/15.
//  Copyright © 2015 Alpaca. All rights reserved.
//

import UIKit

class MainMenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startGameBtn() {
        let newGame = storyboard!.instantiateViewControllerWithIdentifier("GameView") as! GameViewController;
        self.navigationController?.pushViewController(newGame, animated: true);
    }
    
    @IBAction func levelSelectBtn() {
        let levelSelect = storyboard!.instantiateViewControllerWithIdentifier("LevelSelect") as! LevelSelectVC;
        self.navigationController?.pushViewController(levelSelect, animated: true);
    }
}
