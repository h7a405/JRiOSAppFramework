//
//  JZProgressBar.h
//  JRNetworkingFramework
//
//  Created by Jason.Chengzi on 16/01/12.
//  Copyright © 2016年 WeSwift. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZProgressBar : UIView

#pragma mark    判断内容
@property   (nonatomic, assign) BOOL isShowValue;    //是否显示在进度条上的数值，默认显示
@property   (nonatomic, assign) BOOL isShowProgressWithAnimated;    //是否动画方式显示，默认不显示

#pragma mark    显示内容（不建议直接操作）
@property   (nonatomic, assign) CGFloat cornerRadius;   //圆角数值（不建议直接操作）
@property   (nonatomic, assign) CGFloat totalValue; //进度条总数（不建议直接操作）
@property   (nonatomic, assign) CGFloat currentValue;   //当前读数（不建议直接操作）
@property   (nonatomic, strong) UIColor * progressBarColor; //进度条背景颜色
@property   (nonatomic, strong) UIColor * progressColor;  //进度条显示颜色（不建议直接操作）
@property   (nonatomic, strong) UIColor * valueTextColor;   //进度条文字颜色
@property   (nonatomic, strong) UIFont * valueTextFont;   //进度条文字字体

#pragma mark    初始化方法
-   (instancetype)  initWithFrame:  (CGRect) frame
                       totalValue:  (CGFloat) totalValue
                     currentValue:  (CGFloat) currentValue;

-   (instancetype)  initWithFrame:  (CGRect) frame
                       totalValue:  (CGFloat) totalValue
                     currentValue:  (CGFloat) currentValue
                   valueTextColor:  (UIColor *) valueTextColor
                    valueTextFont:  (UIFont *) valueTextFont;

-   (instancetype)  initWithFrame:  (CGRect) frame
                       totalValue:  (CGFloat) totalValue
                     currentValue:  (CGFloat) currentValue
                    progressColor:  (UIColor *) progressColor
                  progressBarColor:  (UIColor *) progressBarColor
                     cornerRadius:  (CGFloat) cornerRadius;

-   (instancetype)  initWithFrame:  (CGRect) frame
                       totalValue:  (CGFloat) totalValue
                     currentValue:  (CGFloat) currentValue
                    progressColor:  (UIColor *) progressColor
                 progressBarColor:  (UIColor *) progressBarColor
                     cornerRadius:  (CGFloat) cornerRadius
                   valueTextColor:  (UIColor *) valueTextColor
                    valueTextFont:  (UIFont *) valueTextFont;

#pragma mark -  执行方法
- (CGFloat) calculateScaleOfProgress;
- (CGFloat) calculateLengthOfProgress;
- (void) updateProgressWithValue: (CGFloat) value;
- (void) updateProgressValueWithTotalValue: (CGFloat) totalValue andCurrentValue: (CGFloat) currentValue;
@end
