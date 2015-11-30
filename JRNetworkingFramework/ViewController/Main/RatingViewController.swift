//
//  RatingViewController.swift
//  JRNetworkingFramework
//
//  Created by Chanel.Cheng on 15/11/24.
//  Copyright © 2015年 hSevenA405. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {
    
    let ratingView: JRRatingView = JRRatingView(frame: CGRectZero, numberOfStars: 5, defaultValue: 0)
    
    var locationHandler: LocationHandler?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(title: "定位", style: UIBarButtonItemStyle.Done, target: self, action: "didRelocatedButtonClicked:")
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.ratingView.frame = CGRect(x: 0, y: 0, width: 150, height: 30)
        self.ratingView.frame = self.view.centerMiddle(self.ratingView)
        
        self.view.addSubview(self.ratingView)
        
        self.locationHandler = LocationHandler(delegate: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func didRelocatedButtonClicked(sender: AnyObject) {
        self.locationHandler!.updateLocation()
        Log.VLog(self.locationHandler!.currentLocation.toString())
        locationHandler!.getAddressNameWithLocation(self.locationHandler!.currentLocation)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
