//
//  JRCalendarView.swift
//  JingJianLogistics-iOS
//
//  Created by SilversRayleigh on 7/9/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

import UIKit

class JRCalendarView: UIView, JRCalendarPickerViewDelegate {
    
    let titleView: UIView = UIView()
    let headerView: UIView = UIView()
    let calendarView: UIView = UIView()
    
    var pickerView: JRCalendarPickerView?
    
    var calendar: JRCalendarGridView?
    
    let titleLabel: UILabel = UILabel()
    let previousMonthButton: UIButton = UIButton()
    let followingMonthButton: UIButton = UIButton()
    
    var style: JRCalendarStyle = JRCalendarStyle.Default
    
    var calendarModel: JRCalendarModel = JRCalendarModel()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(frame: CGRect, style: JRCalendarStyle) {
        self.init(frame: frame)
        self.style = style
        self.setupView()
    }
    
    func setupView() {
        self.setupStyle()
        self.setupTitle()
        self.setupHeader()
        self.setupCalendar()
        
        self.addSubview(self.titleView)
        self.addSubview(self.headerView)
        self.addSubview(self.calendarView)
        
        self.titleLabel.text = String("\(self.calendarModel.selectedCalendarDay.year)年\(self.calendarModel.selectedCalendarDay.month)月")
    }
    
    func setupStyle() {
        switch self.style {
        case .Default:
            self.backgroundColor = UIColor.whiteColor()
            
            self.titleLabel.textColor = UIColor.blackColor()
            
            self.previousMonthButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
            self.previousMonthButton.setTitleColor(UIColor.brownColor(), forState: UIControlState.Highlighted)
            
            self.followingMonthButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
            self.followingMonthButton.setTitleColor(UIColor.brownColor(), forState: UIControlState.Highlighted)
            
        case .Inverse:
            self.backgroundColor = UIColor.blackColor()
            
            self.titleLabel.textColor = UIColor.whiteColor()
            self.previousMonthButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            self.previousMonthButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
            
            self.followingMonthButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            self.followingMonthButton.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
            
        }
        self.titleView.backgroundColor = UIColor.clearColor()
        self.headerView.backgroundColor = UIColor.clearColor()
        self.calendarView.backgroundColor = UIColor.clearColor()
        
        self.titleLabel.backgroundColor = UIColor.clearColor()
    }
    
    func setupTitle() {
        self.titleView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: 40)
        
        self.titleLabel.frame = CGRect(x: (self.titleView.frame.size.width / 3), y: 0, width: (self.titleView.frame.size.width / 3), height: self.titleView.frame.size.height)
        
        self.previousMonthButton.frame = CGRect(x: 10, y: 0, width: (self.titleView.frame.size.width / 4) - 10, height: self.titleLabel.frame.size.height)
        self.followingMonthButton.frame = CGRect(x: self.titleView.frame.size.width - self.previousMonthButton.frame.size.width - 10, y: 0, width: self.previousMonthButton.frame.size.width - 10, height: self.titleLabel.frame.size.height)
        
        self.titleLabel.textAlignment = NSTextAlignment.Center
        self.titleLabel.font = UIFont.systemFontOfSize(15.0)
        self.titleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didTitleLabelTouched:"))
        self.titleLabel.userInteractionEnabled = true
        self.titleLabel.text = String("\(self.calendarModel.selectedCalendarDay.year)年\(self.calendarModel.selectedCalendarDay.month)月")
        
