//
//  JZMultiMenuView.swift
//  JRNetworkingFramework
//
//  Created by Jason.Chengzi on 15/12/14.
//  Copyright © 2015年 WeSwift. All rights reserved.
//

import UIKit

//MARK: Enumeration
enum JZMultiMenuViewType {
    case Empty  //Initialize a empty view
    case Double //Initialize a view with two table views
    case Multiplbe  //Initialize a view with more than two table views and up to the total number of four.
}

enum JZMultiMenuViewStyle {
    case CompactStyle   //The width of first view will be about 20% of the screen's width.
    case AnyStyle   //The width of first view will be about 30% of the screen's width.
    case RegularStyle   //The width of first view will be about 40% of the screen's width.
}

//MARK: Protocols - DataSource
@objc protocol JZMultiMenuViewDataSouce: NSObjectProtocol {
    optional func numberOfSection(menuView: UITableView, forLevel level: Int) -> Int
    
    func menuView(menuView: UITableView, forLevel level: Int, numberOfRowsInSection section: Int) -> Int
    
    optional func menuView(menuView: UITableView, forLevel level: Int, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    
    optional func menuView(menuView: UITableView, forLevel level: Int, titleForHeaderInSection section: Int) -> String?
}
//MARK: Protocols - Delegate
@objc protocol JZMultiMenuViewDelegate: NSObjectProtocol {
    optional func menuView(menuView: UITableView, forLevel level: Int, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    
    optional func menuView(menuView: UITableView, forLevel level: Int, heightForHeaderInSection section: Int) -> CGFloat
    
    optional func menuView(menuView: UITableView, forLevel level: Int, didSelectRowAtIndexPath indexPath: NSIndexPath)
}

class JZMultiMenuView: UIView {
    var queue: [UITableView]?
    
    var views: [UITableView]? {
        get {return self.queue}
    }
    
    var type: JZMultiMenuViewType = JZMultiMenuViewType.Empty
    var style: JZMultiMenuViewStyle = JZMultiMenuViewStyle.AnyStyle {
        willSet {
            if newValue != self.style {
                self.reloadMenu()
            }
        }
    }

