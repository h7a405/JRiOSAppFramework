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
    
    var isLoading: Bool = false
    var isTabBarHidding: Bool = false
    
    var theLastScrollToLocation: CGPoint = CGPoint(x: 0, y: 0)
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

        if Double(UIDevice.currentDevice().systemVersion) > 7.0 {
            self.edgesForExtendedLayout = UIRectEdge.None
            self.extendedLayoutIncludesOpaqueBars = false
            self.modalPresentationCapturesStatusBarAppearance = false
        }
        
        for view in self.webView.subviews {
            if view.isKindOfClass(UIScrollView.self) {
                (view as! UIScrollView).delegate = self
            }
        }
        
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
    @IBAction func didRefreshButtonClicked(sender: AnyObject) {
        if self.isLoading {
            self.webView.stopLoading()
        } else {
            self.webView.reload()
        }
    }
    @IBAction func didMoreButtonClicked(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "请选择您要进行的操作：", message: "", preferredStyle: UIAlertControllerStyle.ActionSheet)
        let actionSheetCancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        actionSheet.addAction(actionSheetCancelAction)
        let safariOpenAction: UIAlertAction = UIAlertAction(title: "在Safari打开", style: UIAlertActionStyle.Default, handler: {(alertAction: UIAlertAction) in
            UIApplication.sharedApplication().openURL(self.webView.request!.URL!)
        })
        actionSheet.addAction(safariOpenAction)
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func loadWebWithiURL(url: String) {
        let URL: NSURL? = NSURL(string: url)
        if URL != nil {
            let request: NSURLRequest = NSURLRequest(URL: URL!)
            self.webView.loadRequest(request)
        }
    }
    
    func setTabBarHide(isToHide: Bool) {
        if self.isTabBarHidding == isToHide {
            return
        }
        var yToTransform: Float = 0
        if isToHide {
            yToTransform = 45
        } else {
            yToTransform = -45
        }
        UIView.animateWithDuration(0.2, animations: {()
//            self.footerView.frame.origin.y += CGFloat(yToTransform)
//            self.webView.frame.size.height += CGFloat(yToTransform)
            self.footerView.transform = CGAffineTransformTranslate(self.footerView.transform, 0, CGFloat(yToTransform))
        }, completion: nil)
        self.isTabBarHidding = isToHide
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
        
        self.refreshButton.setTitle("×", forState: UIControlState.Normal)
        
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
        
        if webView.canGoBack {
            self.backButton.enabled = true
        } else {
            self.backButton.enabled = false
        }
        
        if !self.isTabBarHidding {
            self.setTabBarHide(true)
        }
    }
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        switch navigationType {
        case .BackForward:
            break
        case .FormSubmitted, .FormResubmitted, .LinkClicked, .Other:
            break
        default:
            break
        }
        return true
    }
}
extension JRWebViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let currentScrollToLocation: CGPoint = scrollView.contentOffset
        if currentScrollToLocation.y - self.theLastScrollToLocation.y > 20 {
            if !self.isTabBarHidding {
                self.setTabBarHide(true)
            }
        } else if self.theLastScrollToLocation.y - currentScrollToLocation.y > 20 {
            if self.isTabBarHidding {
                self.setTabBarHide(false)
            }
        }
        self.theLastScrollToLocation = currentScrollToLocation
    }
}
//MARK: - Class
//MARK: Classes - Other