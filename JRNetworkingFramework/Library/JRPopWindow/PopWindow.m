//
//  PopWindow.m
//  TeamTalk
//
//  Created by SilversRayleigh on 22/7/15.
//  Copyright (c) 2015年 Michael Hu. All rights reserved.
//

#import "PopWindow.h"

#define RGBANDALPHA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define HEIGHT_ROW_TABLEVIEW 44.0
#define NUMBER_SECTION_TABLEVIEW 1
#define NUMBER_ROW_SECTION1_TABLEVIEW 1
#define IDENTIFY_CELL_TABLEVIEW @"cell_pop"

#define DEFAULT_Y_ORIGIN_TABLEVIEW 8
#define DEFAULT_X_ORIGIN_TABLEVIEW 0
#define DEFAULT_ORIGIN_TABLEVIEW CGPointMake(DEFAULT_X_ORIGIN_TABLEVIEW, DEFAULT_Y_ORIGIN_TABLEVIEW)
#define DEFAULT_WIDTH_SIZE_TABLEVIEW 120
#define DEFAULT_HEIGHT_SIZE_TABLEVIEW 0
#define DEFAULT_SIZE_TABLEVIEW CGSizeMake(DEFAULT_WIDTH_SIZE_TABLEVIEW, DEFAULT_HEIGHT_SIZE_TABLEVIEW)
#define DEFAULT_FRAME_TABLEVIEW CGRectMake(DEFAULT_X_ORIGIN_TABLEVIEW, DEFAULT_Y_ORIGIN_TABLEVIEW, DEFAULT_WIDTH_SIZE_TABLEVIEW, DEFAULT_HEIGHT_SIZE_TABLEVIEW)
#define DEFAULT_COLOR_TABLEVIEW RGBANDALPHA(68, 68, 68, 1.0)
#define DEFAULT_COLOR_TEXT_CELL [UIColor whiteColor]
#define DEFAULT_COLOR_FILL CGContextSetRGBFillColor(context, 68/255, 68/255, 68/255, 1)

#define DEFAULT_X_START_ARROW_POP 60
#define DEFAULT_Y_START_ARROW_POP 0
#define DEFAULT_HEIGHT_ARROW_POP 12
#define DEFAULT_HALF_WIDTH_ARROW_POP 10
#define DEFAULT_GAP 10

#define STRING_MENU1 @"默认1"
#define STRING_MENU2 @"默认2"
#define STRING_MENU_ARRAY [NSArray arrayWithObjects:STRING_MENU1, STRING_MENU2, nil]

@interface PopWindow() <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property(nonatomic, assign) BOOL isShown;

@property (nonatomic, strong) UIView *view_pop;
@property (nonatomic, assign) CGPoint point_showPop;
@property (nonatomic, strong) UITableView *tableView_pop;
@property (nonatomic, strong) NSArray *array_menus;

@end

@implementation PopWindow

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - life cycle


#pragma mark - delegate
#pragma mark - UITableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return NUMBER_SECTION_TABLEVIEW;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.array_menus count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HEIGHT_ROW_TABLEVIEW;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFY_CELL_TABLEVIEW];
    if(!cell){
        cell = [[UITableViewCell alloc]init];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = DEFAULT_COLOR_TABLEVIEW;
    
    UILabel *lb_topDivider = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.tableView_pop.frame.size.width - 20, 0.5)];
    lb_topDivider.backgroundColor = RGBANDALPHA(180, 180, 180, 1.0);
    
    UILabel *lb_bottomDivider = [[UILabel alloc]initWithFrame:CGRectMake(10, cell.frame.size.height - 0.5, self.tableView_pop.frame.size.width - 20, 0.5)];
    lb_bottomDivider.backgroundColor = RGBANDALPHA(180, 180, 180, 1.0);
    
    if(indexPath.row != 0)
        [cell addSubview:lb_topDivider];
    if(indexPath.row != [self.array_menus count] - 1)
        [cell addSubview:lb_bottomDivider];
    
    cell.textLabel.text = self.array_menus[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = DEFAULT_COLOR_TEXT_CELL;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.isShown){
        [self.delegate didMenuSelectedWithIndexPath:indexPath];
        [self hidePopWindowWithAnimation];
    }
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

#pragma mark - response(selector)
- (void)onPopViewTouchedUpInside:(id)sender{
    [self hidePopWindowWithAnimation];
}

