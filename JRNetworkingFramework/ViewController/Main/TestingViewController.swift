//
//  TestingViewController.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 13/10/2015.
//  Copyright © 2015 qi-cloud.com. All rights reserved.
//

import UIKit

class TestingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var testingArray: [String] = [
    "MutableLinkage"
    ]
    
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
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    convenience init() {
        let nibNameOrNil = String?("TestingViewController")
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    func gotoController(flag: Int) {
        var instance: UIViewController?
        switch flag {
        case 0:
            instance = JRDualLinkageViewController()
        default:
            break
        }
        if instance != nil {
            self.navigationController!.pushViewController(instance!, animated: true)
        }
    }

}
//MARK: - Classes - Extension
//MARK: - Extensions - DataSource
extension TestingViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.testingArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
//MARK: - Extensions - Delegate
extension  TestingViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.gotoController(indexPath.row)
    }
}
//MARK: - Classes - Custom