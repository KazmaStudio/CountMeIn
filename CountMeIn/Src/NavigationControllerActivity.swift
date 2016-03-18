//
//  NavigationControllerActivity.swift
//  CountMeIn
//
//  Created by zhaochenjun on 16/3/17.
//  Copyright © 2016年 ftzex. All rights reserved.
//

import UIKit

class NavigationControllerActivity: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var storyboard: UIStoryboard
        storyboard = UIStoryboard.init(name: "SBTableActivity", bundle: nil)
        
        var viewController: TableViewControllerActivity
        viewController = storyboard.instantiateViewControllerWithIdentifier("TableActivity") as! TableViewControllerActivity
        
        self.setViewControllers([viewController], animated: false)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
