//
//  JZProgressBar.m
//  JRNetworkingFramework
//
//  Created by Jason.Chengzi on 16/01/12.
//  Copyright © 2016年 WeSwift. All rights reserved.
//

#import "JZProgressBar.h"

@interface JZProgressBar()

#pragma mark -  显示控件
@property   (nonatomic, strong) UILabel * valueLabel;   //数值label
@property   (nonatomic, strong) UIView * progressView;  //进度条view
@property   (nonatomic, strong) UIView * progressRollingView;   //进度条进度view

@end

@implementation JZProgressBar

#pragma mark -  初始化方法
-   (instancetype)  initWithFrame:  (CGRect) frame
                       totalValue:  (CGFloat) totalValue
                     currentValue:  (CGFloat) currentValue {
    return [self initWithFrame:frame totalValue:totalValue currentValue:currentValue progressColor:nil progressBarColor:nil cornerRadius:0 valueTextColor:nil valueTextFont:nil];
}

-   (instancetype)  initWithFrame:  (CGRect) frame
                       totalValue:  (CGFloat) totalValue
                     currentValue:  (CGFloat) currentValue
                   valueTextColor:  (UIColor *) valueTextColor
                    valueTextFont:  (UIFont *) valueTextFont {
    return [self initWithFrame:frame totalValue:totalValue currentValue:currentValue progressColor:nil progressBarColor:nil cornerRadius:0 valueTextColor:valueTextColor valueTextFont:valueTextFont];
}

-   (instancetype)  initWithFrame:  (CGRect) frame
                       totalValue:  (CGFloat) totalValue
                     currentValue:  (CGFloat) currentValue
                    progressColor:  (UIColor *) progressColor
                 progressBarColor:  (UIColor *) progressBarColor
                     cornerRadius:  (CGFloat) cornerRadius {
    return [self initWithFrame:frame totalValue:totalValue currentValue:currentValue progressColor:progressColor progressBarColor:progressBarColor cornerRadius:cornerRadius valueTextColor:nil valueTextFont:nil];
}

-   (instancetype)  initWithFrame:  (CGRect) frame
                       totalValue:  (CGFloat) totalValue
                     currentValue:  (CGFloat) currentValue
                    progressColor:  (UIColor *) progressColor
                 progressBarColor:  (UIColor *) progressBarColor
                     cornerRadius:  (CGFloat) cornerRadius
                   valueTextColor:  (UIColor *) valueTextColor
                    valueTextFont:  (UIFont *) valueTextFont {
    self = [super initWithFrame:frame];
    if (self) {
        self.totalValue = totalValue;
        self.currentValue = currentValue;
        self.progressColor = progressColor;
        self.progressBarColor = progressBarColor;
        self.valueTextColor = valueTextColor;
        self.valueTextFont = valueTextFont;
        self.cornerRadius = cornerRadius;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupProgressBarConstraints];
    }
    return self;
}

#pragma mark -  设置方法
- (void) setupProgressBarConstraints {
    self.progressView.frame = self.bounds;
    self.valueLabel.frame = self.progressView.bounds;
}

#pragma mark -  执行方法
- (CGFloat) calculateScaleOfProgress {
    return [self calculateScaleOfProgressViewWithValue:self.currentValue totalValue:self.totalValue];
}
- (CGFloat) calculateScaleOfProgressViewWithValue: (CGFloat)currentValue totalValue: (CGFloat)totalValue {
    if (totalValue != 0) {
        return (currentValue / totalValue);
    } else {
        return 0;
    }
}
- (CGFloat) calculateLengthOfProgress {
        return [self calculateLengthOfProgressViewWithValue:self.progressView.frame.size.width andScale:[self calculateScaleOfProgress]];
}
- (CGFloat) calculateLengthOfProgressViewWithValue: (CGFloat) totalValue andScale: (CGFloat) scale {
    return (totalValue * scale);
}
- (void) updateProgressWithValue: (CGFloat) value {
    if (value != self.currentValue) {
        self.currentValue = value;
        [self updateProgressValueWithTotalValue:self.totalValue andCurrentValue:self.currentValue];
        CGFloat lengthOfProgress = [self calculateLengthOfProgress];
        if (self.isShowProgressWithAnimated) {
            if (self.progressRollingView.frame.size.height <= 0) {
                self.progressRollingView.frame = CGRectMake(self.progressRollingView.frame.origin.x, self.progressRollingView.frame.origin.y, self.progressRollingView.frame.size.width, self.progressView.frame.size.height);
            }
            if (self.progressRollingView.frame.size.width > self.progressView.frame.size.width) {
                self.progressRollingView.frame = CGRectMake(self.progressRollingView.frame.origin.x, self.progressRollingView.frame.origin.y, self.progressView.frame.size.width, self.progressView.frame.size.height);
            }
            if (self.progressRollingView.frame.origin.x < 0 ) {
                self.progressRollingView.frame = CGRectMake(0, self.progressRollingView.frame.origin.y, self.progressRollingView.frame.size.width, self.progressView.frame.size.height);
            } else if (self.progressRollingView.frame.origin.y < 0) {
                self.progressRollingView.frame = CGRectMake(self.progressRollingView.frame.origin.x, 0, self.progressRollingView.frame.size.width, self.progressView.frame.size.height);
            }
            [UIView animateWithDuration:0.3f animations:^() {
                self.progressRollingView.frame = CGRectMake(self.progressRollingView.frame.origin.x, self.progressRollingView.frame.origin.y, lengthOfProgress, self.progressView.frame.size.height);
            }];
        } else {
            self.progressRollingView.frame = CGRectMake(self.progressRollingView.frame.origin.x, self.progressRollingView.frame.origin.y, lengthOfProgress, self.progressView.frame.size.height);
        }

    }
}
- (void) updateProgressValueWithTotalValue: (CGFloat) totalValue andCurrentValue: (CGFloat) currentValue {
    self.valueLabel.text = [NSString stringWithFormat:@"%.0f / %.0f", currentValue, totalValue];
}

