//
//  ProgressBarTestingViewController.swift
//  JRNetworkingFramework
//
//  Created by Jason.Chengzi on 16/01/12.
//  Copyright © 2016年 WeSwift. All rights reserved.
//
//MARK: - 类注释
/*
*
*/

//MARK: - 头文件
import UIKit

//MARK: - class函数
class ProgressBarTestingViewController: UIViewController {
    //MARK: UIKit - UIView/UIControl/UIViewController
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentSegmentedControl: UISegmentedControl!
    @IBOutlet weak var updateButton: UIButton!
    
    lazy var progressBar: JZProgressBar = {
        return JZProgressBar(frame: self.contentView.bounds, totalValue: CGFloat(self.totalValue), currentValue: CGFloat(self.progressValue), progressColor: UIColor.yellowColor(), progressBarColor: UIColor.lightGrayColor(), cornerRadius: self.contentView.viewHeight / 2, valueTextColor: UIColor.blackColor(), valueTextFont: UIFont.systemFontOfSize(13))
    }()
    
    //MARK: 储存变量 - Int/Float/Double/String
    let totalValue: Float = 999999
    var progressValue: Float = 0
    //MARK: 集合类型 - Array/Dictionary/Tuple
    
    //MARK: 自定义类型 - Custom
    
    //MARK: 计算变量
    
    //MARK: 闭包与结构体 - Closure/Struct
    
    //MARK: 代理与数据源 - delegate/datasource
    
    //MARK: 重写 - Override/Required/Convenience
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.progressBar.isShowProgressWithAnimated = true
        self.contentView.addSubview(self.progressBar)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    convenience init() {
        let nibNameOrNil = String?("ProgressBarTestingViewController")
        self.init(nibName: nibNameOrNil, bundle: nil)
    }

}
//MARK: - 拓展
//MARK: 初始化与配置 - Initailize & Setup

//MARK: 操作与执行 - Action & Operation
extension ProgressBarTestingViewController {
    @IBAction func didProgressSegmentedControlValueChanged(sender: AnyObject) {
        if let index = sender.selectedSegmentIndex {
            switch index {
            case 1:
                self.progressValue = self.totalValue * 0.2
            case 2:
                self.progressValue = self.totalValue * 0.4
            case 3:
                self.progressValue = self.totalValue * 0.6
            case 4:
                self.progressValue = self.totalValue * 0.8
            case 5:
                self.progressValue = self.totalValue
            default:
                self.progressValue = 0
            }
        }
        self.progressBar.updateProgressWithValue(CGFloat(self.progressValue))
    }
}
//MARK: 判断 - Judgement

//MARK: 选择器 - Selector

//MARK: 回调 - Call back

//MARK: 数据源与代理 - DataSrouce/Delegate
//MARK: Getter/Setter