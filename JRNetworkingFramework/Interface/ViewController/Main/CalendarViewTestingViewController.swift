//
//  CalendarViewTestingViewController.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 20/10/15.
//  Copyright © 2015年 hSevenA405. All rights reserved.
//

import UIKit

class CalendarViewTestingViewController: UIViewController {
    //MARK: - Parameter
    //MARK: Parameters - Constant
    //MARK: Parameters - Basic
    //MARK: Parameters - Foundation
    //MARK: Parameters - UIKit
    var indicatorView: UIView?
    //MARK: Parameters - Other
    var calendarView: JRCalendarView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBarUncovered()
//        self.headerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 35))
//        self.headerView!.backgroundColor = UIColor.blackColor()
//        self.headerView!.alpha = 0.75
//        
//        self.indicatorView = UIView(frame: CGRect(x: 0, y: CGRectGetMaxY(self.headerView!.frame), width: CGRectGetWidth(self.headerView!.frame), height: 30))
//        let averageWidth = self.headerView!.frame.width / 7
//        let dateString = ["日", "一", "二", "三", "四", "五", "六"]
//        for i in 0..<7 {
//            let dateLabel = UILabel(frame: CGRect(x: CGFloat(i) * averageWidth, y: 0, width: averageWidth, height: CGRectGetHeight(self.indicatorView!.frame)))
//            dateLabel.textAlignment = NSTextAlignment.Center
//            dateLabel.text = dateString[i]
//            self.indicatorView!.addSubview(dateLabel)
//        }
        self.calendarView = JRCalendarView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 325), style: JRCalendarStyle.Default)
        
        self.view.addSubview(self.calendarView!)
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    //MARK: Methods - Required
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //MARK: Methods - Convenience
    convenience init() {
        let nibNameOrNil = String?("CalendarViewTestingViewController")
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
    //MARK: Methods - Other

}
//MARK: - Extension
//MARK: Extensions - Initation & Setup
//MARK: Extensions - Operation & Action
//MARK: Extensions - Getter / Setter
//MARK: Extensions - DataSource
//MARK: Extensions - Delegate
//MARK: - Class
//MARK: Classes - Other