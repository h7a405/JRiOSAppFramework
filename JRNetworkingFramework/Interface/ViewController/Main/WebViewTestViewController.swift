//
//  WebViewTestViewController.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 19/10/15.
//  Copyright © 2015年 hSevenA405. All rights reserved.
//

import UIKit

class WebViewTestViewController: UIViewController {
    //MARK: - Parameter
    //MARK: Parameters - Constant
    //MARK: Parameters - Basic
    //MARK: Parameters - Foundation
    //MARK: Parameters - UIKit
    @IBOutlet weak var urlTextField: UITextField!
    //MARK: Parameters - Other
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setNavigationBarUncovered()
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
        let nibNameOrNil = String?("WebViewTestViewController")
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
    //MARK: Methods - Other
}
//MARK: - Extension
//MARK: Extensions - Initation & Setup
//MARK: Extensions - Operation & Action
extension WebViewTestViewController {
    @IBAction func didButtonClicked(sender: AnyObject) {
        self.openWebView("http://www.baidu.com")
    }
    @IBAction func didGoButtonClicked(sender: AnyObject) {
        if !self.urlTextField.isEmpty {
            var theURL = self.urlTextField.text!
            if theURL.hasPrefix("http://") || theURL.hasPrefix("https://") {
                
            } else {
                let tempURL = "http://" + theURL
                theURL = tempURL
            }
            self.openWebView(theURL)
        } else {
            self.urlTextField.placeholder = "请先输入网址。"
        }
    }
    
    func openWebView(theURL: String) {
        let instance: JRWebViewController = JRWebViewController()
        instance.theURL = theURL
        self.navigationController!.pushViewController(instance, animated: true)
    }
}
//MARK: Extensions - Getter / Setter
//MARK: Extensions - DataSource
//MARK: Extensions - Delegate
//MARK: - Class
//MARK: Classes - Other