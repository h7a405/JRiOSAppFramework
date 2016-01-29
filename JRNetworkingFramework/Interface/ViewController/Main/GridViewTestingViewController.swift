//
//  GridViewTestingViewController.swift
//  JRNetworkingFramework
//
//  Created by SilversRayleigh on 20/10/15.
//  Copyright © 2015年 hSevenA405. All rights reserved.
//

import UIKit

class GridViewTestingViewController: UIViewController {
    //MARK: - Parameter
    //MARK: Parameters - Constant
    //MARK: Parameters - Basic
    //MARK: Parameters - Foundation
    //MARK: Parameters - UIKit
    //MARK: Parameters - Other
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNavigationBarUncovered()

        let gridView = JRGridView(borderStyle: JRGridViewBorderStyle.Full, frame: UIScreen.mainScreen().bounds)
        
        gridView.dataSource = self
        gridView.delegate = self
        
        self.view.addSubview(gridView)
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
        let nibNameOrNil = String?("GridViewTestingViewController")
        self.init(nibName: nibNameOrNil, bundle: nil)
    }
    //MARK: Methods - Other
}
//MARK: - Extension
//MARK: Extensions - Initation & Setup
//MARK: Extensions - Operation & Action
//MARK: Extensions - Getter / Setter
//MARK: Extensions - DataSource
extension GridViewTestingViewController: JRGridViewDataSource {
    func numberOfSectionsInGridView(gridView: JRGridView) -> Int {
        return 2
    }
    func gridView(gridView: JRGridView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 5
        case 1:
            return 10
        default:
            return 0
        }
    }
    func gridView(gridView: JRGridView, numberOfColumnsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 5
        case 1:
            return 10
        default:
            return 0
        }
    }
    func gridView(gridView: JRGridView, heightForRowAtIndexPath indexPath: GridIndexPath) -> Float {
        return 60.0
    }
    
    func gridView(gridView: JRGridView, widthForColumnAtIndexPath indexPath: GridIndexPath) -> Float {
        return 60.0
    }
    
    func gridView(gridView: JRGridView, heightForHeaderInSection section: Int) -> Float {
        return 30.0
    }
    func gridView(gridView: JRGridView, heightForFooterInSection section: Int) -> Float {
        return 30.0
    }
    func gridView(gridView: JRGridView, titleForHeaderInSection section: Int) -> String {
        return "header\(section)"
    }
    func gridView(gridView: JRGridView, titleForFooterInSection section: Int) -> String {
        return "footer\(section)"
    }
    func gridView(girdView: JRGridView, tileForItemAtIndexPath indexPath: GridIndexPath) -> JRGridViewTile {
        let tile = JRGridViewTile(tileStyle: JRGridViewTileStyle.Default)
        
        tile.textLabel!.text = "(\(indexPath.section),\(indexPath.row),\(indexPath.column))"
        
        return tile
    }
}
extension GridViewTestingViewController: JRGridViewDelegate {
    func gridView(gridView: JRGridView, didSelectItemAtIndexPath indexPath: GridIndexPath) {
        gridView.deSelectItemAtIndexPath(indexPath)
    }
}
//MARK: Extensions - Delegate
//MARK: - Class
//MARK: Classes - Other