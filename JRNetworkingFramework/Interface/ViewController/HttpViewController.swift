//
//  NetworkTestingViewController.swift
//  JingJianLogistics-iOS
//
//  Created by SilversRayleigh on 29/9/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

import UIKit

class HttpViewController: UIViewController {

    @IBOutlet weak var baseURLTextField: UITextField!
    @IBOutlet weak var routeTextField: UITextField!
    
    @IBOutlet weak var resultTextView: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var baseURLSwitch: UISwitch!
    @IBOutlet weak var methodSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var insertParamButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    var selectedIndex: Int = Int(-1)
    var numberOfParams: Int = Int(0)
    
    var dataOfParamters: [(String, String)]?
    
    override func viewDidLoad() {
        self.tableView.tableFooterView = UIView()
        
        self.dataOfParamters = Array<(String, String)>()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init() {
        let nibNameOrNil = String?("HttpViewController")
        self.init(nibName: nibNameOrNil, bundle: nil)
    }

    @IBAction func baseURLLock(sender: AnyObject) {
        let theSwitch = sender as! UISwitch
        if theSwitch.on {
            self.baseURLTextField.enabled = false
        } else {
            self.baseURLTextField.enabled = true
        }
    }

    @IBAction func didInsertButtonClicked(sender: AnyObject) {
        self.numberOfParams++
//        self.tableView.reloadData()
        let emptyTuple = ("", "")
        self.dataOfParamters!.append(emptyTuple)
        self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: self.numberOfParams - 1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    @IBAction func didSubmitButtonClicked(sender: AnyObject) {
        if self.baseURLTextField.text!.characters.count > 0 {
//            self.requestData()
            self.resultTextView.text = ""
        } else {
            self.resultTextView.text = "Base url is requried."
        }
    }
}
//MARK: - Classes - Extension
//MARK: - Extensions - DataSource
extension HttpViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfParams
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? HttpTableViewCell
        if cell == nil {
            let array_xib = NSBundle.mainBundle().loadNibNamed("HttpTableViewCell", owner: nil, options: nil)
            cell = array_xib[0] as? HttpTableViewCell
        }
        if indexPath.row <= self.numberOfParams - 1 {
            cell!.keyTextField.text = self.dataOfParamters![indexPath.row].0
            cell!.dataTextField.text = self.dataOfParamters![indexPath.row].1
        }
        cell!.keyTextField.delegate = self
        cell!.dataTextField.delegate = self
        cell!.keyTextField.tag = 900000 + indexPath.row
        cell!.dataTextField.tag = 800000 + indexPath.row
        cell!.tag = 700000 + indexPath.row
//        self.dataOfParameters.append()
        return cell!
    }
}
//MARK: - Extensions - Delegate
extension  HttpViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
//MARK: - Classes - Custom
extension HttpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.tag >= 800000 && textField.tag < 900000 {
            self.dataOfParamters![textField.tag - 800000].1 = textField.text!
        } else if textField.tag >= 900000 {
            self.dataOfParamters![textField.tag - 900000].0 = textField.text!
        }
    }
}
