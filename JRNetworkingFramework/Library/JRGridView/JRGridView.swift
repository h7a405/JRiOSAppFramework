//
//  JRGridView.swift
//  JingJianLogistics-iOS
//
//  Created by SilversRayleigh on 10/9/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

//MARK: - Header
//MARK: Header - Files
import UIKit

//MARK: Header - Enums
enum JRGridViewStyle {
    case Plaind
    case Grouped
}

enum JRGridViewSubjectStyle {
    case Default
    case Inverse
}

enum JRGridViewBorderStyle {
    case SurroundedOnly
    case InsideOnly
    case Full
    case OrientedOnly
    case VerticalOnly
}

enum JRGridViewTileStyle {
    case Default
}

//MARK: Header - Protocols

@objc protocol JRGridViewDataSource: NSObjectProtocol {
    
    func gridView(gridView: JRGridView, numberOfRowsInSection section: Int) -> Int
    func gridView(gridView: JRGridView, numberOfColumnsInSection section: Int) -> Int
//    func gridView(gridView: JRGridView, numberOfTilesInSection section: Int) -> Int
    func gridView(girdView: JRGridView, tileForItemAtIndexPath indexPath: GridIndexPath) -> JRGridViewTile
    
    optional func numberOfSectionsInGridView(gridView: JRGridView) -> Int
    
    optional func gridView(gridView: JRGridView, heightForRowAtIndexPath indexPath: GridIndexPath) -> Float
    optional func gridView(gridView: JRGridView, widthForColumnAtIndexPath indexPath: GridIndexPath) -> Float
    
    optional func gridView(gridView: JRGridView, heightForHeaderInSection section: Int) -> Float
    optional func gridView(gridView: JRGridView, titleForHeaderInSection section: Int) -> String
    optional func gridView(gridView: JRGridView, viewForHeaderInSection section: Int) -> UIView
//    optional func gridView(girdView: JRGridView, stringsForHeaderInSection section: Int) -> [String]
//    optional func gridView(gridView: JRGridView, viewsForHeaderInSection section: Int) -> [UIView]
    
    optional func gridView(gridView: JRGridView, heightForFooterInSection section: Int) -> Float
    optional func gridView(gridView: JRGridView, titleForFooterInSection section: Int) -> String
    optional func gridView(gridView: JRGridView, viewForFooterInSection section: Int) -> UIView
//    optional func gridView(girdView: JRGridView, stringsForFooterInSection section: Int) -> [String]
//    optional func gridView(gridView: JRGridView, viewsForFooterInSection section: Int) -> [UIView]
}

@objc protocol JRGridViewDelegate: NSObjectProtocol {
    optional func gridView(gridView: JRGridView, didSelectItemAtIndexPath indexPath: GridIndexPath)
    optional func gridView(gridView: JRGridView, deSelectItemAtIndexPath indexPath: GridIndexPath)
}

//MARK: - Class
//MARK: Classes - Body
class JRGridView: UIView {
    //MARK: - Parameter
    //MARK: - Parameters - Constant
    //MARK: - Parameters - Basic
    var numberOfSection: Int = Int(0)
    //MARK: - Parameters - Foundation
    //MARK: - Parameters - UIKit
    var scrollView: UIScrollView = UIScrollView()
    //MARK: - Parameters - Array
    //MARK: Arrays - Basic
    var numberOfRows: [Int] = Array()
    var numberOfColumns: [Int] = Array()
    
    var titleForHeaders: [String] = Array()
    var titleForFooters: [String] = Array()
    
    var heightForTables: [Float] = Array()
    
    var heightForRows: [[Float]] = Array()
    var widthForColumns: [[Float]] = Array()
    
    var heightForHeaders: [Float] = Array()
    var heightForFooters: [Float] = Array()
    
    var arrayOfTiles: [[AnyObject]]?
    //MARK: Arrays - Foundation
    //MARK: Arrays - UIKit
    var viewForHeaders: [UIView] = Array()
    var viewForFooters: [UIView] = Array()

