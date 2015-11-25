//
//  JRCardSwitchingView.swift
//  JRNetworkingFramework
//
//  Created by Chanel.Cheng on 15/11/24.
//  Copyright © 2015年 hSevenA405. All rights reserved.
//

import UIKit
//MARK: Header - Enum
enum JRCardSwitchingType {
    case StackType
    case ExpandType
}
//MARK: Header - Protocol
@objc protocol JRCardSwitchingViewDelegate: NSObjectProtocol {
    
}
class JRCardSwitchingView: UIView {
    //MARK: - Parameter
    //MARK: Parameters - Constant
    let totalAmountOfCards: Int = 3
    
    let widthOfCard: CGFloat = 300
    let heightOfCard: CGFloat = 500
    //MARK: Parameters - Basic
    var numberOfCards: Int = 0
    var currentIndex: Int = 0
    
    var contentViewArray: [UIView] = Array()
    //MARK: Parameters - Foundation
    //MARK: Parameters - UIKit
    let scrollView: UIScrollView = UIScrollView()
    
    let leftContentView: UIView = UIView()
    let middleContentView: UIView = UIView()
    let rightContentView: UIView = UIView()
    
    let pageControl: UIPageControl = UIPageControl()
    //MARK: Parameters - Other
    var delegate: JRCardSwitchingViewDelegate?
    
    var type: JRCardSwitchingType = JRCardSwitchingType.ExpandType
    
    //MARK: - Method
    //MARK: Methods - Override
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    //MARK: Methods - Required
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //MARK: Methods - Convenience
    convenience init(frame: CGRect, numberOfCards card: Int?, viewsToDisplay views: [UIView]?) {
        self.init(frame: frame)
        
        if card != nil {
            self.numberOfCards = card!
        } else {
            self.numberOfCards = 5
        }
        
        self.initContents(views)
        self.initScrollView()
        self.initContentViews()
        self.initDefaultContents()
        self.initPageControl()
    }
    convenience init(frame: CGRect, numberOfCards card: Int?) {
        self.init(frame: frame, numberOfCards: card, viewsToDisplay: nil)
    }
    convenience init(frame: CGRect, viewsToDisplay views: [UIView]?) {
        self.init(frame: frame, numberOfCards: nil, viewsToDisplay: views)
    }
    //MARK: Methods - Other
}
//MARK: - Extension
//MARK: Extensions - Initation & Setup
extension JRCardSwitchingView {
    func initContents(views: [UIView]?) {
        if views != nil {
            for view in views! {
                self.contentViewArray.append(view)
            }
        } else {
            for i in 0..<self.numberOfCards {
                let tempView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.widthOfCard, height: self.heightOfCard))
                tempView.backgroundColor = UIColor.RGB(red: CGFloat(i) * 30, green: CGFloat(i) * 10, blue: CGFloat(i) * 60)
                self.contentViewArray.append(tempView)
            }
        }
    }
    func initScrollView() {
        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.widthOfCard, height: self.heightOfCard)
        self.scrollView.center = self.center
        self.scrollView.delegate = self
        
        self.scrollView.contentSize = CGSize(width: CGFloat(totalAmountOfCards) * (self.widthOfCard), height:0)
        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        
        self.scrollView.setContentOffset(CGPoint(x: self.widthOfCard, y: 0), animated: false)
        
        self.addSubview(self.scrollView)
    }
    func initContentViews() {
        self.leftContentView.frame = CGRect(x: 0, y: 0, width: self.widthOfCard, height: self.heightOfCard)
        self.leftContentView.backgroundColor = UIColor.clearColor()
        
        self.middleContentView.frame = CGRect(x: self.widthOfCard, y: 0, width: self.widthOfCard, height: self.heightOfCard)
        self.middleContentView.backgroundColor = UIColor.clearColor()
        
        self.rightContentView.frame = CGRect(x: CGFloat(2) * self.widthOfCard, y: 0, width: self.widthOfCard, height: self.heightOfCard)
        self.rightContentView.backgroundColor = UIColor.clearColor()
        
        self.scrollView.addSubview(self.leftContentView)
        self.scrollView.addSubview(self.middleContentView)
        self.scrollView.addSubview(self.rightContentView)
    }
    func initDefaultContents() {
        self.leftContentView.addSubview(self.contentViewArray[numberOfCards - 1])
        self.middleContentView.addSubview(self.contentViewArray[0])
        self.rightContentView.addSubview(self.contentViewArray[1])
        
        self.currentIndex = 0
        
        self.pageControl.currentPage = self.currentIndex
    }
    func initPageControl() {
        let size: CGSize = self.pageControl.sizeForNumberOfPages(self.numberOfCards)
        self.pageControl.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.pageControl.center = CGPoint(x: self.widthOfFrame / 2, y: self.heightOfFrame * 0.75)
        
        self.pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        self.pageControl.currentPageIndicatorTintColor = UIColor.LuoTianYi()
    
        self.pageControl.numberOfPages = self.numberOfCards
        
        self.addSubview(self.pageControl)
    }
}
//MARK: Extensions - Operation & Action
extension JRCardSwitchingView {
    func reloadContent() {
        let offset: CGPoint = self.scrollView.contentOffset
        if offset.x > self.widthOfCard {
            self.currentIndex = (self.currentIndex + 1) % self.numberOfCards
        } else if offset.x < self.widthOfCard {
            self.currentIndex = (self.currentIndex + self.numberOfCards - 1) % self.numberOfCards
        }
        for view in self.contentViewArray {
            view.removeFromSuperview()
        }
        self.middleContentView.addSubview(self.contentViewArray[self.currentIndex])
        self.leftContentView.addSubview(self.contentViewArray[(self.currentIndex + self.numberOfCards - 1) % self.numberOfCards])
        self.rightContentView.addSubview(self.contentViewArray[(self.currentIndex + 1) % self.numberOfCards])
    }
}
//MARK: Extensions - Getter / Setter
//MARK: Extensions - DataSource
//MARK: Extensions - Delegate
extension JRCardSwitchingView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.reloadContent()
        
        self.scrollView.setContentOffset(CGPoint(x: self.widthOfCard, y: 0), animated: false)
        self.pageControl.currentPage = self.currentIndex
        
    }
}
//MARK: - Class
//MARK: Classes - Other