        self.previousMonthButton.setTitle("上一月", forState: UIControlState.Normal)
        self.previousMonthButton.addTarget(self, action: "didPreviousMonthButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.followingMonthButton.setTitle("下一月", forState: UIControlState.Normal)
        self.followingMonthButton.addTarget(self, action: "didFollowingMonthButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.titleView.addSubview(self.titleLabel)
        self.titleView.addSubview(self.previousMonthButton)
        self.titleView.addSubview(self.followingMonthButton)
    }
    
    func setupHeader() {
        self.headerView.frame = CGRect(x: 0, y: CGRectGetHeight(self.titleView.frame), width: self.frame.size.width, height: 20)
        
        let array_strings = ["日", "一", "二", "三", "四", "五", "六"]
        
        for i in 0..<array_strings.count {
            let width = CGFloat(self.headerView.frame.size.width / 7)
            
            let tempLabel = UILabel(frame: CGRect(x: width * CGFloat(i), y: 0, width: width, height: self.headerView.frame.size.height))
            tempLabel.backgroundColor = UIColor.clearColor()
            tempLabel.textAlignment = NSTextAlignment.Center
            tempLabel.textColor = self.titleLabel.textColor
            tempLabel.font = UIFont.systemFontOfSize(14.0)
//            tempLabel.layer.borderWidth = 1
//            tempLabel.layer.borderColor = self.titleLabel.textColor!.CGColor
            tempLabel.text = array_strings[i]
            
            self.headerView.addSubview(tempLabel)
        }
        
        let dividerLabel = UILabel(frame: CGRect(x: 5, y: self.headerView.frame.size.height - 1, width: self.headerView.frame.size.width - 10, height: 1))
        dividerLabel.backgroundColor = self.titleLabel.textColor
        
        self.headerView.addSubview(dividerLabel)
    }
    
    func setupCalendar() {
        self.calendarView.frame = CGRect(x: 0, y: CGRectGetHeight(self.titleView.frame), width: self.frame.size.width, height: (self.frame.size.height - CGRectGetMaxY(self.headerView.frame)))
        
        self.calendar = JRCalendarGridView(frame: self.calendarView.frame)
        
        self.calendarView.addSubview(self.calendar!)
        
        self.calendarModel.reloadCalendarView(self.calendar!)
    }
    
    func setupPicker() {
        self.pickerView = (NSBundle.mainBundle().loadNibNamed("JRCalendarPickerView", owner: nil, options: nil)[0]) as? JRCalendarPickerView
        self.pickerView!.setupPicker(self.titleLabel.text!, delegate: self)
        self.pickerView!.frame = self.superview!.bounds
    }
    
    func didTitleLabelTouched(sender: AnyObject?) {
        self.setupPicker()
        self.pickerView!.showOnView(self)
    }
    
    func didPreviousMonthButtonClicked(sender: AnyObject?) {
        self.calendarModel.gotoPreviousMonthInCalendarView(self.calendar!)
        self.titleLabel.text = String("\(self.calendarModel.selectedCalendarDay.year)年\(self.calendarModel.selectedCalendarDay.month)月")
    }
    
    func didFollowingMonthButtonClicked(sender: AnyObject?) {
        self.calendarModel.gotoFollowintMonthInCalendarView(self.calendar!)
        self.titleLabel.text = String("\(self.calendarModel.selectedCalendarDay.year)年\(self.calendarModel.selectedCalendarDay.month)月")
    }
    
    func doGotoMonth(year: Int, month: Int) {
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy/MM"
        self.calendarModel.reloadCalendarView(self.calendar!, date: dateFormatter.dateFromString("\(year)/\(month)"))
        self.titleLabel.text = String("\(self.calendarModel.selectedCalendarDay.year)年\(self.calendarModel.selectedCalendarDay.month)月")
    }
}

protocol JRCalendarPickerViewDelegate {
    func doGotoMonth(year: Int, month: Int)
}

class JRCalendarPickerView: UIView, JRMonthPickerDelegate {
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var datePicker: UIView!
    
    
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerCancelButton: UIButton!
    @IBOutlet weak var headerConfirmButton: UIButton!
    
    var selectedDate: (Int, Int) = (0, 0)
    
    var delegate: JRCalendarPickerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init() {
        self.init()
    }
    
    func setupPicker(dateString: String, delegate: JRCalendarPickerViewDelegate?) {
        self.backgroundColor = UIColor.clearColor()
        
        self.headerTitleLabel.text = dateString
        self.delegate = delegate
        
        self.coverView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didCoverViewTouched:"))
        
        self.coverView.alpha = 0
//        self.datePicker.frame = CGRect(x: self.datePicker.frame.origin.x, y: SCREEN_HEIGHT(), width: self.datePicker.frame.size.width, height: 216)
        self.datePicker.addSubview(JRMonthPicker(frame: CGRect(x: 0, y: self.datePicker.frame.size.height - 216, width: UIScreen.mainScreen().screenWidth(), height: 216), minYear: 2000, maxYear: 2050, delegate: self))
        self.datePicker.transform = CGAffineTransformTranslate(self.datePicker.transform, 0, self.datePicker.frame.size.height)
    }
    
    func showOnView(superView: UIView) {
//        let window: UIWindow? = (UIApplication.sharedApplication().delegate as? AppDelegate)?.window
//        
//        if window == nil {
//            return
//        }
//        window!.addSubview(self)

        superView.superview!.addSubview(self)
        UIView.animateWithDuration(0.35, animations: {()
            
            self.datePicker.transform = CGAffineTransformTranslate(self.datePicker.transform, 0, -(self.datePicker.frame.size.height))
            
            self.coverView.alpha = 0.3
        }, completion: {(finished: Bool) in
            
        })
    }
    func dismiss() {
        UIView.animateWithDuration(0.35, animations: {()
            
            self.datePicker.transform = CGAffineTransformTranslate(self.datePicker.transform, 0, self.datePicker.frame.size.height)
            
            self.coverView.alpha = 0
        }, completion: {(finished: Bool) in
            self.removeFromSuperview()
        })
    }
    
    func updateDisplaingDateWithString(year: Int, month: Int) {
        self.headerTitleLabel.text = "\(year)年\(month)月"
        self.selectedDate = (year, month)
    }
    
    func didCoverViewTouched(sender: UITapGestureRecognizer?) {
        self.dismiss()
    }
    
    @IBAction func didCancelButtonClicked(sender: UIButton) {
        self.dismiss()
    }
    @IBAction func didConfirmButtonClicked(sender: UIButton) {
        self.dismiss()
        if self.selectedDate.0 != 0 && self.selectedDate.1 != 0 {
            if self.delegate != nil {
                self.delegate!.doGotoMonth(self.selectedDate.0, month: self.selectedDate.1)
            }
        }
    }
    
}
