#pragma mark - 类库说明
纯粹无聊做的自适应弹出选择框

#pragma mark - 类库使用
[[PopWindow sharedInstance]showPopWindow]; //默认显示
[[PopWindow sharedInstance]showPopWindowOnPoint:showPoint]; //在屏幕上的showPoint上显示
[[PopWindow sharedInstance]showPopWindowOnPoint:showPoint menus:menusArray]; //自定义显示内容
[[PopWindow sharedInstance]showPopWindowOnPoint:showPoint menus:menusArray target:delegate]; //添加代理回调对象

[[PopWindow sharedInstance]hidePopWindowWithAnimation]; //移除

#pragma mark - 回调使用
添加
<PopWindowDelegate>
并实现
- (void) didMenuSelectedWithIndexPath:(NSIndexPath *)indexPath;
即可。
