//
//  JRCarouselView.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 15/10/2015.
//  Copyright © 2015 hSevenA405. All rights reserved.
//

/**
* @Description:
*
*/

//MARK: - Header
//MARK: Header - Including Files
import UIKit
//MARK: Header - Enums
//Use to decide which type of content that the view will display.
enum JRCarouselViewDisplayType {
    case Views
    case Images
}
//MARK: Header - Protocols
@objc protocol JRCarouselViewDelegate: NSObjectProtocol {
    optional func carouselView(carouselView: JRCarouselView, didSelectAtIndex index: Int)
}

class JRCarouselView: UIView {
    //MARK: - Parameter
    //MARK: Parameters - Constant
    //The default height of header.
    let heightOfHeader: Float = 45
    let heightOfHeaderIndicatorBar: Float = 2
    //The default height of pageControl.
    let heightOfPageControl: Float = 20
    
    let headerSelectedColor: UIColor = UIColor.orangeColor()
    let headerUnSelectedColor: UIColor = UIColor.grayColor()
    let headerHighlightedColor: UIColor = UIColor.lightGrayColor()
    //MARK: Parameters - Basic
    //To control if header is needed to display.
    var isHeaderNeeded: Bool = true
    //To control if pageControl is needed to display.
    var isPageControlNeeded: Bool = true
    
    //Current selected index.
    var selectedIndex: Int = Int(0)
    
    //Contents that had been displayed on view.
    var contents: [AnyObject]?
    //MARK: Parameters - Foundation
    //MARK: Parameters - UIKit
    //A bar to show which one is now been selected in header.
    var selectedBar: UILabel?
    var headerButtons: [UIButton]?
    //The header to display titles.
    var headerView: UIScrollView?
    
    //Which to display contents.
    var scrollView: UIScrollView?
    
    //The bar to show which one is now been selected in bottom.
    var pageControl: UIPageControl?
    //MARK: Parameters - Other
    //What type of content will be displayed.
    var type: JRCarouselViewDisplayType?
    
    var delegate: JRCarouselViewDelegate?
    
