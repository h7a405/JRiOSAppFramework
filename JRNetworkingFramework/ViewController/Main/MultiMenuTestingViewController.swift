//
//  MultiMenuTestingViewController.swift
//  JRNetworkingFramework
//
//  Created by Jason.Chengzi on 15/12/14.
//  Copyright © 2015年 WeSwift. All rights reserved.
//

import UIKit

class MultiMenuTestingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Tool.setNavigationBarUncovered(self)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let multiMenuView: JZMultiMenuView = JZMultiMenuView(frame: self.view.bounds, type: JZMultiMenuViewType.Multiplbe)
        multiMenuView.style = JZMultiMenuViewStyle.AnyStyle
        multiMenuView.dataSource = self
        multiMenuView.delegate = self
        self.view.addSubview(multiMenuView)
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

extension MultiMenuTestingViewController: JZMultiMenuViewDataSouce {
    func menuView(menuView: UITableView, forLevel level: Int, numberOfRowsInSection section: Int) -> Int {
        if level == 0 {
            return 3
        } else {
            return 5
        }
    }
}
extension MultiMenuTestingViewController: JZMultiMenuViewDelegate {
    func menuView(menuView: UITableView, forLevel level: Int, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if level > 0 {
            menuView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
}