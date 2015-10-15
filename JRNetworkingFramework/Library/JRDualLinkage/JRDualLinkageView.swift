//
//  JRDualLinkageView.swift
//  JRNetworkingFramework
//
//  Created by J.Chengzi on 13/10/2015.
//  Copyright © 2015 hSevenA405. All rights reserved.
//

/**
* @Description:
*
*/

//MARK: - Header
//MARK: Header - Files
import UIKit
//MARK: Header - Enums
enum JRDualLinkageViewSelectingStyle {
    case Single
    case Multiple
}
//MARK: Header - Protocols
@objc protocol JRDualLinkageViewDataSource: NSObjectProtocol {
    func numberOfRowsInFirstLevel(linkageView: JRDualLinkageView) -> Int
    
    func numberOfSectionsInSecondLevel(linkageView: JRDualLinkageView) -> Int
    func linkageView(linkageView: JRDualLinkageView, numberOfRowsInSectionInSecondLevel section: Int) -> Int
    
    optional func linkageView(linkageView: JRDualLinkageView, titleForHeaderInSectionInSecondLevel section: Int) -> String?
}
@objc protocol JRDualLinkageViewDelegate: NSObjectProtocol {
    
    optional func widthOfFirstLevel(linkageView: JRDualLinkageView) -> Float
    optional func linkageView(linkageView: JRDualLinkageView, heightForRowsAtIndexInFirstLevel index: Int) -> Float
    optional func linkageView(linkageView: JRDualLinkageView, tableView: UITableView, cellForRowAtIndexInFirstLevel index: Int) -> UITableViewCell
    
    optional func linkageView(linkageView: JRDualLinkageView, didSelectRowAtIndexInFirstLevel index: Int)
    
    optional func linkageView(linkageView: JRDualLinkageView, heightForHeaderInSectionInSecondLevel section: Int) -> Float
    optional func linkageView(linkageView: JRDualLinkageView, heightForRowsAtIndexPathInSecondLevel indexPath: NSIndexPath) -> Float
    optional func linkageView(linkageView: JRDualLinkageView, tableView: UITableView, cellForRowAtIndexPathInSecondLevel indexPath: NSIndexPath) -> UITableViewCell
    
    optional func linkageView(linkageView: JRDualLinkageView, viewForHeaderInSectionInSecondLevel section: Int) -> UIView?
    
    optional func linkageView(linkageView: JRDualLinkageView, didSelectRowAtIndexPathInSecondLevel indexPath: NSIndexPath)
}

//MARK: - Class
//MARK: - Classes - Body
class JRDualLinkageView: UIView {

    //MARK: - Parameter
    //MARK: - Parameters - Constant
    let widthOfEachLevelOnLeft: Float = 80
    let heightOfRowsDefault: Float = 30
    //MARK: - Parameters - Basic
    var isTrebleLinkage: Bool = false
    //MARK: - Parameters - Foundation
    //MARK: - Parameters - UIKit
    let firstLevelTableView: UITableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
    let secondLevelTableView: UITableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
    //MARK: - Parameters - Array
    //MARK: - Parameters - Dictionary
    //MARK: - Parameters - Tuple
    //MARK: - Parameters - Customed
    weak var delegate: JRDualLinkageViewDelegate?
    weak var dataSource: JRDualLinkageViewDataSource? {
        didSet {
            self.reloadData()
        }
    }
    
    var style: JRDualLinkageViewSelectingStyle = JRDualLinkageViewSelectingStyle.Single
    
    //MARK: - Method
    //MARK: - Methods - Life Circle
    //MARK: - Methods - Implementation
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //MARK: - Methods - Initation
    convenience init(frame: CGRect, style: JRDualLinkageViewSelectingStyle) {
        self.init()
        self.frame = frame
        self.style = style
    }
    //MARK: - Methods - Class(Static)
    
    //MARK: - Methods - Selector
    //MARK: Selectors - Gesture Recognizer
    //MARK: Selectors - Action
    //MARK: - Methods - Operation
    //MARK: Operations - Go Operation
    //MARK: Operations - Do Operation
    //MARK: Operations - Show or Dismiss Operation
    //MARK: Operations - Setup Operation
    //MARK: Operations - Customed Operation
    func reloadData() {
        self.firstLevelTableView.removeFromSuperview()
        var widthOfFirstLevel: Float = self.widthOfEachLevelOnLeft
        if self.delegate != nil {
            if self.delegate!.respondsToSelector("widthOfFirstLevel:") {
                widthOfFirstLevel = self.delegate!.widthOfFirstLevel!(self)
            }
        }
        self.firstLevelTableView.frame = CGRect(x: 0, y: 0, width: CGFloat(widthOfFirstLevel), height: self.frame.size.height)
        self.firstLevelTableView.tableFooterView = UIView()
        self.firstLevelTableView.backgroundColor = UIColor.groupTableViewBackgroundColor()
        self.firstLevelTableView.delegate = self
        self.firstLevelTableView.dataSource = self
        
        self.secondLevelTableView.removeFromSuperview()
        let widthOfSecondLevel: Float = Float(self.frame.size.width) - widthOfFirstLevel
        self.secondLevelTableView.frame = CGRect(x: CGFloat(widthOfFirstLevel) + 5, y: 0, width: CGFloat(widthOfSecondLevel), height: self.frame.size.height)
        self.secondLevelTableView.tableFooterView = UIView()
        self.secondLevelTableView.delegate = self
        self.secondLevelTableView.dataSource = self
        
        self.firstLevelTableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.Top)
        
