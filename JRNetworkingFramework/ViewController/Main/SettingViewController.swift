//
//  SettingViewController.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 13/10/2015.
//  Copyright © 2015 qi-cloud.com. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let tableHeaderView: UIView = UIView()
    let profileAvatar: UIImageView = UIImageView(image: UIImage(named: "FYBroker"))
    
    let titleOfSections: [String] = ["Member", "Setting"]
    let dataOfRows: [[String]] = [
        ["Member1", "Member2", "Member3", "Member4"],
        ["Setting1", "Setting2"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableHeaderView.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 100)
        
        self.profileAvatar.frame = self.tableHeaderView.centerHorizontal(yCoordinate: 10, widthOfSubView: 60, heightOfSubView: 60)
        self.profileAvatar.layer.masksToBounds = true
        self.profileAvatar.layer.cornerRadius = self.profileAvatar.widthOfFrame / 2
        self.profileAvatar.layer.borderWidth = 1
        self.profileAvatar.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.tableHeaderView.addSubview(self.profileAvatar)
        
        self.tableView.tableHeaderView = self.tableHeaderView
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
        let nibNameOrNil = String?("SettingViewController")
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
}
//MARK: - Classes - Extension
//MARK: - Extensions - DataSource
extension SettingViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.titleOfSections.count
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return self.dataOfRows[section].count
        default:
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier: String = "Cell"
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        switch indexPath.section {
        case 0:
            let averageWidth: CGFloat = self.tableView.widthOfFrame / CGFloat(self.dataOfRows[indexPath.section].count)
            for i in 0..<self.dataOfRows[indexPath.section].count {
                let tempImageView: UIImageView = UIImageView(image: UIImage(named: "FYMember"))
                tempImageView.frame = CGRect(x: (CGFloat(i) * averageWidth) + 5, y: 5, width: averageWidth - 5, height: self.tableView(tableView, heightForRowAtIndexPath: indexPath))
                
                let tempLabel: UILabel = UILabel(frame: CGRect(x: CGFloat(i) * averageWidth, y: self.tableView(tableView, heightForRowAtIndexPath: indexPath) - 20, width: averageWidth, height: 20))
                tempLabel.textAlignment = NSTextAlignment.Center
                tempLabel.textColor = UIColor.lightGrayColor()
                tempLabel.text = self.dataOfRows[indexPath.section][i]
                
                cell!.addSubview(tempImageView)
                cell!.addSubview(tempLabel)
            }
        case 1:
            cell!.textLabel!.text = self.dataOfRows[indexPath.section][indexPath.row]
        default:
            cell!.textLabel!.text = ""
            for view in cell!.subviews {
                if view.isKindOfClass(UIImageView.self) {
                    view.removeFromSuperview()
                } else if view.isKindOfClass(UILabel.self) && view != cell!.textLabel! {
                    view.removeFromSuperview()
                }
            }
            break
        }
        return cell!
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.titleOfSections[section]
    }
}
//MARK: - Extensions - Delegate
extension  SettingViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 60
        case 1:
            return 44
        default:
            return 0
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
//MARK: - Classes - Custom