//
//  TestingViewController.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 13/10/2015.
//  Copyright © 2015 hSevenA405. All rights reserved.
//

/**
* @Description:
*
*/

//MARK: - Header
//MARK: Header - Including File
import UIKit
//MARK: Header - Enum
//MARK: Header - Protocol
class TestingViewController: UIViewController {
    //MARK: - Parameter
    //MARK: Parameters - Constant
    let titleForSections: [String] = [
        "折叠/多选的表格视图",
        "视图的轮播",
        "多级联动"
    ]
    let titleForRows: [[String]] = [
        ["折叠表格视图"],
        ["图片视图轮播"],
        ["多级视图联动（仿美团外卖）"]
    ]
    let viewControllersForRows: [[UIViewController]] = [
        [CollapsibleSectionTestingViewController()],
        [CarouselTestingViewController()],
        [JRDualLinkageViewController()]
    ]
    //MARK: Parameters - Basic
    //MARK: Parameters - Foundation
    //MARK: Parameters - UIKit
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Parameters - Other
    
    //MARK: - Method
    //MARK: Methods - Override
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
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    //MARK: Methods - Convenience
    convenience init() {
        let nibNameOrNil = String?("TestingViewController")
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
    //MARK: Methods - Other
}
//MARK: - Extension
//MARK: Extensions - Initation & Setup
//MARK: Extensions - Operation & Action
extension TestingViewController {
    func jumpViewControllerHandler(indexPath: NSIndexPath) {
//        self.viewControllersForRows[indexPath.section][indexPath.row].hidesBottomBarWhenPushed = true
//        self.viewControllersForRows[indexPath.section][indexPath.row].navigationItem.title = self.titleForRows[indexPath.section][indexPath.row]
//        self.navigationController!.pushViewController(self.viewControllersForRows[indexPath.section][indexPath.row], animated: true)
        var instance = UIViewController()
        switch indexPath.section {
        case 0:
            instance = CollapsibleSectionTestingViewController()
        case 1:
            instance = CarouselTestingViewController()
        case 2:
            instance = JRDualLinkageViewController()
        default:
            break
        }
        instance.hidesBottomBarWhenPushed = true
        instance.navigationItem.title = self.titleForRows[indexPath.section][indexPath.row]
        self.navigationController!.pushViewController(instance, animated: true)
    }
}
//MARK: Extensions - Getter / Setter
//MARK: - Extensions - DataSource
extension TestingViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.titleForSections.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleForRows[section].count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        cell!.textLabel!.text = self.titleForRows[indexPath.section][indexPath.row]
        return cell!
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.titleForSections[section]
    }
}
//MARK: - Extensions - Delegate
extension  TestingViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.jumpViewControllerHandler(indexPath)
    }
}
//MARK: - Class
//MARK: Classes - Other