    weak var delegate: JZMultiMenuViewDelegate?
    weak var dataSource: JZMultiMenuViewDataSouce? {
        didSet {
            if self.dataSource != nil {
                self.reloadMenu()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//MARK: Extensions - Initations / Setup
extension JZMultiMenuView {
    convenience init(frame: CGRect, type: JZMultiMenuViewType) {
        self.init(frame: frame)
        self.type = type
        self.reloadMenu()
    }
}

//MARK: Extensions - Operations / Actions
extension JZMultiMenuView {
    func reloadMenu() {
        if self.type == JZMultiMenuViewType.Empty {
            return
        }
        if self.dataSource == nil {
            return
        } else {
            if self.queue == nil {
                self.queue = Array()
                var numberOfViews: Int = 0
                if self.type == JZMultiMenuViewType.Double {
                    numberOfViews = 2
                } else if self.type == JZMultiMenuViewType.Multiplbe {
                    numberOfViews = 4
                }
                for _ in 0..<numberOfViews {
                    let tempTableView: UITableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
                    tempTableView.dataSource = self
                    tempTableView.delegate = self
//                    tempTableView.tag = 999990 + i
                    tempTableView.tableFooterView = UIView()
                    self.queue!.append(tempTableView)
                }
            }
            let firstTableView: UITableView = self.queue![0]
            var widthToSet: CGFloat = 0
            switch self.style {
            case .CompactStyle:
                widthToSet = CGFloat(self.frame.width * 0.2)
            case .AnyStyle:
                widthToSet = CGFloat(self.frame.width * 0.3)
            case .RegularStyle:
                widthToSet = CGFloat(self.frame.width * 0.4)
            }
            firstTableView.frame = CGRect(x: 0, y: 0, width: widthToSet, height: self.frame.height)
            firstTableView.backgroundColor = UIColor.groupTableViewBackgroundColor()
            self.addSubview(firstTableView)
            
            let secondTableView: UITableView = self.queue![1]
            secondTableView.frame = CGRect(x: widthToSet, y: 0, width: self.frame.width - widthToSet, height: self.frame.height)
            self.addSubview(secondTableView)
            
            if self.type == JZMultiMenuViewType.Multiplbe {
                let thirdHeaderView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: secondTableView.frame.width, height: 30))
                let thirdButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
                thirdButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                thirdButton.setTitle("<", forState: UIControlState.Normal)
                thirdButton.addTarget(self, action: "didGoBackButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
                thirdButton.tag = 999990
                thirdHeaderView.addSubview(thirdButton)
                self.queue![2].frame = CGRect(x: self.frame.width, y: 0, width: secondTableView.frame.width, height: secondTableView.frame.height)
                self.queue![2].tableHeaderView = thirdHeaderView
                self.addSubview(self.queue![2])
                
                let fourthHeaderView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: secondTableView.frame.width, height: 30))
                let fourthButton: UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
                fourthButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                fourthButton.setTitle("<", forState: UIControlState.Normal)
                fourthButton.addTarget(self, action: "didGoBackButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
                fourthButton.tag = 999991
                fourthHeaderView.addSubview(fourthButton)
                self.queue![3].frame = CGRect(x: self.frame.width, y: 0, width: secondTableView.frame.width, height: secondTableView.frame.height)
                self.queue![3].tableHeaderView = fourthHeaderView
                self.addSubview(self.queue![3])
            }
        }
    }
    
    func menuView(menuView: UITableView, deSelectAtRowOfIndexPath indexPath: NSIndexPath, animated: Bool) {
        menuView.deselectRowAtIndexPath(indexPath, animated: animated)
    }
}
//MARK: Extensions - Getter/Setter
extension JZMultiMenuView {
    private func getIndexOfTableView(tableView: UITableView) -> Int {
        if self.queue != nil {
            for (index, theTableView) in self.queue!.enumerate() {
                if theTableView === tableView {
                    return index
                }
            }
        }
        return -1
    }
    func didGoBackButtonClicked(sender: UIButton) {
        if sender.tag == 999990 {
            self.hideNextLevelMenu(2)
        } else if sender.tag == 999991 {
            self.hideNextLevelMenu(3)
        }
    }
    
    private func showNextLevelMenu(index: Int) {
        if self.queue != nil {
            UIView.animateWithDuration(0.2, animations: {()
                self.queue![index].transform = CGAffineTransformTranslate(self.queue![index].transform, -(self.queue![index].frame.width), 0)
            }, completion: nil)
        }
    }
    private func hideNextLevelMenu(index: Int) {
        if self.queue != nil {
            UIView.animateWithDuration(0.2, animations: {()
                self.queue![index].transform = CGAffineTransformTranslate(self.queue![index].transform, self.queue![index].frame.width, 0)
                }, completion: nil)
        }
    }
}

//MARK: Extensions - DataSource
extension JZMultiMenuView: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if self.dataSource != nil {
            if self.dataSource!.respondsToSelector("numberOfSection:forLevel:") {
                return self.dataSource!.numberOfSection!(tableView, forLevel: self.getIndexOfTableView(tableView))
            } else {
                return 1
            }
        } else {
            return 0
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dataSource != nil {
            return self.dataSource!.menuView(tableView, forLevel: self.getIndexOfTableView(tableView), numberOfRowsInSection: section)
        } else {
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier: String = String("cell")
        if self.dataSource != nil {
            if self.dataSource!.respondsToSelector("menuView:forLevel:cellForRowAtIndexPath:") {
                let cellToReturn = self.dataSource!.menuView!(tableView, forLevel: self.getIndexOfTableView(tableView), cellForRowAtIndexPath: indexPath)
                if self.getIndexOfTableView(tableView) == 0 {
                    cellToReturn.textLabel?.font = UIFont.systemFontOfSize(14)
                    cellToReturn.backgroundColor = UIColor.clearColor()
                    cellToReturn.selectedBackgroundView = UIView(frame: cellToReturn.frame)
                } else {
                    cellToReturn.textLabel?.font = UIFont.systemFontOfSize(13)
                }
                cellToReturn.selectedBackgroundView!.backgroundColor = UIColor.whiteColor()
                return cellToReturn
            } else {
                let cellToReturn = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
                if self.getIndexOfTableView(tableView) == 0 {
                    cellToReturn.textLabel?.font = UIFont.systemFontOfSize(14)
                    cellToReturn.backgroundColor = UIColor.clearColor()
                    cellToReturn.selectedBackgroundView = UIView(frame: cellToReturn.frame)
                } else {
                    cellToReturn.textLabel?.font = UIFont.systemFontOfSize(13)
                }
                cellToReturn.selectedBackgroundView!.backgroundColor = UIColor.whiteColor()
                return cellToReturn
            }
        } else {
            let cellToReturn = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
            if self.getIndexOfTableView(tableView) == 0 {
                cellToReturn.textLabel?.font = UIFont.systemFontOfSize(14)
                cellToReturn.backgroundColor = UIColor.clearColor()
                cellToReturn.selectedBackgroundView = UIView(frame: cellToReturn.frame)
            } else {
                cellToReturn.textLabel?.font = UIFont.systemFontOfSize(13)
            }
            cellToReturn.selectedBackgroundView!.backgroundColor = UIColor.whiteColor()
            return cellToReturn
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.dataSource != nil {
            if self.dataSource!.respondsToSelector("menuView:forLevel:titleForHeaderInSection:") {
                return self.dataSource!.menuView!(tableView, forLevel: self.getIndexOfTableView(tableView), titleForHeaderInSection: section)
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
    
//MARK: Extensions - Delegate
extension  JZMultiMenuView: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.delegate != nil {
            if self.delegate!.respondsToSelector("menuView:forLevel:heightForHeaderInSection:") {
                return self.delegate!.menuView!(tableView, forLevel: self.getIndexOfTableView(tableView), heightForHeaderInSection: section)
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if self.delegate != nil {
            if self.delegate!.respondsToSelector("menuView:forLevel:heightForRowAtIndexPath:") {
                return self.delegate!.menuView!(tableView, forLevel: self.getIndexOfTableView(tableView), heightForRowAtIndexPath: indexPath)
            } else {
                return 40
            }
        } else {
            return 40
        }
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if self.getIndexOfTableView(tableView) == 0 {
            tableView.cellForRowAtIndexPath(indexPath)!.tintColor = UIColor.whiteColor()
        } else if self.getIndexOfTableView(tableView) == 1 && self.type == JZMultiMenuViewType.Multiplbe {
            self.showNextLevelMenu(2)
        } else if self.getIndexOfTableView(tableView) == 2 && self.type == JZMultiMenuViewType.Multiplbe {
            self.showNextLevelMenu(3)
        } else {
            
        }
        if self.delegate != nil {
            if self.delegate!.respondsToSelector("menuView:forLevel:didSelectRowAtIndexPath:") {
                self.delegate!.menuView!(tableView, forLevel: self.getIndexOfTableView(tableView), didSelectRowAtIndexPath: indexPath)
            }
        }
    }
}

//MARK: Extensions - Other
