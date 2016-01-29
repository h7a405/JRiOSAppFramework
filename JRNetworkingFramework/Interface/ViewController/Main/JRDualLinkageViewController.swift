//
//  JRDualLinkageViewController.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 13/10/2015.
//  Copyright © 2015 qi-cloud.com. All rights reserved.
//

import UIKit

class JRDualLinkageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNavigationBarUncovered()
        
        let linkageView: JRDualLinkageView = JRDualLinkageView(frame: self.view.frame, style: JRDualLinkageViewSelectingStyle.Single)
        linkageView.delegate = self
        linkageView.dataSource = self
        self.view.addSubview(linkageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension JRDualLinkageViewController: JRDualLinkageViewDataSource {
    func numberOfRowsInFirstLevel(linkageView: JRDualLinkageView) -> Int {
        return 3
    }
    
    func numberOfSectionsInSecondLevel(linkageView: JRDualLinkageView, index: Int) -> Int {
        return index + 1
    }
    func linkageView(linkageView: JRDualLinkageView, index: Int, numberOfRowsInSectionInSecondLevel section: Int) -> Int {
        return index + 2
    }
}

extension JRDualLinkageViewController: JRDualLinkageViewDelegate {
    func linkageView(linkageView: JRDualLinkageView, heightForRowsAtIndexInFirstLevel index: Int) -> Float {
        return 44
    }
    func linkageView(linkageView: JRDualLinkageView, heightForRowsAtIndexPathInSecondLevel indexPath: NSIndexPath) -> Float {
        return 44
    }
    func linkageView(linkageView: JRDualLinkageView, tableView: UITableView, cellForRowAtIndexInFirstLevel index: Int) -> UITableViewCell {
        let cellIdentifier: String = String("cell")
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        cell!.textLabel!.text = "First"
        return cell!
    }
    func linkageView(linkageView: JRDualLinkageView, tableView: UITableView, index: Int, cellForRowAtIndexPathInSecondLevel indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier: String = String("cell")
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        cell!.textLabel!.text = "\(index)-Second"
        return cell!
    }
    
}