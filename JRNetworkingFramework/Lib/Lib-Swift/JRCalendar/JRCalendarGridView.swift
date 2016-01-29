//
//  JRCalandarGridView.swift
//  JingJianLogistics-iOS
//
//  Created by SilversRayleigh on 7/9/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

import UIKit

@objc protocol JRCalendarGridViewDataSource: NSObjectProtocol {
    
    optional func heightForRowInGridView(gridView: JRCalendarGridView) -> Float
    
    func numberOfRowsInGridView(gridView: JRCalendarGridView) -> Int
    
    func gridView(gridView: JRCalendarGridView, tileForRowAtIndexPath indexPath: JRIndexPath) -> JRCalendarGridViewTile
}

@objc protocol JRCalendarGridViewDelegate: NSObjectProtocol {
    func gridView(gridView: JRCalendarGridView, didSelectRowAtIndexPath indexPath: JRIndexPath)
}

class JRCalendarGridView: UIView {
    
    //MARK: - DataSource & Delegate Instance
    var dataSource: JRCalendarGridViewDataSource?
    var delegate: JRCalendarGridViewDelegate?
    
    //MARK: - Basic Parameters
    var calendarStyle: JRCalendarStyle = JRCalendarStyle.Default
    
    var autoResize: Bool = false
    
    var rows: Int = 0
    
    var rowHeight: Float = 0.0
    var columnWidth: Float = 0.0
    
    var arrayOfTiles: [AnyObject]? = Array()
    
    //MARK: - Operations
    var selectedGridViewTile: JRCalendarGridViewTile?
    var selectedIndexPath: JRIndexPath = JRIndexPath(row: -1, column: -1)
    var tapGesture: UITapGestureRecognizer?
    
    //MARK: - JRCalendarStyle.Coolspable Paramters
    var isCollapsed: Bool = false
    
    //MARK: - Override Method
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Instance's Initialation
    convenience init() {
        self.init()
    }
    
    //MARK: - Customed Method
    func reloadData() {
        if self.dataSource == nil {
            return
        }
        
        self.clipsToBounds = true
        self.backgroundColor = UIColor.whiteColor()
        
        self.rows = self.dataSource!.numberOfRowsInGridView(self)
        
        self.rowHeight = 46.0
        
        if self.dataSource!.respondsToSelector("heightForRowInGridView:") {
            self.rowHeight = self.dataSource!.heightForRowInGridView!(self)
        }
        self.columnWidth = Float(self.bounds.size.width / 7)
        
        for tile in self.arrayOfTiles! {
            (tile as! JRCalendarGridViewTile).selected = false
            tile.removeFromSuperview()
        }
        self.arrayOfTiles = [AnyObject]()
        
        for i in 0..<self.rows {
            let y: Float = Float(i) * self.rowHeight
            
            for j in 0..<7 {
                let x: Float = Float(j) * self.columnWidth
                let tile: JRCalendarGridViewTile = self.dataSource!.gridView(self, tileForRowAtIndexPath: JRIndexPath(row: i, column: j))
                tile.frame = CGRect(x: CGFloat(x), y: CGFloat(y), width: CGFloat(self.columnWidth), height: CGFloat(self.rowHeight))
                tile.label.frame = tile.bounds
                self.addSubview(tile)
                self.arrayOfTiles!.append(tile)
                
                if tile.selected == true {
                    self.selectedIndexPath = JRIndexPath(row: i, column: j)
                    self.selectedGridViewTile = tile
                }
            }
        }
        
        if self.autoResize == true {
            let frame: CGRect = self.frame
            viewHeight = CGFloat(self.rowHeight) * CGFloat(self.rows)
            self.frame = frame
        }
        
        if self.tapGesture == nil {
            self.tapGesture = UITapGestureRecognizer(target: self, action: "didGridViewTileTouched:")
            self.addGestureRecognizer(self.tapGesture!)
        }
    }
    
    func tileForRowAtIndexPath(indexPath: JRIndexPath) -> JRCalendarGridViewTile? {
        let index = indexPath.row * 7 + indexPath.column
        if self.arrayOfTiles == nil {
            return nil
        } else {
            if index >= self.arrayOfTiles!.count {
                return nil
            } else {
                return self.arrayOfTiles![index] as? JRCalendarGridViewTile
            }
        }
    }
    
    func numberOfRows() -> Int {
        return self.rows
    }
    
    func didGridViewTileTouched(tapGesture: UITapGestureRecognizer) {
        let point = tapGesture.locationInView(self)
        let row = Int(Float(point.y) / self.rowHeight)
        let column = Int(Float(point.x) / self.columnWidth)
        let indexPath = JRIndexPath(row: row, column: column)
        
        let selectedTile = self.tileForRowAtIndexPath(indexPath)
        if selectedTile == nil {
            return
        }
        
        self.selectedGridViewTile!.selected = false
        self.selectedGridViewTile = selectedTile
        self.selectedGridViewTile!.selected = true
        
        self.selectedIndexPath = indexPath
        
        if self.delegate != nil && self.delegate!.respondsToSelector("gridView:") {
            self.delegate!.gridView(self, didSelectRowAtIndexPath: indexPath)
        }
    }
    
    //MARK: - Getters & Setters
}


