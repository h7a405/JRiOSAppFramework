//
//  JRReadingViewController.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 21/10/15.
//  Copyright © 2015年 hSevenA405. All rights reserved.
//

import UIKit

enum JRReadingViewControllerStatus {
    case Reading
    case Holding
    case OpeningCategory
}

class JRReadingViewController: UIViewController {
    //MARK: - Parameter
    //MARK: Parameters - Constant
    //MARK: Parameters - Basic
    var toolBarHidden: Bool = false {
        willSet {
            if self.toolBarHidden != newValue {
                var yToTransform: CGFloat = 0
                if newValue {
                    yToTransform = self.toolBar.frame.size.height
                } else {
                    yToTransform = -(self.toolBar.frame.size.height)
                }
                UIView.animateWithDuration(0.2, animations: {()
                    self.toolBar.transform = CGAffineTransformTranslate(self.toolBar.transform, 0, yToTransform)
                    
                    }, completion: {(finished: Bool) in
                        
                        self.navigationController?.navigationBarHidden = newValue
                })
            }
        }
        didSet {
            if (self.navigationController?.respondsToSelector("interactivePopGestureRecognizer") != nil) {
                self.navigationController?.interactivePopGestureRecognizer?.enabled = !self.toolBarHidden
            }
            self.contentScrollView.scrollEnabled = self.toolBarHidden
            if self.toolBarHidden {
                self.status = JRReadingViewControllerStatus.Reading
            } else {
                self.status = JRReadingViewControllerStatus.Holding
            }
        }
    }
    
    var hasLast: Bool = false
    var hasNext: Bool = true
    
    var currentPage: Int = 0 {
        willSet {
            if newValue <= 0 {
                self.hasLast = false
                self.hasNext = true
            } else if newValue >= self.totalPages {
                self.hasLast = true
                self.hasNext = false
            }
        }
    }
    var totalPages: Int = 9
    //MARK: Parameters - Foundation
    //MARK: Parameters - UIKit
    @IBOutlet weak var contentScrollView: UIScrollView!
    @IBOutlet weak var toolBar: UIView!
    //MARK: Parameters - Other
    var status: JRReadingViewControllerStatus = JRReadingViewControllerStatus.Holding
    
    var readingViews: [JRReadingView]?
    var currentReadingView: JRReadingView?
    var lastReadingView: JRReadingView?
    var nextReadingView: JRReadingView?
    
    //MARK: - Methods
    //MARK: Methods - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        self.toolBarHidden = true
        self.contentScrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didContentScrollViewTouched:"))
        
        self.readingViews = Array()
        for _ in 0..<3 {
            self.readingViews!.append(JRReadingView())
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setupReadingViews()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    override func prefersStatusBarHidden() -> Bool {
        return self.toolBarHidden
    }
    //MARK: Methods - Required
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //MARK: Methods - Convenience
    convenience init() {
        let nibNameOrNil = String?("JRReadingViewController")
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
    //MARK: Methods - Other
}
//MARK: - Extension
//MARK: Extensions - Initation & Setup
extension JRReadingViewController {
    func setupReadingViews() {
        if self.readingViews != nil {
            for i in 0..<self.readingViews!.count {
                readingViews![i].frame = CGRect(x: CGFloat(i) * self.contentScrollView.frame.size.width, y: 0, width: self.contentScrollView.frame.size.width, height: self.contentScrollView.frame.size.height)
                readingViews![i].backgroundColor = UIColor.RGB(red: CGFloat(i) * 50, green: 100, blue: 100)
                self.contentScrollView.addSubview(readingViews![i])
            }
        }
        self.contentScrollView.contentSize = CGSize(width: CGFloat(self.readingViews!.count) * self.contentScrollView.frame.size.width, height: self.contentScrollView.frame.size.height)
//        self.contentScrollView.setContentOffset(CGPoint(x: CGFloat(Int(self.readingViews!.count)) * self.contentScrollView.frame.size.width, y: 0), animated: false)
        self.lastReadingView = self.readingViews![(currentPage + 2) % 3]
        self.currentReadingView = self.readingViews![currentPage % 3]
        self.nextReadingView = self.readingViews![(currentPage + 1) % 3]
    }
}
//MARK: Extensions - Operation & Action
extension JRReadingViewController {
    func didContentScrollViewTouched(sender: UITapGestureRecognizer) {
        let endOfLeftZone: CGFloat = UIScreen.mainScreen().bounds.width * CGFloat(0.2)
        let beginOfRightZone: CGFloat = UIScreen.mainScreen().bounds.width * CGFloat(0.8)
        let touchedPoint: CGPoint = sender.locationInView(self.view)
        if touchedPoint.x < endOfLeftZone {
            self.loadNextPage(isDirectionRight: false)
        } else if touchedPoint.x > beginOfRightZone {
            self.loadNextPage(isDirectionRight: true)
        } else {
            self.toolBarHidden = !self.toolBarHidden
        }
    }
    func loadNextPage(isDirectionRight direction: Bool) {
        if direction {
            if self.hasNext {
                self.changeCurrentReadingView(true)
            } else {
                SVProgressHUD.showInfoWithStatus("已到最后一页")
            }
        } else {
            if self.hasLast {
                self.changeCurrentReadingView(false)
            } else {
                SVProgressHUD.showInfoWithStatus("已到第一页")
            }
        }
    }
    func changeCurrentReadingView(isNext: Bool) {
        if isNext {
            self.lastReadingView = self.currentReadingView
            self.currentReadingView = self.nextReadingView
//            self.currentPage = (self.currentPage + 1) % 3
            self.currentPage = self.currentPage + 1
            self.nextReadingView = self.readingViews![self.currentPage % 3]
        } else {
            self.nextReadingView = self.currentReadingView
            self.currentReadingView = self.lastReadingView
//            self.currentPage = (self.currentPage - 1) % 3
            self.currentPage = self.currentPage - 1
            self.lastReadingView = self.readingViews![self.currentPage % 3]
        }
        self.contentScrollView.setContentOffset(self.currentReadingView!.frame.origin, animated: true)
        Log.VLog(self.currentPage)
    }
}
//MARK: Extensions - Getter / Setter
extension JRReadingViewController {
}
//MARK: Extensions - DataSource
//MARK: Extensions - Delegate
extension JRReadingViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if !self.toolBarHidden {
            return
        }
    }
}
//MARK: - Class
//MARK: Classes - Other