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
    var cacheReadingView: JRReadingView?
    
    //MARK: - Methods
    //MARK: Methods - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        self.toolBarHidden = true
        self.contentScrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didContentScrollViewTouched:"))
        
        self.readingViews = Array()
        for _ in 0..<4 {
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
            }
        }
        self.contentScrollView.contentSize = CGSize(width: CGFloat(self.readingViews!.count - 1) * self.contentScrollView.frame.size.width, height: self.contentScrollView.frame.size.height)
    }
}
//MARK: Extensions - Operation & Action
extension JRReadingViewController {
    func didContentScrollViewTouched(sender: UITapGestureRecognizer) {
        let endOfLeftZone: CGFloat = UIScreen.mainScreen().bounds.width * CGFloat(0.2)
        let beginOfRightZone: CGFloat = UIScreen.mainScreen().bounds.width * CGFloat(0.8)
        let touchedPoint: CGPoint = sender.locationInView(self.contentScrollView)
        if touchedPoint.x < endOfLeftZone {
            self.loadNextPage(isDirectionRight: false)
        } else if touchedPoint.x > beginOfRightZone {
            self.loadNextPage(isDirectionRight: true)
        } else {
            self.toolBarHidden = !self.toolBarHidden
        }
    }
    func loadNextPage(isDirectionRight direction: Bool) {
        
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