    var arrayOfHeaders: [UIView]?
    var arrayOfFooters: [UIView]?
    //MARK: - Parameters - Dictionary
    //MARK: Dictionarys - Basic
    //MARK: Dictionarys - Foundation
    //MARK: Dictionarys - UIKit
    
    //MARK: - Parameters - Tuple
    
    //MARK: - Parameters - Customed
    //MARK: Customed - Normal
    var selectedGridViewTile: JRGridViewTile?
    var selectedIndexPath: GridIndexPath = GridIndexPath()
    //MARK: Customed - Delegate
    weak var delegate: JRGridViewDelegate?
    //MARK: Customed - Datasource
    weak var dataSource: JRGridViewDataSource? {
        didSet {
            self.reloadData()
        }
    }
    //MARK: Customed - Enum
    var style: JRGridViewStyle = JRGridViewStyle.Plaind
    var subjectStyle: JRGridViewSubjectStyle = JRGridViewSubjectStyle.Default
    var borderStyle: JRGridViewBorderStyle = JRGridViewBorderStyle.Full
    
    //MARK: - Method
    //MARK: - Methods - Life Circle
    //MARK: - Methods - Inheritance
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init(borderStyle: JRGridViewBorderStyle, frame: CGRect) {
        self.init(style: nil, subjectStyle: nil, borderStyle: borderStyle, frame: frame)
    }
    convenience init(subjectStyle: JRGridViewSubjectStyle, frame: CGRect) {
        self.init(style: nil, subjectStyle: subjectStyle, borderStyle: nil, frame: frame)
    }
    convenience init(style: JRGridViewStyle, frame: CGRect) {
        self.init(style: style, subjectStyle: nil, borderStyle: nil, frame: frame)
    }
    convenience init(style: JRGridViewStyle?, subjectStyle: JRGridViewSubjectStyle?, borderStyle: JRGridViewBorderStyle?, frame: CGRect) {
        self.init(frame: frame)
        if style != nil {
            self.style = style!
        }
        if subjectStyle != nil {
            self.subjectStyle = subjectStyle!
        }
        if borderStyle != nil {
            self.borderStyle = borderStyle!
        }
    }
    //MARK: - Methods - Class(Static)
    //MARK: - Methods - Implementation
    //MARK: Implementations - DataSource
    //MARK: Implementations - Delegate
    
