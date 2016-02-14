//
//  LossMenuVC.swift
//  RoidRage
//
//  Created by igmstudent on 12/6/15.
//  Copyright © 2015 Alpaca. All rights reserved.
//

import UIKit

class LossMenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnMainMenu(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true);
    }
    
    @IBAction func btnTryAgain(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true);
    }
}
