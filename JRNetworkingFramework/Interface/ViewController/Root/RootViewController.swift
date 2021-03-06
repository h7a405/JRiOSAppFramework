//
//  ViewController.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 4/10/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

//MARK: - Header
//MARK: Header - Files
import UIKit
//MARK: Header - Enums
//MARK: Header - Protocols

//MARK: - Class
//MARK: - Classes - Body
class RootViewController: UIViewController {
    //MARK: - Parameter
    //MARK: - Parameters - Constant
    //MARK: - Parameters - Basic
    //MARK: - Parameters - Foundation
    //MARK: - Parameters - UIKit
    //MARK: - Parameters - Array
    //MARK: - Parameters - Dictionary
    //MARK: - Parameters - Tuple
    //MARK: - Parameters - Customed
    
    //MARK: - Method
    //MARK: - Methods - Life Circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(title: "Http", style: UIBarButtonItemStyle.Done, target: self, action: "gotoHttp")
//        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.switchController()
    }
    //MARK: - Methods - Implementation
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - Methods - Initation
    //MARK: - Methods - Class(Static)
    
    //MARK: - Methods - Selector
    //MARK: Selectors - Gesture Recognizer
    //MARK: Selectors - Action
    //MARK: - Methods - Operation
    //MARK: Operations - Go Operation
    func gotoHttp() {
        let instance = HttpViewController()
        self.navigationController!.pushViewController(instance, animated: true)
    }
    //MARK: Operations - Do Operation
    func switchController() {
        if self.isFirstTimeLaunched() {
            ProjectUtil.setToFirstTimeLaunched(false)
            if PROJECT_GUIDE_AVAILABLE {
                self.setGuideViewControllerVisible()
                return
            }
        }
        if PROJECT_ENTRANCE_AVAILABLE {
            if !self.isAlreadySignedIn() {
                self.setSignInViewControllerVisible()
                return
            }
        }
        self.setMainViewControllerVisible()
    }
    //MARK: Operations - Show or Dismiss Operation
    //MARK: Operations - Setup Operation
    //MARK: Operations - Customed Operation
    func isFirstTimeLaunched() -> Bool {
        let userDefault = NSUserDefaults.standardUserDefaults()
        if userDefault.objectForKey(IDENTIFY_COMMON_IS_FIRST_LAUNCH) != nil {
            return false
        } else {
            return true
        }
    }
    
    func isAlreadySignedIn() -> Bool {
        let userDefault = NSUserDefaults.standardUserDefaults()
        if userDefault.objectForKey(IDENTIFY_ENTRANCE_IS_SIGNEDIN) == nil {
            return false
        } else {
            return true
        }
    }
    //MARK: - Methods - Getter
    //MARK: - Methods - Setter
    func setMainViewControllerVisible() {
        UIApplication.sharedApplication().keyWindow?.rootViewController = TabBarViewController()
    }
    func setGuideViewControllerVisible() {
        UIApplication.sharedApplication().keyWindow?.rootViewController = GuideViewController()
    }
    func setSignInViewControllerVisible() {
        let entranceNavigationController: UINavigationController = UINavigationController(rootViewController: SignInViewController())
        UIApplication.sharedApplication().keyWindow?.rootViewController = entranceNavigationController
    }
}
//MARK: - Classes - Extension
//MARK: - Extensions - DataSource
//MARK: - Extensions - Delegate
//MARK: - Classes - Custom