    //MARK: - Methods - Selector
    //MARK: Selectors - Gesture Recognizer
    func didGridViewTileTouched(sender: UITapGestureRecognizer) {
        let tempTile = sender.view! as! JRGridViewTile
        let indexPath = tempTile.indexPath
        
        let selectedTile = self.tileForItemAtIndexPath(indexPath)
        if selectedTile == nil {
            return
        }
        
        if self.selectedGridViewTile != nil {
            self.selectedGridViewTile!.selected = false
        }
        
        self.selectedGridViewTile = selectedTile
        self.selectedGridViewTile!.selected = true
        
        self.selectedIndexPath = indexPath
        if self.delegate != nil {
            if self.delegate!.respondsToSelector("gridView:didSelectItemAtIndexPath:") {
                self.delegate!.gridView!(self, didSelectItemAtIndexPath: indexPath)
            }
        }
    }
    //MARK: Selectors - Action
    func deSelectItemAtIndexPath(indexPath: GridIndexPath) {
        let tile = self.tileForItemAtIndexPath(indexPath)
        if tile != nil {
            if tile!.selected == true {
                tile!.selected = false
            }
            if tile === self.selectedGridViewTile {
                self.selectedGridViewTile = nil
            }
        }
    }
    //MARK: - Methods - Operation
    //MARK: Operations - Go Operation
    //MARK: Operations - Do Operation
    //MARK: Operations - Show or Dismiss Operation
    //MARK: Operations - Setup Operation
    //MARK: Operations - Customed Operation
    func reloadData() {
        
        // If data source doesn't exist, then finish this method.
        if self.dataSource == nil {
            return
        }
        
        if self.scrollView.superview == nil {
            self.addSubview(self.scrollView)
        } else {
            if self.scrollView.superview! != self {
                self.addSubview(self.scrollView)
            }
        }
        
        //Reset scroll view's frame size and scrolling content size.
        self.scrollView.frame = self.bounds
        self.scrollView.contentSize = self.bounds.size
        self.scrollView.directionalLockEnabled = true
        //
        self.clipsToBounds = true
        //Default background color is white.
        switch self.subjectStyle {
        case .Default:
            self.backgroundColor = UIColor.whiteColor()
        case .Inverse:
            self.backgroundColor = UIColor.blackColor()
        }
        //The default number of section will be 1.
        self.numberOfSection = 1
        
        //Data source method 'numberOfSectionsInGridView:' has been implemented, alter the number of section.
        if self.dataSource!.respondsToSelector("numberOfSectionsInGridView:") {
            self.numberOfSection = self.dataSource!.numberOfSectionsInGridView!(self)
        }
        
        //Get row count of each section.
        for section in 0..<self.numberOfSection {
            self.numberOfRows.append(self.dataSource!.gridView(self, numberOfRowsInSection: section))
        }
        //Get column count of each section.
        for section in 0..<self.numberOfSection {
            self.numberOfColumns.append(self.dataSource!.gridView(self, numberOfColumnsInSection: section))
        }
        
        var totalHeight: Float = 0
        var totalWidth: Float = 0
        var widths: [Float] = Array()

        //Initialize the height for each row.
        for section in 0..<self.numberOfSection {
            self.heightForRows.append([Float]())
            for row in 0..<self.numberOfRows[section] {
                let indexPath: GridIndexPath = GridIndexPath(forRow: row, andColumn: 0, inSection: section)
                if self.dataSource!.respondsToSelector("gridView:heightForRowAtIndexPath:") {
                    self.heightForRows[section].append(self.dataSource!.gridView!(self, heightForRowAtIndexPath: indexPath))
                } else {
                    self.heightForRows[section].append(44.0)
                }
            }
        }
        
        //Initialize the width for each column.
        for section in 0..<self.numberOfSection {
            widths.append(0.0)
            let averageWidthForColumns: Float = Float(self.bounds.width) / Float(self.numberOfColumns[0])
            self.widthForColumns.append([Float]())
            for column in 0..<self.numberOfColumns[section] {
                let indexPath: GridIndexPath = GridIndexPath(forRow: 0, andColumn: column, inSection: section)
                if self.dataSource!.respondsToSelector("gridView:widthForColumnAtIndexPath:") {
                    self.widthForColumns[section].append(self.dataSource!.gridView!(self, widthForColumnAtIndexPath: indexPath))
                } else {
                    self.widthForColumns[section].append(averageWidthForColumns)
                }
                widths[section] += self.widthForColumns[section][column]
            }
            if section > 0 {
                if widths[section] > widths[section - 1] {
                    totalWidth = widths[section]
                } else {
                    totalWidth = widths[section - 1]
                }
            } else {
                totalWidth = widths[section]
            }
        }
        
        
        //Reset every tile.
        if self.arrayOfTiles != nil {
            for section in 0..<self.arrayOfTiles!.count {
                for tile in self.arrayOfTiles![section] {
                    (tile as! JRGridViewTile).selected = false
                    tile.removeFromSuperview()
                }
            }
        }
        self.arrayOfTiles = [[AnyObject]]()
        if self.arrayOfHeaders != nil {
            for header in self.arrayOfHeaders! {
                if header.isKindOfClass(UIView.self) {
                    (header as UIView).removeFromSuperview()
                }
            }
        }
        self.arrayOfHeaders = [UIView]()
        if self.arrayOfFooters != nil {
            for footer in self.arrayOfFooters! {
                if footer.isKindOfClass(UIView.self) {
                    (footer as UIView).removeFromSuperview()
                }
            }
        }
        self.arrayOfFooters = [UIView]()

        //Setup header & footer
        for section in 0..<self.numberOfSection {
            
            if self.dataSource!.respondsToSelector("gridView:heightForHeaderInSection:") && (self.dataSource!.respondsToSelector("gridView:titleForHeaderInSection:") || self.dataSource!.respondsToSelector("gridView:viewForHeaderInSection:")) {
                self.heightForHeaders.append(self.dataSource!.gridView!(self, heightForHeaderInSection: section))
            } else {
                self.heightForHeaders.append(Float(0.0))
            }
            
            if self.dataSource!.respondsToSelector("gridView:heightForFooterInSection:") && (self.dataSource!.respondsToSelector("gridView:titleForFooterInSection:") || self.dataSource!.respondsToSelector("gridView:viewForFooterInSection:")) {
                self.heightForFooters.append(self.dataSource!.gridView!(self, heightForFooterInSection: section))
            } else {
                self.heightForFooters.append(Float(0.0))
            }
            
//            totalHeight += self.heightForHeaders[section]
//            totalHeight += self.heightForFooters[section]
        }
        
        //Setup tiles.
        for section in 0..<self.numberOfSection {
            if self.heightForHeaders[section] > 0 {
                let headerContentView: UIView = UIView(frame: CGRect(x: 0, y: CGFloat(totalHeight), width: CGFloat(widths[section]), height: CGFloat(self.heightForHeaders[section])))
                if self.dataSource!.respondsToSelector("gridView:viewForHeaderInSection:") {
                    let viewTemp: UIView = self.dataSource!.gridView!(self, viewForHeaderInSection: section)
                    headerContentView.addSubview(viewTemp)
                } else if self.dataSource!.respondsToSelector("gridView:titleForHeaderInSection:") {
                    let stringTemp: String = self.dataSource!.gridView!(self, titleForHeaderInSection: section)
                    let labelTemp: UILabel = UILabel(frame: CGRect(x: 20, y: 0, width: headerContentView.frame.width, height: headerContentView.frame.height))
                    labelTemp.text = stringTemp
                    headerContentView.addSubview(labelTemp)
                }
                self.scrollView.addSubview(headerContentView)
                self.arrayOfHeaders!.append(headerContentView)
                
                totalHeight += self.heightForHeaders[section]
            } else {
                self.arrayOfHeaders!.append(UIView())
            }
            self.arrayOfTiles!.append([AnyObject]())
            for row in 0..<self.numberOfRows[section] {
                //Calculate the y position of each row.
                var startY: Float = 0
                if section > 0 {
                    startY = Float(CGRectGetMaxY(self.arrayOfFooters![section - 1].frame))
                }
                var y: Float = Float(row) * self.heightForRows[section][row] + startY
                if self.heightForHeaders[section] > 0 {
                    y += self.heightForHeaders[section]
                }
                //Calculate the total height.
                totalHeight += self.heightForRows[section][row]
                for column in 0..<self.numberOfColumns[section] {
                    
                    let x: Float = Float(column) * self.widthForColumns[section][column]
                    let indexPath: GridIndexPath = GridIndexPath(forRow: row, andColumn: column, inSection: section)
                    
                    let tile: JRGridViewTile = self.dataSource!.gridView(self, tileForItemAtIndexPath: indexPath)
                    tile.frame = CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(self.widthForColumns[section][column]), height: CGFloat(self.heightForRows[section][row]))
                    tile.indexPath = indexPath
                    tile.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didGridViewTileTouched:"))
                    self.scrollView.addSubview(tile)
                    self.arrayOfTiles![section].append(tile)
                    if tile.textLabel != nil {
                        tile.textLabel!.frame = tile.bounds
                        tile.textLabel!.textAlignment = NSTextAlignment.Center
                        tile.textLabel!.textColor = UIColor.blackColor()
                        tile.textLabel!.font = UIFont.systemFontOfSize(16.0)
                        tile.addSubview(tile.textLabel!)
                    }
                    if tile.selected == true {
                        self.selectedIndexPath = indexPath
                        self.selectedGridViewTile = tile
                    }
                    let topBorder: CALayer = CALayer()
                    let leftBorder: CALayer = CALayer()
                    let rightBorder: CALayer = CALayer()
                    let bottomBorder: CALayer = CALayer()
                    topBorder.frame = CGRect(x: 0, y: 0, width: tile.frame.width, height: 1)
                    topBorder.backgroundColor = UIColor.lightGrayColor().CGColor
                    bottomBorder.frame = CGRect(x: 0, y: tile.frame.height - 1, width: tile.frame.width, height: 1)
                    bottomBorder.backgroundColor = UIColor.lightGrayColor().CGColor
                    leftBorder.frame = CGRect(x: 0, y: 0, width: 1, height: tile.frame.height)
                    leftBorder.backgroundColor = UIColor.lightGrayColor().CGColor
                    rightBorder.frame = CGRect(x: tile.frame.width - 1, y: 0, width: 1, height: tile.frame.height)
                    rightBorder.backgroundColor = UIColor.lightGrayColor().CGColor
                    switch self.borderStyle {
                    case .SurroundedOnly:
                        if row == 0 {
                            tile.layer.addSublayer(topBorder)
                        }
                        if column == 0 {
                            tile.layer.addSublayer(leftBorder)
                        }
                        if row == self.numberOfRows[section] - 1 {
                            tile.layer.addSublayer(bottomBorder)
                        }
                        if column == self.numberOfColumns[section] - 1 {
                            tile.layer.addSublayer(topBorder)
                        }
                    case .Full:
                        if row == 0 {
                            tile.layer.addSublayer(topBorder)
                        }
                        if column == 0 {
                            tile.layer.addSublayer(leftBorder)
                        }
                        if row == self.numberOfRows[section] - 1 {
                            tile.layer.addSublayer(bottomBorder)
                        }
                        if column == self.numberOfColumns[section] - 1 {
                            tile.layer.addSublayer(rightBorder)
                        }
                        fallthrough
                    case .InsideOnly:
                        if row != 0 {
                            tile.layer.addSublayer(topBorder)
                        }
                        fallthrough
                    case .OrientedOnly:
                        if column != 0 {
                            tile.layer.addSublayer(leftBorder)
                        }
                    case .VerticalOnly:
                        if row != 0 {
                            tile.layer.addSublayer(topBorder)
                        }
                    }
                }
            }
            if self.heightForFooters[section] > 0 {
                let footerContentView: UIView = UIView(frame: CGRect(x: 0, y: CGFloat(totalHeight), width: CGFloat(widths[section]), height: CGFloat(self.heightForFooters[section])))
                if self.dataSource!.respondsToSelector("gridView:viewForFooterInSection:") {
                    let viewTemp: UIView = self.dataSource!.gridView!(self, viewForFooterInSection: section)
                    footerContentView.addSubview(viewTemp)
                } else if self.dataSource!.respondsToSelector("gridView:titleForFooterInSection:") {
                    let stringTemp: String = self.dataSource!.gridView!(self, titleForFooterInSection: section)
                    let labelTemp: UILabel = UILabel(frame: CGRect(x: 20, y: 0, width: footerContentView.frame.width, height: footerContentView.frame.height))
                    labelTemp.text = stringTemp
                    footerContentView.addSubview(labelTemp)
                }
                if section != self.numberOfSection - 1 {
                    let bottomBorder: CALayer = CALayer()
                    bottomBorder.frame = CGRect(x: 0, y: footerContentView.frame.height - 1, width: footerContentView.frame.width, height: 1)
                    bottomBorder.backgroundColor = UIColor.blackColor().CGColor
                    footerContentView.layer.addSublayer(bottomBorder)
                }
                self.scrollView.addSubview(footerContentView)
                self.arrayOfFooters!.append(footerContentView)
                
                totalHeight += self.heightForFooters[section]
            } else {
                self.arrayOfFooters!.append(UIView())
            }
//            sectionStartY = Float(section) * totalHeight
        }
        
