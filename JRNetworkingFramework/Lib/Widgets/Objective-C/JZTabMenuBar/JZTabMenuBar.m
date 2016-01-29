//
//  JZTabMenuBar.m
//  JRNetworkingFramework
//
//  Created by Jason.Chengzi on 16/01/14.
//  Copyright © 2016年 WeSwift. All rights reserved.
//

#import "JZTabMenuBar.h"

@interface JZTabMenuBar()

#pragma mark    显示控件
@property   (nonatomic, strong) UILabel * identifierLabel;
@property   (nonatomic, strong) NSArray * menuButtonArray;
#pragma mark    显示数据

@end

@implementation JZTabMenuBar

#pragma mark    初始化方法
- (instancetype) initWithFrame: (CGRect)frame andMenuButtons: (NSArray *)menuButtons {
    return [self initWithFrame:frame andMenuButtons:menuButtons andFont:[UIFont systemFontOfSize:14] andSelectedColor:[UIColor blackColor] andUnselectedColor:[UIColor lightGrayColor]];
}
- (instancetype) initWithFrame: (CGRect)frame andMenuButtons: (NSArray *)menuButtons andFont: (UIFont *)font andSelectedColor: (UIColor *)selectedColor andUnselectedColor: (UIColor *)unselectedColor {
    self = [super initWithFrame:frame];
    if (self) {
        self.menuButtonArray = menuButtons;
        self.menuButtonFont = font;
        self.menuButtonSelectedColor = selectedColor;
        self.menuButtonUnselectedColor = unselectedColor;
        self.menuButtonIdentifierStickColor = selectedColor;
        
        [self changeSelectedIndex:0];
    }
    return self;
}

#pragma mark    操作方法
- (void) reloadTabMenuBar {
    if (self.menuButtonArray && self.menuButtonArray.count > 0) {
        for (UIButton * tempButton in self.menuButtonArray) {
            [tempButton removeFromSuperview];
        }
        
        
    }
}
- (void) changeSelectedIndex: (NSInteger) selectedIndexToChange {
    if (self.selectedIndex != selectedIndexToChange) {
        
    }
}
- (void) changeSelectedWithTransition: (CGFloat) transition {
    
}
- (void) changeSelectedWithPercentage: (CGFloat) percentage {
    
}

#pragma mark    响应方法
- (void) didMenuButtonTouched: (UIButton *) sender {
    
}

#pragma mark    Getter
#pragma mark    显示控件
- (UILabel *) identifierLabel {
    if (!_identifierLabel) {
        _identifierLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        
        [_identifierLabel setUserInteractionEnabled:NO];
        
        _identifierLabel.backgroundColor = self.menuButtonIdentifierStickColor;
    }
    return _identifierLabel;
}
- (NSArray *) menuButtonArray {
    if (!_menuButtonArray) {
        _menuButtonArray = [[NSArray alloc] init];
    }
    return _menuButtonArray;
}
- (UIScrollView *) menuScrollView {
    if (!_menuScrollView) {
        _menuScrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        
        _menuScrollView.backgroundColor = [UIColor clearColor];
        
        _menuScrollView.scrollsToTop = NO;
        
        if (!self.delegate) {
            _menuScrollView.delegate = self.delegate;
        }
    }
    return _menuScrollView;
}

#pragma mark    显示数据
//按钮字体
- (UIFont *) menuButtonFont {
    if (!_menuButtonFont) {
        _menuButtonFont = [UIFont systemFontOfSize:14];
    }
    return _menuButtonFont;
}
//按钮选中颜色
- (UIColor *) menuButtonSelectedColor {
    if (!_menuButtonSelectedColor) {
        _menuButtonSelectedColor = [UIColor blackColor];
    }
    return _menuButtonSelectedColor;
}
//按钮未被选中颜色
- (UIColor *) menuButtonUnselectedColor {
    if (!_menuButtonUnselectedColor) {
        _menuButtonUnselectedColor = [UIColor lightGrayColor];
    }
    return _menuButtonUnselectedColor;
}
//标记的颜色
- (UIColor *) menuButtonIdentifierStickColor {
    if (!_menuButtonIdentifierStickColor) {
        _menuButtonIdentifierStickColor = self.menuButtonSelectedColor;
    }
    return _menuButtonIdentifierStickColor;
}

//标记的宽度是否和按钮相等，默认否
- (BOOL) isStickWithEqualToMenuButton {
    if (!_isStickWithEqualToMenuButton) {
        _isStickWithEqualToMenuButton = NO;
    }
    return _isStickWithEqualToMenuButton;
}
//按钮是否等宽，默认是
- (BOOL) isMenuButtonEqualWidth {
    if (!_isMenuButtonEqualWidth) {
        _isMenuButtonEqualWidth = YES;
    }
    return _isMenuButtonEqualWidth;
}
//按钮的数量
- (NSInteger) totalNumberOfMenuButtons {
    if (self.menuButtonArray != nil) {
        return self.menuButtonArray.count;
    } else {
        return 0;
    }
}

@end
