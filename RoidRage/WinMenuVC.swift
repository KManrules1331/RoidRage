//
//  WinMenuVC.swift
//  RoidRage
//
//  Created by igmstudent on 12/6/15.
//  Copyright © 2015 Alpaca. All rights reserved.
//

import UIKit

class WinMenuVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnMenuPressed(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true);
    }

    @IBAction func btnNextLevelPressed(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true);
    }
    
}
