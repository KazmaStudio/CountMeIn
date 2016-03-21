//
//  NavigationControllerFind.swift
//  CountMeIn
//
//  Created by 袁思曾 on 16/3/21.
//  Copyright © 2016年 ftzex. All rights reserved.
//

import UIKit

class NavigationControllerFind: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var storyboard: UIStoryboard
        storyboard = UIStoryboard.init(name: "SBFind", bundle: nil)
        
        var viewController: TableViewControllerFind
        viewController = storyboard.instantiateViewControllerWithIdentifier("SFind") as! TableViewControllerFind
        
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
