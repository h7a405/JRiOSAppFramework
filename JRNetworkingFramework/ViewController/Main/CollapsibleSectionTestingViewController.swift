//
//  CollapsibleSectionTestingViewController.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 15/10/2015.
//  Copyright © 2015 hSevenA405. All rights reserved.
//
/**
* @Description:
*
*/

//MARK: - Header
//MARK: Header - Including Files
import UIKit
//MARK: Header - Enums
//MARK: Header - Protocols

class CollapsibleSectionTestingViewController: UIViewController {
    //MARK: - Parameter
    //MARK: Parameters - Constant
    //MARK: Parameters - Basic
    var numberOfSections: Int = 0
    var numberOfRows: [Int] = Array()
    //MARK: Parameters - Foundation
    //MARK: Parameters - UIKit
    @IBOutlet weak var tableView: UITableView!
    //MARK: Parameters - Other
    var sectionHeaderViewArray: [JRCollapsibleTableViewHeader]?
    
    //MARK: - Method
    //MARK: Methods - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.numberOfSections = 5
        for i in 0..<self.numberOfSections {
            self.numberOfRows.append(2)
        }
        self.sectionHeaderViewArray = Array()
        
        self.tableView.tableFooterView = UIView()
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
        let nibNameOrNil = String?("CollapsibleSectionTestingViewController")
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
    //MARK: Methods - Other
}
//MARK: - Extension
//MARK: Extensions - Initation & Setup
//MARK: Extensions - Operation & Action
//MARK: Extensions - Getter / Setter
//MARK: Extensions - DataSource
extension CollapsibleSectionTestingViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.numberOfSections
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.sectionHeaderViewArray == nil {
            return 0
        } else {
            if section + 1 <= self.sectionHeaderViewArray!.count {
                if self.sectionHeaderViewArray![section].isCollapsing == false {
                    return self.numberOfRows[section]
                } else {
                    return 0
                }
            } else {
                return 0
            }
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
//MARK: Extensions - Delegate
extension  CollapsibleSectionTestingViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.sectionHeaderViewArray == nil {
            return nil
        } else {
            if section + 1 <= self.sectionHeaderViewArray!.count {
                return self.sectionHeaderViewArray![section]
            } else {
                let tempHeaderView: JRCollapsibleTableViewHeader = JRCollapsibleTableViewHeader(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: self.tableView(tableView, heightForHeaderInSection: section)), style: JRCollapsibleTableViewHeaderStyle.Value1)
                
                self.sectionHeaderViewArray!.append(tempHeaderView)
                return tempHeaderView
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
extension CollapsibleSectionTestingViewController: JRCollapsibleTableViewHeaderDelegate {
    func collapsibleSectionView(collapsibleSectionView: JRCollapsibleTableViewHeader, isToExpand: Bool) {
        //        if isToExpand {
        var theIndex: Int = 0
        for (index, header) in self.sectionHeaderViewArray!.enumerate() {
            if header === collapsibleSectionView {
                theIndex = index
                break
            }
        }
        self.tableView.reloadSections(NSIndexSet(index: theIndex), withRowAnimation: UITableViewRowAnimation.Automatic)
        //        }
    }
}
//MARK: - Class
//MARK: Classes - Other