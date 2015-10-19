//
//  JRPickerView.swift
//  JingJianLogistics-iOS
//
//  Created by SilversRayleigh on 10/9/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

import UIKit

protocol JRPickerViewDelegate {
    func JRpickerView(pickerView: JRPickerView, didSelectRowAtIndexPath indexPath: NSIndexPath?, content: String)
}

class JRPickerView: UIView {
    
    var dataArray: [String]?
    
    var coverView: UIView = UIView()
    var contentView: UIView = UIView()
    var pickerView: UIPickerView = UIPickerView()
    
    var selectedContentLabel: UILabel = UILabel()
    
    var delegate: JRPickerViewDelegate?
    var indexPath: NSIndexPath?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(pickerData: [String]?, delegate: JRPickerViewDelegate?) {
        self.init()
        
        self.frame = UIScreen.mainScreen().screenSize()
        
        self.dataArray = pickerData
        
        self.coverView.frame = self.bounds
        self.coverView.backgroundColor = UIColor.lightGrayColor()
        self.coverView.alpha = 0
        self.coverView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didCoverViewTouched:"))
        
        self.contentView.frame = CGRect(x: 0, y: self.frame.size.height - 266, width: self.frame.size.width, height: 266)
        self.contentView.backgroundColor = UIColor.blackColor()
        
        let cancelButton: UIButton = UIButton(frame: CGRect(x: 10, y: 0, width: self.contentView.frame.size.width / 5, height: 50))
        cancelButton.setTitle("取消", forState: UIControlState.Normal)
        cancelButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        cancelButton.addTarget(self, action: "didCancelButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        let confirmButton: UIButton = UIButton(frame: CGRect(x: self.contentView.frame.size.width - cancelButton.frame.size.width - 10, y: 0, width: cancelButton.frame.size.width, height: cancelButton.frame.size.height))
        confirmButton.setTitle("确认", forState: UIControlState.Normal)
        confirmButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        confirmButton.addTarget(self, action: "didConfirmButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.selectedContentLabel.frame = CGRect(x: (self.contentView.frame.size.width - 120) / 2, y: 0, width: 120, height: 50)
        self.selectedContentLabel.textAlignment = NSTextAlignment.Center
        self.selectedContentLabel.textColor = UIColor.whiteColor()
        self.selectedContentLabel.text = "请选择"
        
        self.pickerView.frame = CGRect(x: 0, y: 50, width: self.contentView.frame.size.width, height: 216)
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        self.pickerView.backgroundColor = UIColor.whiteColor()
        
        self.contentView.addSubview(cancelButton)
        self.contentView.addSubview(confirmButton)
        self.contentView.addSubview(self.selectedContentLabel)
        self.contentView.addSubview(self.pickerView)
        
        self.addSubview(self.coverView)
        self.addSubview(self.contentView)
        
        self.delegate = delegate
        
    }
    
    func resizeComponents() {
        self.coverView.frame = self.bounds
        self.contentView.frame = CGRect(x: 0, y: self.frame.size.height - 256, width: self.frame.size.width, height: 256)
    }
    
    func didCancelButtonClicked(sender: AnyObject) {
        self.dismiss()
    }
    func didConfirmButtonClicked(sender: AnyObject) {
        if self.delegate != nil {
            self.delegate!.JRpickerView(self, didSelectRowAtIndexPath: self.indexPath, content: self.selectedContentLabel.text!)
        }
        self.dismiss()
    }
    func didCoverViewTouched(sender: AnyObject) {
        self.dismiss()
    }
    
    func showOnView(superView: UIView) {
        //        self.alpha = 0
        self.frame = superView.bounds
        self.resizeComponents()
        
        if self.dataArray != nil {
            //            self.selectedContentLabel.text = self.dataArray![0]
            self.pickerView(self.pickerView, didSelectRow: 0, inComponent: 0)
        }
        
        self.coverView.alpha = 0
        self.contentView.transform = CGAffineTransformTranslate(self.contentView.transform, 0, self.contentView.frame.size.height)
        superView.addSubview(self)
        UIView.animateWithDuration(0.3, animations: {()
            self.alpha = 1
            self.coverView.alpha = 0.3
            self.contentView.transform = CGAffineTransformTranslate(self.contentView.transform, 0, -self.contentView.frame.size.height)
            }, completion: {(finished: Bool) in
                
        })
    }
    
    func dismiss() {
        UIView.animateWithDuration(0.3, animations: {()
            self.coverView.alpha = 0
            self.contentView.transform = CGAffineTransformTranslate(self.contentView.transform, 0, self.contentView.frame.size.height)
            }, completion: {(finished: Bool) in
                self.removeFromSuperview()
        })
    }
}
extension JRPickerView: UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if self.dataArray != nil {
            return self.dataArray!.count
        } else {
            return 0
        }
    }
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        if view == nil {
            let newView: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.frame.size.width, height: 40.0))
            newView.text = self.dataArray![row]
            newView.textAlignment = NSTextAlignment.Center
            return newView
        } else {
            return view!
        }
    }
}
extension JRPickerView: UIPickerViewDelegate {
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedContentLabel.text = self.dataArray![row]
        self.indexPath = NSIndexPath(forRow: row, inSection: component)
    }
}
