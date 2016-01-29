//
//  CarouselTestingViewController.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 15/10/2015.
//  Copyright © 2015 hSevenA405. All rights reserved.
//

import UIKit

class CarouselTestingViewController: UIViewController {
    
    var carouselView: JRCarouselView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.carouselView = JRCarouselView(frame: CGRect(x: 0, y: 64, width: UIScreen.mainScreen().screenWidth(), height: UIScreen.mainScreen().screenHeight()), type: JRCarouselViewDisplayType.Images)
        self.carouselView!.setupCarouselView([UIImage(named: "FYBroker")!, UIImage(named: "FYMember")!, UIImage(named: "FYPresident")!, UIImage(named: "FYShareHolder")!], titles: ["经纪人", "会员", "行长", "股权人"])
        self.view.addSubview(self.carouselView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
