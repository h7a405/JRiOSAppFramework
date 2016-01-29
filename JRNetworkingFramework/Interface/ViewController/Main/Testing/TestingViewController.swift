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
        "多级联动",
        "下拉菜单",
        "伪浏览器",
        "简单日历",
        "图片浏览",
        "表格视图",
        "阅读视图",
        "投票、评价",
        "卡片切换",
        "菜单联动（New）",
        "静态进度条",
        "扫描"
    ]
    let titleForRows: [[String]] = [
        ["折叠表格视图（有多选）"],
        ["图片视图轮播（未完成）"],
        ["多级视图联动（仿美团外卖、未完成）"],
        ["单个列表下拉菜单（未完成）"],
        ["伪浏览器"],
        ["简单日历"],
        ["浏览图片"],
        ["表格视图"],
        ["阅读视图"],
        ["投票评价视图"],
        ["卡片切换"],
        ["新的联动"],
        ["静态进度条"],
        ["扫描二维码"]
    ]
//    let viewControllersForRows: [[UIViewController]] = [
//        [CollapsibleSectionTestingViewController()],
//        [CarouselTestingViewController()],
//        [JRDualLinkageViewController()],
//        [DropdownMenuTestViewController()]
//    ]
    //MARK: Parameters - Basic
    //MARK: Parameters - Foundation
    //MARK: Parameters - UIKit
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Parameters - Other
    
    //MARK: - Method
    //MARK: Methods - Override
    override func viewDidLoad() {
        super.viewDidLoad()
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
        case 3:
            instance = DropdownMenuTestViewController()
        case 4:
            instance = WebViewTestViewController()
        case 5:
            instance = CalendarViewTestingViewController()
        case 6:
            instance = PhotoBrowserTestingViewController()
        case 7:
            instance = GridViewTestingViewController()
        case 8:
            instance = ReadingViewTestingViewController()
        case 9:
            instance = RatingViewController()
        case 10:
            instance = CardSwitchingTestingViewController()
        case 11:
            instance = MultiMenuTestingViewController()
        case 12:
            instance = ProgressBarTestingViewController()
        case 13:
            instance = QRCodeViewController()
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