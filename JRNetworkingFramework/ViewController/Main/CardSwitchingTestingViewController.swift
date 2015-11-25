//
//  CardSwitchingTestingViewController.swift
//  JRNetworkingFramework
//
//  Created by Chanel.Cheng on 15/11/24.
//  Copyright © 2015年 hSevenA405. All rights reserved.
//

import UIKit

class CardSwitchingTestingViewController: UIViewController {

    var cardSwitchingView: JRCoverFlowView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let numberOfViews: Int = 20
        var contentView: [UIView] = Array()
        
        for i in 0..<numberOfViews {
            let tempView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            tempView.backgroundColor = UIColor.RGB(red: CGFloat(i) * 30, green: CGFloat(i) * 10, blue: CGFloat(i) * 60)
            contentView.append(tempView)
        }
        
        self.cardSwitchingView = JRCoverFlowView(frame: self.view.frame, views: contentView, numberOfSide: numberOfViews / 2, scaleOfSide: 0.8, scaleOfCenter: 1.2)
        
        self.view.addSubview(self.cardSwitchingView!)
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
