//
//  MultiMenuTestingViewController.swift
//  JRNetworkingFramework
//
//  Created by Jason.Chengzi on 15/12/14.
//  Copyright © 2015年 WeSwift. All rights reserved.
//

import UIKit

class MultiMenuTestingViewController: UIViewController {
    
    var firstMenuSelectedIndex: [NSIndexPath] = [NSIndexPath(forRow: 0, inSection: 0), NSIndexPath(forRow: 0, inSection: 0), NSIndexPath(forRow: 0, inSection: 0), NSIndexPath(forRow: 0, inSection: 0)]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        Tool.setNavigationBarUncovered(self)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let multiMenuView: JZMultiMenuView = JZMultiMenuView(frame: self.view.bounds, type: JZMultiMenuViewType.Multiple)
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
        } else if level == 1 {
            return 5
        } else if level == 2 {
            return 7
        } else if level == 3 {
            return 9
        } else {
            return 0
        }
    }
    func menuView(menuView: UITableView, forLevel level: Int, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier: String = "cell"
        var cell: UITableViewCell? = menuView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        if level == 0 {
            cell!.textLabel?.text = "first-\(indexPath.section)-\(indexPath.row)"
        } else if level == 1 {
            cell!.textLabel?.text = "second-\(indexPath.section)-\(indexPath.row)[\(self.firstMenuSelectedIndex[0].section)-\(self.firstMenuSelectedIndex[0].row)]"
        } else if level == 2 {
            cell!.textLabel?.text = "third-\(indexPath.section)-\(indexPath.row)[\(self.firstMenuSelectedIndex[0].section)-\(self.firstMenuSelectedIndex[0].row)][\(self.firstMenuSelectedIndex[1].section)-\(self.firstMenuSelectedIndex[1].row)]"
        } else if level == 3 {
            cell!.textLabel?.text = "fourth-\(indexPath.section)-\(indexPath.row)[\(self.firstMenuSelectedIndex[0].section)-\(self.firstMenuSelectedIndex[0].row)][\(self.firstMenuSelectedIndex[1].section)-\(self.firstMenuSelectedIndex[1].row)][\(self.firstMenuSelectedIndex[2].section)-\(self.firstMenuSelectedIndex[2].row)]"
        }
        return cell!
    }
}
extension MultiMenuTestingViewController: JZMultiMenuViewDelegate {
    func menuView(menuView: UITableView, forLevel level: Int, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if level > 0 {
            menuView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        self.firstMenuSelectedIndex[level] = indexPath
    }
}