//
//  PopWindow.h
//  TeamTalk
//
//  Created by SilversRayleigh on 22/7/15.
//  Copyright (c) 2015年 Michael Hu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopWindowDelegate;

@interface PopWindow : UIView

@property (nonatomic, weak) id<PopWindowDelegate>delegate;

+ (id) sharedInstance;

- (void)showPopWindow;

- (void)showPopWindowOnPoint:(CGPoint)showPoint menus:(NSArray *)menus target:(id<PopWindowDelegate>)target;

- (void)showPopWindowOnPoint:(CGPoint)showPoint menus:(NSArray *)menus;

- (void)showPopWindowOnPoint:(CGPoint)showPoint;

- (void)hidePopWindowWithAnimation;

@end

@protocol PopWindowDelegate <NSObject>

- (void) didMenuSelectedWithIndexPath:(NSIndexPath *)indexPath;

@end
