//
//  GuideViewController.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 12/10/2015.
//  Copyright © 2015 qi-cloud.com. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    let numberOfViews: Int = Int(3)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupGuide()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    convenience init() {
        let nibNameOrNil = String?("GuideViewController")
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    func setupGuide() {
        for i in 0..<self.numberOfViews {
            let tempView: UIView = UIView(frame: CGRect(x: CGFloat(i) * UIScreen.mainScreen().screenWidth(), y: 0, width: UIScreen.mainScreen().screenWidth(), height: UIScreen.mainScreen().screenHeight()))
            tempView.backgroundColor = UIColor.colorWithRed( CGFloat(i * 35), green: 100, blue: 100)
            if i == self.numberOfViews - 1 {
                let buttonWidth: CGFloat = 150
                let buttonHeight: CGFloat = 30
                let enterButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight))
                enterButton.layer.cornerRadius = 4
                enterButton.backgroundColor = UIColor.colorWithHex(hex: 0x66ccff)
                enterButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
                enterButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
                enterButton.setTitle("立即进入", forState: UIControlState.Normal)
                enterButton.addTarget(self, action: "didEnterButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
//                let rectOfButton = tempView.centerHorizontal(enterButton)
                enterButton.viewCenterHorizontal = tempView.viewCenterHorizontal
                tempView.addSubview(enterButton)
            }
            self.scrollView.addSubview(tempView)
        }
        self.scrollView.contentSize = CGSize(width: CGFloat(self.numberOfViews) * UIScreen.mainScreen().screenWidth(), height: UIScreen.mainScreen().screenHeight())
        self.scrollView.pagingEnabled = true
    }
    
    func didEnterButtonClicked(sender: UIButton) {
        if PROJECT_ENTRANCE_AVAILABLE {
            let signNavigationController: UINavigationController = UINavigationController(rootViewController: SignInViewController())
            UIApplication.sharedApplication().keyWindow?.rootViewController = signNavigationController
        } else {
            UIApplication.sharedApplication().keyWindow?.rootViewController = TabBarViewController()
        }
    }
}
