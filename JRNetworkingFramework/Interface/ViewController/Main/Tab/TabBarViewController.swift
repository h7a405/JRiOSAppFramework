//
//  TabBarViewController.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 12/10/2015.
//  Copyright © 2015 qi-cloud.com. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViewControllers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupViewControllers() {
        let testNavigationController: UINavigationController = UINavigationController(rootViewController: TestingViewController())
        testNavigationController.tabBarItem.title = "控件Demo"
        let secondNavigationController: UINavigationController = UINavigationController(rootViewController: UIViewController())
        secondNavigationController.tabBarItem.title = "第二页"
        let settingNavigationController: UINavigationController = UINavigationController(rootViewController: SettingViewController())
        settingNavigationController.tabBarItem.title = "设置"
        self.setupTabBarController(testNavigationController, secondNavigationController, settingNavigationController)
    }
    
    func setupTabBarController(navigationControllers: UIViewController...) {
        var navigationControllerArray: [UIViewController] = Array()
        for (_, tempNavigationController) in (navigationControllers).enumerate() {
            navigationControllerArray.append(tempNavigationController)
        }
        self.viewControllers = navigationControllerArray
    }
}
