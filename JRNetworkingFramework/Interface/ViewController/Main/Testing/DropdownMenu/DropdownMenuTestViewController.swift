//
//  DropdownMenuTestViewController.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 19/10/15.
//  Copyright © 2015年 hSevenA405. All rights reserved.
//

import UIKit

class DropdownMenuTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
        let nibNameOrNil = String?("DropdownMenuTestViewController")
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
    //MARK: Methods - Other
}
//MARK: - Extension
//MARK: Extensions - Initation & Setup
//MARK: Extensions - Operation & Action
extension DropdownMenuTestViewController {
    @IBAction func didButtonClicked(sender: UIButton) {
//        let dropdownMenu: JRSingleDropdownMenu = JRSingleDropdownMenu(titles: ["No.1", "No.2"])
        let dropdownMenu: JRSingleDropdownMenu = JRSingleDropdownMenu(fixedWidth: Float(CGRectGetWidth(sender.frame)), fixedHeight: nil, pointToShow: (Float(CGRectGetMinX(sender.frame)), Float(CGRectGetMaxY(sender.frame))), titles: ["NO.1", "NO.2"])
//        dropdownMenu.show()
        dropdownMenu.showOnView(self.view)
    }
}
//MARK: Extensions - Getter / Setter
//MARK: Extensions - DataSource
//MARK: Extensions - Delegate
//MARK: - Class
//MARK: Classes - Other