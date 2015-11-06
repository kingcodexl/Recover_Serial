//
//  MoveViewController.m
//  Recover_Serial
//
//  Created by renhe.cn on 15/11/6.
//  Copyright © 2015年 renhe.cn. All rights reserved.
//

/**
 在iOS中和运动相关的有三个事件:开始运动、结束运动、取消运动。
 
 监听运动事件对于UI控件有个前提就是监听对象必须是第一响应者（对于UIViewController视图控制器和UIAPPlication没有此要求）。这也就意味着如果监听的是一个UI控件那么-(BOOL)canBecomeFirstResponder;方法必须返回YES。同时控件显示时（在-(void)viewWillAppear:(BOOL)animated;事件中）调用视图控制器的becomeFirstResponder方法。当视图不再显示时（在-(void)viewDidDisappear:(BOOL)animated;事件中）注销第一响应者身份。
 
 由于视图控制器默认就可以调用运动开始、运动结束事件在此不再举例。现在不妨假设我们现在在开发一个摇一摇找人的功能，这里我们就自定义一个图片展示控件，在这个图片控件中我们可以通过摇晃随机切换界面图片。代码比较简单：
 */
#import "MoveViewController.h"

@implementation MoveViewController

- (void)viewDidLoad{
    [super viewDidLoad];
}
// 视图显示时让控件为第一响应者
- (void)viewDidAppear:(BOOL)animated{
    _moveView = [[MoveView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.moveView.center = self.view.center;
    [self.moveView becomeFirstResponder];
    
    [self.view addSubview:self.moveView];
}
#pragma mark - 视图不响应时,注销第一响应者身份
- (void)viewDidDisappear:(BOOL)animated{
    [self.moveView resignFirstResponder];
}
@end
