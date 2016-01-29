//
//  JZTabMenuBar.h
//  JRNetworkingFramework
//
//  Created by Jason.Chengzi on 16/01/14.
//  Copyright © 2016年 WeSwift. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JZTabMenuBar : UIView

#pragma mark    显示控件
@property   (nonatomic, strong) UIScrollView * menuScrollView;  //

#pragma mark    显示数据
@property   (nonatomic, strong) UIFont * menuButtonFont;    //按钮字体
@property   (nonatomic, strong) UIColor * menuButtonSelectedColor;  //按钮选中颜色
@property   (nonatomic, strong) UIColor * menuButtonUnselectedColor;    //按钮未被选中颜色
@property   (nonatomic, strong) UIColor * menuButtonIdentifierStickColor;   //标记的颜色

@property   (nonatomic, assign) BOOL isStickWithEqualToMenuButton;  //标记的宽度是否和按钮相等，默认否
@property   (nonatomic, assign) BOOL isMenuButtonEqualWidth;    //按钮是否等宽，默认是
@property   (nonatomic, assign) NSInteger totalNumberOfMenuButtons; //按钮的数量
@property   (nonatomic, assign) NSInteger selectedIndex;    //当前选中的标记

#pragma mark    代理对象
@property   (nonatomic, weak) id<UIScrollViewDelegate> delegate;

#pragma mark    初始化方法
- (instancetype) initWithFrame: (CGRect)frame andMenuButtons: (NSArray *)menuButtons;
- (instancetype) initWithFrame: (CGRect)frame andMenuButtons: (NSArray *)menuButtons andFont: (UIFont *)font andSelectedColor: (UIColor *)selectedColor andUnselectedColor: (UIColor *)unselectedColor;

#pragma mark    操作方法
- (void) reloadTabMenuBar;  //重新加载按钮
- (void) changeSelectedIndex: (NSInteger) selectedIndexToChange;    //用下标来更改当前选中的按钮
- (void) changeSelectedWithTransition: (CGFloat) transition;    //用位移来更改当前选中的按钮
- (void) changeSelectedWithPercentage: (CGFloat) percentage;    //用百分比来更改当前选中的按钮

@end

#pragma mark    协议
@protocol JZTabMenuBarDelegate

@end