        //Configure scroll view size.
        var sizeOfScrollView: CGSize = self.bounds.size
        if totalWidth > Float(sizeOfScrollView.width) {
            sizeOfScrollView.width = CGFloat(totalWidth)
        }
        if totalHeight > Float(sizeOfScrollView.height) {
            sizeOfScrollView.height = CGFloat(totalHeight) + 65
        }
        self.scrollView.contentSize = sizeOfScrollView
        
    }
    //MARK: - Methods - Getter
    func tileForItemAtIndexPath(indexPath: GridIndexPath) -> JRGridViewTile? {
        let section = indexPath.section
        let index = indexPath.row * self.numberOfColumns[section] + indexPath.column
        if self.arrayOfTiles == nil {
            return nil
        } else {
            if index >= self.arrayOfTiles![section].count {
                return nil
            } else if index < 0 {
                return nil
            } else {
                return self.arrayOfTiles![section][index] as? JRGridViewTile
            }
        }
    }
    func numberOfSections() -> Int {
        return self.numberOfSection
    }
    func numberOfRowsInSection(section: Int) -> Int {
        if section <= self.numberOfSection - 1 && section >= 0 {
            return self.numberOfRows[section]
        } else {
            return 0
        }
    }
    func numberOfColumnInSection(section: Int) -> Int {
        if section <= self.numberOfSection - 1 && section >= 0 {
            return self.numberOfColumns[section]
        } else {
            return 0
        }
    }
    func heightForRowAtIndexPath(indexPath: GridIndexPath) -> Float {
        let section = indexPath.section
        if section < 0 || section > self.numberOfSection {
            return 0
        }
        let row = indexPath.row
        if row < 0 || row > self.numberOfRows[section] {
            return 0
        }
        return self.heightForRows[section][row]
    }
    func widthForColumnAtIndexPath(indexPath: GridIndexPath) -> Float {
        let section = indexPath.section
        if section < 0 || section > self.numberOfSection {
            return 0
        }
        let column = indexPath.column
        if column < 0 || column > self.numberOfColumns[section] {
            return 0
        }
        return self.widthForColumns[section][column]
    }
    func heightForHeaderInSection(section: Int) -> Float {
        if section <= self.numberOfSection - 1 && section >= 0 {
            return self.heightForHeaders[section]
        } else {
            return 0
        }
    }
    func heightForFooterInSection(section: Int) -> Float {
        if section <= self.numberOfSection - 1 && section >= 0 {
            return self.heightForFooters[section]
        } else {
            return 0
        }
    }
    func titleForHeaderInSection(section: Int) -> String? {
        if section <= self.numberOfSection - 1 && section >= 0 {
            return self.titleForHeaders[section]
        } else {
            return nil
        }
    }
    func titleForFooterInSection(section: Int) -> String? {
        if section <= self.numberOfSection - 1 && section >= 0 {
            return self.titleForFooters[section]
        } else {
            return nil
        }
    }
    func viewForHeaderInSection(section: Int) -> UIView? {
        if section <= self.numberOfSection - 1 && section >= 0 {
            return self.viewForHeaders[section]
        } else {
            return nil
        }
    }
    func viewForFooterInSection(section: Int) -> UIView? {
        if section <= self.numberOfSection - 1 && section >= 0 {
            return self.viewForFooters[section]
        } else {
            return nil
        }
    }
    //MARK: - Methods - Setter
}

//MARK: - Classes - Extensions
class GridIndexPath: NSObject {
    var section: Int = Int(-1)
    var row: Int = Int(-1)
    var column: Int = Int(-1)
    
    override init() {
        super.init()
    }
    
    convenience init(forRow row: Int, andColumn column: Int, inSection section: Int) {
        self.init()
        self.section = section
        self.row = row
        self.column = column
    }
    
}