#pragma mark - customed
+ (id) sharedInstance{
    static PopWindow *instance_popWindow = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance_popWindow = [[self alloc]init];
        instance_popWindow.isShown = NO;
    });
    return instance_popWindow;
}

- (void)initPopView{
    [self setFrame:[UIScreen mainScreen].bounds];
    self.backgroundColor = [UIColor clearColor];
//    self.backgroundColor = [UIColor grayColor];
    
    UITapGestureRecognizer *tapGestureRecognizer_temp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onPopViewTouchedUpInside:)];
    tapGestureRecognizer_temp.delegate = self;
    [self addGestureRecognizer:tapGestureRecognizer_temp];
    
//    self.tableView_pop.backgroundColor = DEFAULT_COLOR_TABLEVIEW;
    self.tableView_pop.dataSource = self;
    self.tableView_pop.delegate = self;
    
    CGFloat x_start = self.point_showPop.x - DEFAULT_WIDTH_SIZE_TABLEVIEW / 2;
    CGFloat y_start = self.point_showPop.y + DEFAULT_HEIGHT_ARROW_POP;
    CGFloat height = [self.array_menus count] * HEIGHT_ROW_TABLEVIEW;
    
    //判断左边出界
    if(x_start <= self.frame.origin.x){
        x_start = self.frame.origin.x;
    }
    //判断右边出界
    if(x_start + DEFAULT_WIDTH_SIZE_TABLEVIEW >= self.frame.size.width){
        x_start = self.frame.size.width - DEFAULT_WIDTH_SIZE_TABLEVIEW;
    }
    //判断下方出界
    if(y_start + self.tableView_pop.frame.size.height >= self.frame.size.height - DEFAULT_GAP - 80){
        y_start = self.frame.size.height - DEFAULT_HEIGHT_ARROW_POP - height - 80 - DEFAULT_GAP;
    }
//    if(self.isDirectionUpward){
////        y_start = self.point_showPop.y - DEFAULT_HEIGHT_ARROW_POP;
//        y_start = self.point_showPop.y - DEFAULT_HEIGHT_ARROW_POP - height - DEFAULT_GAP - 80;
//    }
    [self.tableView_pop setFrame:CGRectMake(x_start, y_start, DEFAULT_WIDTH_SIZE_TABLEVIEW, height)];
//    [self.tableView_pop setUserInteractionEnabled:YES];
    
    [self addSubview:self.tableView_pop];
}

- (void)showPopWindow{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if(!self.isShown){
        self.isShown = YES;
        [self initPopView];
        [window addSubview:self];
        [self setNeedsDisplay];
        [UIView animateWithDuration:0.2f animations:^(void){
            [self.tableView_pop setFrame:CGRectMake(self.tableView_pop.frame.origin.x, self.tableView_pop.frame.origin.y, self.tableView_pop.frame.size.width, [self.array_menus count] * HEIGHT_ROW_TABLEVIEW)];
        }];
    }
}

- (void)showPopWindowOnPoint:(CGPoint)showPoint menus:(NSArray *)menus target:(id<PopWindowDelegate>)target{
    self.delegate = target;
    [self showPopWindowOnPoint:showPoint menus:menus];
}

- (void)showPopWindowOnPoint:(CGPoint)showPoint menus:(NSArray *)menus{
    self.array_menus = menus;
    [self showPopWindowOnPoint:showPoint];
}

- (void)showPopWindowOnPoint:(CGPoint)showPoint{
    self.point_showPop = showPoint;
    [self showPopWindow];
}

- (void)hidePopWindowWithAnimation{
    self.isShown = NO;
    [UIView animateWithDuration:0.2f animations:^(void){
        [self.tableView_pop setFrame:CGRectMake(self.tableView_pop.frame.origin.x, self.tableView_pop.frame.origin.y, self.tableView_pop.frame.size.width, 0)];
    }completion:^(BOOL finished){
        [self.tableView_pop removeFromSuperview];
        [self removeFromSuperview];
    }];
    
}