        self.addSubview(self.firstLevelTableView)
        self.addSubview(self.secondLevelTableView)
    }
    //MARK: - Methods - Getter
    //MARK: - Methods - Setter
}

//MARK: - Classes - Extension
//MARK: - Extensions - DataSource
extension JRDualLinkageView: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView === self.firstLevelTableView {
            return 1
        } else if tableView === self.secondLevelTableView {
            return self.dataSource!.numberOfSectionsInSecondLevel(self)
        } else {
            return 0
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === self.firstLevelTableView {
            return self.dataSource!.numberOfRowsInFirstLevel(self)
        } else if tableView === self.secondLevelTableView {
            return self.dataSource!.linkageView(self, numberOfRowsInSectionInSecondLevel: section)
        } else {
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier: String = String("cell")
        if self.delegate == nil {
            return UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        if tableView === self.firstLevelTableView {
            if self.delegate!.respondsToSelector("linkageView:tableView:cellForRowAtIndexInFirstLevel:") {
                let cellToReturn = self.delegate!.linkageView!(self, tableView: tableView, cellForRowAtIndexInFirstLevel: indexPath.row)
                cellToReturn.textLabel!.font = UIFont.systemFontOfSize(14)
                cellToReturn.backgroundColor = UIColor.clearColor()
                cellToReturn.selectedBackgroundView = UIView(frame: cellToReturn.frame)
                cellToReturn.selectedBackgroundView!.backgroundColor = UIColor.whiteColor()
                return cellToReturn
            } else {
                return UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
            }
        } else if tableView === self.secondLevelTableView {
            if self.delegate!.respondsToSelector("linkageView:tableView:cellForRowAtIndexPathInSecondLevel:") {
                let cellToReturn = self.delegate!.linkageView!(self, tableView: tableView, cellForRowAtIndexPathInSecondLevel: indexPath)
                cellToReturn.textLabel!.font = UIFont.systemFontOfSize(13)
                return cellToReturn
            } else {
                return UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
            }
        } else {
            return UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView === self.secondLevelTableView {
            if self.dataSource!.respondsToSelector("linkageView:titleForHeaderInSectionInSecondLevel:") {
                return self.dataSource!.linkageView!(self, titleForHeaderInSectionInSecondLevel: section)
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
//MARK: - Extensions - Delegate
extension  JRDualLinkageView: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.delegate == nil {
            return 0
        }
        if tableView === self.secondLevelTableView {
            if self.delegate!.respondsToSelector("linkageView:heightForHeaderInSectionInSecondLevel:") {
                return CGFloat(self.delegate!.linkageView!(self, heightForHeaderInSectionInSecondLevel: section))
            } else {
                return 0
            }
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if self.delegate == nil {
            return CGFloat(self.heightOfRowsDefault)
        }
        if tableView === self.firstLevelTableView {
            if self.delegate!.respondsToSelector("linkageView:heightForRowsAtIndexInFirstLevel:") {
                return CGFloat(self.delegate!.linkageView!(self, heightForRowsAtIndexInFirstLevel: indexPath.row))
            } else {
                return CGFloat(self.heightOfRowsDefault)
            }
        } else if tableView === self.secondLevelTableView {
            if self.delegate!.respondsToSelector("linkageView:heightForRowsAtIndexPathInSecondLevel:") {
                return CGFloat(self.delegate!.linkageView!(self, heightForRowsAtIndexPathInSecondLevel: indexPath))
            } else {
                return CGFloat(self.heightOfRowsDefault)
            }
        } else {
            return CGFloat(self.heightOfRowsDefault)
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if self.delegate == nil {
            return nil
        }
        if tableView === self.secondLevelTableView {
            if self.delegate!.respondsToSelector("linkageView:viewForHeaderInSectionInSecondLevel:") {
                return self.delegate!.linkageView!(self, viewForHeaderInSectionInSecondLevel: section)
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView === self.firstLevelTableView {
            tableView.cellForRowAtIndexPath(indexPath)!.tintColor = UIColor.whiteColor()
        } else if tableView === self.secondLevelTableView {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        } else {
            
        }
        
    }
}
//MARK: - Classes - Custom
