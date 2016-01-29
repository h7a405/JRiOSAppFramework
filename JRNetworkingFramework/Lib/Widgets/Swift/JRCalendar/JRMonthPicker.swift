
//
//  JRMonthPicker.swift
//  JingJianLogistics-iOS
//
//  Created by SilversRayleigh on 8/9/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

import Foundation
import UIKit

protocol JRMonthPickerDelegate {
    func updateDisplaingDateWithString(year: Int, month: Int)
}

class JRMonthPicker: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    //MARK: - Parameter - Constant
    let maxMonth: Int = Int(12)
    let minMonth: Int = Int(1)
    
    let rowHeight: Float = Float(44.0)
    
    let numberOfComponent: Int = Int(2)

    //MARK: - Parameter - Customed
    var theDelegate: JRMonthPickerDelegate?
    
    //MARK: - Parameter - Basic
    var maxYear: Int = Int(2050)
    var minYear: Int = Int(2000)
    
    var currentYear: Int = Int(0)
    var currentMonth: Int = Int(0)
    
    var arrayOfMonth: [Int] = Array()
    var arrayOfYear: [Int] = Array()
    
    var componentWidth: Float = Float(0)
    
    //MARK: - Parameter - Foundation
    var date: NSDate?
    
    var indexPathOfToday: NSIndexPath?
    
    //MARK: - Parameter - UIKit
    
    
    
    //MARK: - Method - Initialation
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.arrayOfMonth = self.getMonths()
        self.arrayOfYear = self.getYears()
        
        self.indexPathOfToday = self.getTodayIndexPath()
        
        self.delegate = self
        self.dataSource = self
        
        self.setSelectToday()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init(delegate: JRMonthPickerDelegate) {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 216), minYear: 2000, maxYear: 2050, delegate: delegate)
    }
    convenience init(minYear: Int, maxYear: Int) {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 216), minYear: minYear, maxYear: maxYear, delegate: nil)
    }
    convenience init(frame: CGRect, minYear: Int, maxYear: Int, delegate: JRMonthPickerDelegate?) {
        self.init(frame: frame)
        
        self.minYear = minYear
        self.maxYear = maxYear
        
        if delegate != nil {
            self.theDelegate = delegate
        }
    }
    
    //MARK: - Method - DataSource Implementation
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return self.numberOfComponent
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return self.arrayOfYear.count
        case 1:
            return self.arrayOfMonth.count
        default:
            return 0
        }
    }
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(self.rowHeight)
    }
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return (self.bounds.width / CGFloat(numberOfComponent))
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        var contentTemp: Int = Int(0)
        
        switch component {
        case 0:
            contentTemp = self.arrayOfYear[row]
        case 1:
            contentTemp = self.arrayOfMonth[row]
        default:
            break
        }
//        println((row, contentTemp))
        if view == nil {
            let newView: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat(self.componentWidth), height: CGFloat(self.rowHeight)))
            newView.text = "\(contentTemp)"
            newView.textAlignment = NSTextAlignment.Center
            return newView
        } else {
            return view!
        }
//        return UIView()
    }
    
    //MARK: - Method - Delegate Implementation
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            self.currentYear = self.arrayOfYear[row]
        } else {
            self.currentMonth = self.arrayOfMonth[row]
        }
        
        if self.theDelegate != nil {
            self.theDelegate!.updateDisplaingDateWithString(self.currentYear, month: self.currentMonth)
        }
    }
    
    //MARK: - Method - Getter
    func getMonths() -> [Int] {
        var months: [Int] = Array()
        for month in minMonth...maxMonth {
            months.append(month)
        }
        return months
    }
    func getYears() -> [Int] {
        var years: [Int] = Array()
        for year in minYear...maxYear {
            years.append(year)
        }
        return years
    }
    func getCurrentMonth() -> Int {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM"
        let date: NSDate = NSDate()
        let string: String = dateFormatter.stringFromDate(date)
        return Int(string)!
    }
    func getCurrentYear() -> Int {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let date: NSDate = NSDate()
        return (Int(dateFormatter.stringFromDate(date)))!
    }
    func getTodayIndexPath() -> NSIndexPath {
        let currentMonth: Int = self.getCurrentMonth()
        let currentYear: Int = self.getCurrentYear()
        
        var row: Int = 0
        var section: Int = 0
        
        for (index, month) in self.arrayOfMonth.enumerate() {
            if month == currentMonth {
                row = index
                break
            }
        }
        
        for (index, year) in self.arrayOfYear.enumerate() {
            if year == currentYear {
                section = index
                break
            }
        }
        self.currentYear = self.arrayOfYear[section]
        self.currentMonth = self.arrayOfMonth[row]
        return NSIndexPath(forRow: row, inSection: section)
    }
    
    //MARK: - Method - Setter
    func setSelectToday() {
        if self.indexPathOfToday == nil {
            self.indexPathOfToday = self.getTodayIndexPath()
        }
        self.selectRow(self.indexPathOfToday!.row, inComponent: 1, animated: true)
        self.selectRow(self.indexPathOfToday!.section, inComponent: 0, animated: true)
    }
}
