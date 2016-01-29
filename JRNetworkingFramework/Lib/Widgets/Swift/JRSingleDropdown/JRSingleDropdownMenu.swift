//
//  JRSingleDropdownMenu.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 19/10/15.
//  Copyright © 2015年 hSevenA405. All rights reserved.
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
@objc protocol JRSingleDropdownMenuDelegate: NSObjectProtocol {
    optional func singleDropdownMenu(dropdownMenu: JRSingleDropdownMenu, selectedIndex index: Int)
}

class JRSingleDropdownMenu: UIView {
    //MARK: - Parameter
    //MARK: Parameters - Constant
    let screenBounds: CGRect = UIScreen.mainScreen().bounds
    let screenWidth: CGFloat = UIScreen.mainScreen().bounds.width
    let screenHeight: CGFloat = UIScreen.mainScreen().bounds.height
    
    let heightOfTableView_default: Float = 150
    let widthOfTableView_default: Float = 120
    let pointToShowOfTableView_default: (x: Float, y: Float) = (0, 0)
    //MARK: Parameters - Basic
    var menuTitleArray: [String] = Array()
    
    var menuCount: Int = Int(0)
    var selectedMenuIndex: Int = Int(0)
    
    var heightOfTableView: Float = Float(0)
    var widthOfTableView: Float = Float(0)
    var viewXOfTableView: Float = Float(0)
    var viewYOfTableView: Float = Float(0)
    //MARK: Parameters - Foundation
    //MARK: Parameters - UIKit
    var coverView: UIView?
    var contentView: UIView?
    var tableView: UITableView?
    //MARK: Parameters - Other
    var delegate: JRSingleDropdownMenuDelegate?
    
    //MARK: - Method
    //MARK: Methods - Override
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    //MARK: Methods - Required
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //MARK: Methods - Convenience
    convenience init(fixedWidth: Float?, fixedHeight: Float?, pointToShow point: (x: Float, y: Float)?, titles: [String]?) {
        self.init()
        
        self.backgroundColor = UIColor.clearColor()
        self.userInteractionEnabled = true
        
        if self.coverView == nil {
            self.coverView = UIView(frame: CGRect(
                x: 0,
                y: 0,
                width: self.screenWidth,
                height: self.screenHeight))
            self.coverView!.backgroundColor = UIColor.blackColor()
            self.coverView!.alpha = 0.2
        }
        let coverViewTapGesgute: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didCoverViewTouched:")
        self.coverView!.addGestureRecognizer(coverViewTapGesgute)
        self.coverView!.userInteractionEnabled = true
        
        if point != nil {
            self.viewXOfTableView = point!.x
            self.viewYOfTableView = point!.y
        } else {
            self.viewXOfTableView = pointToShowOfTableView_default.x
            self.viewYOfTableView = pointToShowOfTableView_default.y
        }
        if fixedWidth != nil {
            self.widthOfTableView = fixedWidth!
        } else {
            self.widthOfTableView = widthOfTableView_default
        }
        if fixedHeight != nil {
            self.heightOfTableView = fixedHeight!
        } else {
            self.heightOfTableView = heightOfTableView_default
        }
        
        if self.contentView == nil {
            self.contentView = UIView(frame: CGRect(
                x: CGFloat(self.viewXOfTableView),
                y: CGFloat(self.viewYOfTableView),
                width: CGFloat(self.widthOfTableView),
                height: CGFloat(self.heightOfTableView)))
            self.contentView!.backgroundColor = UIColor.whiteColor()
        }
        
        if titles != nil {
            self.setupDropdownMenu(menuTitles: titles!)
        } else {
            self.menuCount = 0
        }
        
        if self.tableView != nil {
            self.contentView!.addSubview(self.tableView!)
        }
        
        self.addSubview(self.coverView!)
        self.addSubview(self.contentView!)
    }
    convenience init(pointToShow point: (x: Float, y: Float)?, titles: [String]?) {
        self.init(fixedWidth: nil, fixedHeight: nil, pointToShow: point, titles: titles)
    }
    convenience init(titles: [String]?) {
        self.init(fixedWidth: nil, fixedHeight: nil, pointToShow: nil, titles: titles)
    }
    //MARK: Methods - Other
}
//MARK: - Extension
//MARK: Extensions - Initation & Setup
extension JRSingleDropdownMenu {
    func setupDropdownMenu(menuTitles titles: String...) {
        var tempArray: [String] = Array()
        for title in titles {
            tempArray.append(title)
        }
        self.setupDropdownMenu(menuTitles: tempArray)
    }
    func setupDropdownMenu(menuTitles titles: [String]) {
        self.menuTitleArray = titles
        self.menuCount = self.menuTitleArray.count
        
        if self.tableView == nil {
            self.tableView = UITableView(frame: self.contentView!.bounds, style: UITableViewStyle.Plain)
            self.tableView!.tableFooterView = UIView()
            self.tableView!.backgroundColor = UIColor.whiteColor()
            self.tableView!.delegate = self
            self.tableView!.dataSource = self
        }
    }
}
//MARK: Extensions - Operation & Action
extension JRSingleDropdownMenu {
    func didCoverViewTouched(sender: UITapGestureRecognizer) {
        self.dismiss()
    }
    func showOnView(superView: UIView) {
//        self.alpha = 0
        superView.insertSubview(self, atIndex: 0)
        UIView.animateWithDuration(0.2, animations: {()
            self.alpha = 1
            }, completion: nil)
    }
    func show() {
//        self.alpha = 0
        (UIApplication.sharedApplication().delegate! as! AppDelegate).window!.addSubview(self)
        UIView.animateWithDuration(0.2, animations: {()
                self.alpha = 1
        }, completion: nil)
    }
    func dismiss() {
        UIView.animateWithDuration(0.2, animations: {()
                self.alpha = 0
        }, completion: {(finished: Bool) in
            self.removeFromSuperview()
        })
    }
}
//MARK: Extensions - Getter / Setter

//MARK: Extensions - DataSource
extension JRSingleDropdownMenu: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuCount
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier: String = String("cell")
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        if self.menuCount > 0 {
            cell!.textLabel!.text = self.menuTitleArray[indexPath.row]
        } else {
            cell!.textLabel!.text = ""
        }
        return cell!
    }
}
//MARK: Extensions - Delegate
extension  JRSingleDropdownMenu: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if self.delegate != nil {
            if self.delegate!.respondsToSelector("singleDropdownMenu:selectedIndex:") {
                self.delegate!.singleDropdownMenu!(self, selectedIndex: indexPath.row)
            }
        }
        self.dismiss()
    }
}
//MARK: - Class
//MARK: Classes - Other