- (void)drawRect:(CGRect)rect{
    //1.获得图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    
    //2.绘制路径（相当于前面创建路径并添加路径到图形上下文两步操作）
//    CGPoint point_temp = CGPointMake(DEFAULT_X_ORIGIN_TABLEVIEW + (DEFAULT_WIDTH_SIZE_TABLEVIEW / 2), 0);
//    
//    CGContextMoveToPoint(context, DEFAULT_X_ORIGIN_TABLEVIEW + (DEFAULT_WIDTH_SIZE_TABLEVIEW / 2), 0);
//    CGContextAddLineToPoint(context, point_temp.x - 6, point_temp.y + DEFAULT_Y_ORIGIN_TABLEVIEW);
//    CGContextAddLineToPoint(context, point_temp.x + 6, point_temp.y + DEFAULT_Y_ORIGIN_TABLEVIEW);
    
    //箭头起点
    CGFloat x_start = self.point_showPop.x;
    CGFloat y_start = self.point_showPop.y;
    //左边落点
    CGFloat x_left = self.point_showPop.x - DEFAULT_HALF_WIDTH_ARROW_POP;
    CGFloat y_left = self.point_showPop.y + DEFAULT_HEIGHT_ARROW_POP;
    //落点间距
    CGFloat distance = DEFAULT_HALF_WIDTH_ARROW_POP * 2;
    //左边出界
    if(x_start <= DEFAULT_GAP){
        x_start = + DEFAULT_GAP;
        x_left = x_start;
        distance = DEFAULT_HALF_WIDTH_ARROW_POP + DEFAULT_GAP;
    }else if(x_left < self.frame.origin.x + DEFAULT_GAP){
        x_left = DEFAULT_GAP;
        distance = x_start - x_left + DEFAULT_HALF_WIDTH_ARROW_POP;
    }
    //上方出界
    if(y_start <= self.frame.origin.y){
        y_start = self.frame.origin.y;
        y_left = y_start + DEFAULT_HEIGHT_ARROW_POP;
    }
    //右边出界
    if(x_start >= self.frame.size.width - DEFAULT_GAP){
        x_start = self.frame.size.width - DEFAULT_GAP;
        x_left = x_start - DEFAULT_HALF_WIDTH_ARROW_POP - DEFAULT_GAP;
        distance = DEFAULT_HALF_WIDTH_ARROW_POP + DEFAULT_GAP;
    } else if(x_left + distance > self.frame.size.width - DEFAULT_GAP){
        distance = self.frame.size.width - x_left;
    }
    //下方出界
    if(y_start >= self.frame.size.height - DEFAULT_GAP - 80){
        y_start = self.frame.size.height - DEFAULT_GAP - 80;
        y_left = y_start - DEFAULT_HEIGHT_ARROW_POP;
    }
    CGContextMoveToPoint(context, x_start, y_start);
    CGContextAddLineToPoint(context, x_left, y_left);
    CGContextAddLineToPoint(context, x_left + distance, y_left);
//    NSLog(@"%s || start x:%f, start y:%f || left x:%f, left y:%f || right x:%f, right y:%f", __FUNCTION__, x_start, y_start, x_left, y_left, x_start + distance, y_left);
    //封闭路径:a.创建一条起点和终点的线,不推荐
    //CGPathAddLineToPoint(path, nil, 20, 50);
    //封闭路径:b.直接调用路径封闭方法
    CGContextClosePath(context);
    
    //3.设置图形上下文属性
//    [[UIColor redColor]setStroke];//设置红色边框
//    [DEFAULT_COLOR_TABLEVIEW]setFill];//设置绿色填充
    //[[UIColor blueColor]set];//同时设置填充和边框色
    DEFAULT_COLOR_FILL;
    
    //4.绘制路径
    CGContextDrawPath(context, kCGPathFillStroke);
    
    self.point_showPop = CGPointMake(x_start, y_start);
}

#pragma mark - getter/setter
- (UITableView *)tableView_pop{
    if(_tableView_pop == nil){
        _tableView_pop = [[UITableView alloc]initWithFrame:DEFAULT_FRAME_TABLEVIEW style:UITableViewStylePlain];
//        [_tableView_pop setBackgroundColor:DEFAULT_COLOR_TABLEVIEW];
        _tableView_pop.layer.cornerRadius = 6.0;
        _tableView_pop.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView_pop setScrollEnabled:NO];
//        [_tableView_pop setUserInteractionEnabled:YES];
    }
    return _tableView_pop;
}

- (NSArray *)array_menus{
    if(_array_menus == nil){
        _array_menus = STRING_MENU_ARRAY;
    }
    return _array_menus;
}

@end
