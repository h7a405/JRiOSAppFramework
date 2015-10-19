//
//  JRWebViewController.swift
//  JingJianLogistics-iOS
//
//  Created by SilversRayleigh on 24/9/15.
//  Copyright (c) 2015 qi-cloud.com. All rights reserved.
//

import UIKit

class JRWebViewController: UIViewController {
    //MARK: - Parameter
    //MARK: Parameters - Constant
    //MARK: Parameters - Basic
    var theURL: String = ""
    
    var currentPageIndex: Int = Int(-1)
    
    var isLoading: Bool = false
    //MARK: Parameters - Foundation
    //MARK: Parameters - UIKit
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var footerView: UIView!
    
    @IBOutlet weak var progressBar: UILabel!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    //MARK: Parameters - Other
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadWebWithiURL(self.theURL)
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
        let nibNameOrNil = String?("JRWebViewController")
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
    //MARK: Methods - Other
}
//MARK: - Extension
//MARK: Extensions - Initation & Setup
//MARK: Extensions - Operation & Action
extension JRWebViewController {
    @IBAction func didBackButtonClicked(sender: AnyObject) {
        self.webView.goBack()
    }
    @IBAction func didForwardButtonClicked(sender: AnyObject) {
        self.webView.goForward()
    }
    @IBAction func didRefreshButtonClicked(sender: AnyObject) {
        if self.isLoading {
            self.webView.stopLoading()
        } else {
            self.webView.reload()
        }
    }
    @IBAction func didMoreButtonClicked(sender: AnyObject) {
    }
    
    func loadWebWithiURL(url: String) {
        let URL: NSURL? = NSURL(string: url)
        if URL != nil {
            let request: NSURLRequest = NSURLRequest(URL: URL!)
            self.webView.loadRequest(request)
        }
    }
}
//MARK: Extensions - Getter / Setter
//MARK: Extensions - DataSource
//MARK: Extensions - Delegate
extension JRWebViewController: UIWebViewDelegate {
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        self.isLoading = false
        
        self.refreshButton.setTitle("○", forState: UIControlState.Normal)
        
        self.progressBar.alpha = 1
        self.progressBar.backgroundColor = UIColor.redColor()
        self.progressBar.frame.size.width = self.headerView.frame.width
    }
    func webViewDidStartLoad(webView: UIWebView) {
        self.isLoading = true
        
        self.refreshButton.setTitle("X", forState: UIControlState.Normal)
        
        self.progressBar.alpha = 1
        self.progressBar.backgroundColor = UIColor.orangeColor()
        self.progressBar.frame.size.width = 0
        UIView.animateWithDuration(1, animations: {()
            self.progressBar.frame.size.width = self.headerView.frame.width * 0.75
        }, completion: nil)
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        self.isLoading = false
        
        self.refreshButton.setTitle("○", forState: UIControlState.Normal)
        
        UIView.animateWithDuration(0.2, animations: {()
            self.progressBar.frame.size.width = self.headerView.frame.width
        }, completion: {(finished: Bool) in
            UIView.animateWithDuration(0.2, animations: {()
                self.progressBar.alpha = 0
            })
        })
    }
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        switch navigationType {
        case .BackForward:
            self.currentPageIndex--
            self.forwardButton.enabled = true
        case .FormSubmitted, .FormResubmitted, .LinkClicked, .Other:
            self.currentPageIndex++
            self.forwardButton.enabled = false
        default:
            break
        }
        if self.currentPageIndex == 0 {
            self.backButton.enabled = false
        } else {
            self.backButton.enabled = true
        }
        return true
    }
}
//MARK: - Class
//MARK: Classes - Other