    //MARK: - Method
    //MARK: Methods - Override
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    //MARK: Methods - Required
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    //MARK: Methods - Convenience
    convenience init(frame: CGRect, type: JRCarouselViewDisplayType?) {
        self.init(frame: frame)
        self.type = type
    }
    //MARK: Methods - Other
}
//MARK: - Extension
//MARK: Extensions - Initation
extension JRCarouselView {
    /*
     * @Description:
     * Initialize the CarouselView.
     */
    func initCarouselView() {
        //If header is neccessary, then initialize the header.
        if self.isHeaderNeeded {
            self.initHeader()
        }
        
        self.initScrollView()
        
        //If pageControl is neccessary, then initialize the pageControl
        if self.isPageControlNeeded {
            self.initPageControl()
        }
    }
    /*
     * @Description:
     * Initialize the HeaderView if header is needed.
     */
    func initHeader() {
        //Initialize the headerView if hasn't been initialized yet.
        if self.headerView == nil {
            self.headerView = UIScrollView(frame: CGRect(
                x: 0,
                y: 0,
                width: self.frame.size.width,
                height: CGFloat(self.heightOfHeader)))
//            self.headerView!.delegate = self
        }
    }
    /*
     * @Description:
     * Initialize the ScrollView which used to show contents.
     */
    func initScrollView() {
        //Initialize the scrollView if hasn't been initialized yet.
        if self.scrollView == nil {
            self.scrollView = UIScrollView(frame: CGRect(
                x: 0,
                y: self.isHeaderNeeded ? CGFloat(self.heightOfHeader) : 0,
                width: self.frame.size.width,
                height: self.isHeaderNeeded ? self.frame.size.height - CGFloat(self.heightOfHeader) : self.frame.size.height))
            self.scrollView!.pagingEnabled = true
            self.scrollView!.showsHorizontalScrollIndicator = false
            self.scrollView!.showsVerticalScrollIndicator = false
            self.scrollView!.delegate = self
        }
    }
    /*
     * @Description:
     * Initialize the PageControl if it is needed.
     */
    func initPageControl() {
        //Initialize the pageControl if hasn't been initialized yet.
        if self.pageControl == nil {
            self.pageControl = UIPageControl(frame: CGRect(
                x: 0,
                y: self.frame.size.height - CGFloat(self.heightOfPageControl) - 5,
                width: self.frame.size.width,
                height: CGFloat(self.heightOfPageControl)))
        }
    }
}
//MARK: Extensions - Setup
extension JRCarouselView {
    func setupCarouselView(content: [AnyObject]?, titles: [String]?) {
        //If no contents to display, then finish.
        if content == nil {
            return
        }
        //Initialize all the view before any movement.
        self.initCarouselView()
        
        if self.contents == nil {
            self.contents = Array()
        }
        
        if self.type == JRCarouselViewDisplayType.Images {
            //If contents aren't images, finish.
            if let images: [UIImage] = content as? [UIImage] {
                self.setupWithImages(images)
            } else {
                return
            }
        } else if self.type == JRCarouselViewDisplayType.Views {
            //If contents aren't views, finish.
            if let views: [UIView] = content as? [UIView] {
                self.setupWithViews(views)
            } else {
                return
            }
        } else {
            //Other situations, left for expanding.
            return
        }
        self.scrollView!.contentSize = CGSize(width: CGFloat(self.contents!.count) * self.scrollView!.frame.size.width, height: self.scrollView!.frame.size.height)
        if self.isHeaderNeeded {
            if titles != nil {
                self.setupHeader(titles!)
                self.addSubview(self.headerView!)
            }
        }
        self.addSubview(self.scrollView!)
        if self.isPageControlNeeded {
            self.setupPageControl()
            self.addSubview(self.pageControl!)
        }
    }
    func setupWithImages(images: [UIImage]) {
        for (index, image) in images.enumerate() {
            let tempImageView: UIImageView = UIImageView(image: image)
            tempImageView.frame = CGRect(
                x: CGFloat(index) * self.scrollView!.frame.size.width,
                y: 0,
                width: self.scrollView!.frame.size.width,
                height: self.scrollView!.frame.size.height)
            self.contents!.append(tempImageView)
            self.scrollView!.addSubview(tempImageView)
        }
    }
    func setupWithViews(views: [UIView]) {
        for (index, view) in views.enumerate() {
            let tempView: UIView = view
            tempView.frame = CGRect(
                x: CGFloat(index) * self.scrollView!.frame.size.width,
                y: 0,
                width: self.scrollView!.frame.size.width,
                height: self.scrollView!.frame.size.height)
            self.contents!.append(tempView)
            self.scrollView!.addSubview(tempView)
        }
    }
    func setupHeader(titles: [String]) {
        let averageWidth: Float = Float(self.headerView!.frame.size.width) / Float(titles.count)
        if self.headerButtons == nil {
            self.headerButtons = Array()
        }
        for (index, title) in titles.enumerate() {
            let tempButton: UIButton = UIButton(frame: CGRect(
                x: CGFloat(index) * CGFloat(averageWidth),
                y: -64,
                width: CGFloat(averageWidth),
                height: self.headerView!.frame.size.height - CGFloat(self.heightOfHeaderIndicatorBar)))
            tempButton.setTitle(title, forState: UIControlState.Normal)
            if index == self.selectedIndex {
                tempButton.setTitleColor(self.headerSelectedColor, forState: UIControlState.Normal)
            } else {
                tempButton.setTitleColor(self.headerUnSelectedColor, forState: UIControlState.Normal)
            }
            tempButton.setTitleColor(self.headerHighlightedColor, forState: UIControlState.Highlighted)
//            tempButton.backgroundColor = UIColor.lightGrayColor()
            tempButton.addTarget(self, action: "didHeaderTitleButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
            self.headerButtons!.append(tempButton)
            self.headerView!.addSubview(tempButton)
        }
        if self.selectedBar == nil {
            self.selectedBar = UILabel(frame: CGRect(
                x: CGFloat(self.selectedIndex) * CGFloat(averageWidth),
                y: self.headerView!.frame.size.height - CGFloat(self.heightOfHeaderIndicatorBar) - 64,
                width: CGFloat(averageWidth),
                height: CGFloat(self.heightOfHeaderIndicatorBar)))
            self.selectedBar!.backgroundColor = self.headerSelectedColor
            self.headerView!.addSubview(self.selectedBar!)
        }
    }
    func setupPageControl() {
        self.pageControl!.numberOfPages = self.contents!.count
        self.pageControl!.currentPage = self.selectedIndex
    }
}
//MARK: Extensions - Operation
extension JRCarouselView {
    //MARK: Selector
    func didHeaderTitleButtonClicked(sender: UIButton) {
        var indexToSelect: Int = -1
        for (index, button) in self.headerButtons!.enumerate() {
            if sender === button {
                indexToSelect = index
                break
            }
        }
        self.setSelectTo(indexToSelect)
    }
    //MARK: Operation
    func setContentToShow(index: Int) {
        self.selectedIndex = index
        
        for (_, button) in self.headerButtons!.enumerate() {
            button.setTitleColor(self.headerUnSelectedColor, forState: UIControlState.Normal)
        }
        if self.headerView != nil {
            UIView.animateWithDuration(0.2, animations: {()
                self.selectedBar!.frame.origin.x = CGFloat(self.selectedIndex) * (self.headerView!.frame.size.width / CGFloat(self.headerButtons!.count))
                self.headerButtons![self.selectedIndex].setTitleColor(self.headerSelectedColor, forState: UIControlState.Normal)
            })
        }
        self.scrollView!.setContentOffset(CGPoint(x: CGFloat(self.selectedIndex) * self.scrollView!.frame.size.width, y: 0), animated: true)
        
        if self.pageControl != nil {
            self.pageControl!.currentPage = self.selectedIndex
        }
        
        if self.delegate != nil {
            if self.delegate!.respondsToSelector("carouselView:didSelectAtIndex:") {
                self.delegate!.carouselView!(self, didSelectAtIndex: self.selectedIndex)
            }
        }
    }
}
//MARK: Extension - Getter / Setter
extension JRCarouselView {
    func setSelectTo(index: Int) {
        if self.selectedIndex != index {
            if index >= 0 && index < self.contents!.count {
                self.setContentToShow(index)
            }
        }
    }
    func getCurrentSelectedIndex() -> Int {
        return self.selectedIndex
    }
}
//MARK: Extensions - Implements
extension JRCarouselView: UIScrollViewDelegate {
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offset: CGPoint = scrollView.contentOffset
        let currentIndex: Int = self.selectedIndex
        let currentOffset: CGPoint = CGPoint(x: CGFloat(currentIndex) * self.scrollView!.frame.size.width, y: 0)
        if offset.x - currentOffset.x > 30 && offset.x > 0 {
            if decelerate {
                self.setSelectTo(currentIndex + 1)
            }
        } else if currentOffset.x - offset.x > 30 {
            if decelerate {
                self.setSelectTo(currentIndex - 1)
            }
        }
    }
}