#pragma mark -  相应方法
- (void) didTapGestureActived: (UITapGestureRecognizer *)gesture {
    CGPoint location = [gesture locationInView:self.progressView];
    CGFloat scale = [self calculateScaleOfProgressViewWithValue:location.x totalValue:self.progressView.frame.size.width];
    [self updateProgressWithValue: [self calculateLengthOfProgressViewWithValue:self.totalValue andScale:scale]];
}
- (void) didPanGestureActived: (UIPanGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:self.progressView];
        CGFloat scale = [self calculateScaleOfProgressViewWithValue:(translation.x + self.progressRollingView.frame.size.width) totalValue:self.progressView.frame.size.width];
        CGFloat lengthOfProgress = [self calculateLengthOfProgressViewWithValue:self.totalValue andScale:scale];
        if (scale <= 1 && scale >= 0) {
            [self updateProgressWithValue: lengthOfProgress];
        }
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        
    }
}

#pragma mark -  Getter
#pragma mark    判断内容
//是否显示在进度条上的数值，默认显示
- (BOOL) isShowValue {
    if (!_isShowValue) {
        _isShowValue = YES;
    }
    return _isShowValue;
}
//是否动画方式显示，默认不显示
- (BOOL) isShowProgressWithAnimated {
    if (!_isShowProgressWithAnimated) {
        _isShowProgressWithAnimated = NO;
    }
    return _isShowProgressWithAnimated;
}

#pragma mark    显示内容（不建议直接操作）
//圆角数值（不建议直接操作）
- (CGFloat) cornerRadius {
    if (!_cornerRadius) {
        _cornerRadius = 0;
    }
    return _cornerRadius;
}
//进度条总数（不建议直接操作）
- (CGFloat) totalValue {
    if (!_totalValue) {
        _totalValue = 100;
    }
    return _totalValue;
}
//当前读数（不建议直接操作）
- (CGFloat) currentValue {
    if (!_currentValue) {
        _currentValue = 0;
    }
    return _currentValue;
}
//进度条进度的显示颜色（不建议直接操作）
- (UIColor *) progressColor {
    if (!_progressColor) {
        _progressColor = [UIColor blackColor];
    }
    return _progressColor;
}
//进度条的背景颜色
- (UIColor *) progressBarColor {
    if (!_progressBarColor) {
        _progressBarColor = [UIColor lightGrayColor];
    }
    return _progressBarColor;
}
//进度条文字颜色
- (UIColor *) valueTextColor {
    if (!_valueTextColor) {
        _valueTextColor = [UIColor whiteColor];
    }
    return _valueTextColor;
}
//进度条文字字体
- (UIFont *) valueTextFont {
    if (!_valueTextFont) {
        _valueTextFont = [UIFont systemFontOfSize:14.0];
    }
    return _valueTextFont;
}
#pragma mark -  显示控件
//数值label
- (UILabel *) valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc]init];
        
        _valueLabel.textAlignment = NSTextAlignmentCenter;
        _valueLabel.textColor = self.valueTextColor;
        _valueLabel.font = self.valueTextFont;
        _valueLabel.backgroundColor = [UIColor clearColor];
        
        _valueLabel.userInteractionEnabled = NO;
        
        [self.progressView addSubview:_valueLabel];
    }
    return _valueLabel;
}
//进度条进度view
- (UIView *) progressRollingView {
    if (!_progressRollingView) {
        _progressRollingView = [[UIView alloc]init];
        
        _progressRollingView.frame = CGRectMake(0, 0, 0, self.progressView.frame.size.height);
        
        _progressRollingView.backgroundColor = self.progressColor;
        _progressRollingView.layer.cornerRadius = self.cornerRadius;
        _progressRollingView.layer.masksToBounds = YES;
        
        _progressRollingView.userInteractionEnabled = NO;
        
        [self.progressView insertSubview:_progressRollingView belowSubview:self.valueLabel];
    }
    return _progressRollingView;
}
//进度条view
- (UIView *) progressView {
    if (!_progressView) {
        _progressView = [[UIView alloc]init];
        
        _progressView.backgroundColor = self.progressBarColor;
        _progressView.layer.cornerRadius = self.cornerRadius;
        _progressView.layer.masksToBounds = YES;
        
        _progressView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapGestureActived:)];
        [_progressView addGestureRecognizer:tapGesture];
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didPanGestureActived:)];
        [_progressView addGestureRecognizer:panGesture];
        
        [self addSubview:_progressView];
    }
    return _progressView;
}
@end
