//
//  RemoteControlViewController.m
//  Recover_Serial
//
//  Created by renhe.cn on 15/11/6.
//  Copyright © 2015年 renhe.cn. All rights reserved.
//

#import "RemoteControlViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface RemoteControlViewController ()
@property (nonatomic, strong) AVPlayer *player;   /**<<#注释#> */
@property (nonatomic, assign) BOOL *isPlaying;   /**<<#注释#> */
@end

@implementation RemoteControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _player = [[AVPlayer alloc]initWithURL:nil];
    // Do any additional setup after loading the view.
}
- (BOOL)canBecomeFirstResponder{
    return NO;
}

- (void)configSubView{
    
}
#pragma mark - 远程控制事件
- (void)remoteControlReceivedWithEvent:(UIEvent *)event{
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPlay:
                [_player play];
                _isPlaying=true;
                break;
            case UIEventSubtypeRemoteControlTogglePlayPause:
                if (_isPlaying) {
                    [_player pause];
                }else{
                    [_player play];
                }
                _isPlaying=!_isPlaying;
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                NSLog(@"Next...");
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                NSLog(@"Previous...");
                break;
            case UIEventSubtypeRemoteControlBeginSeekingForward:
                NSLog(@"Begin seek forward...");
                break;
            case UIEventSubtypeRemoteControlEndSeekingForward:
                NSLog(@"End seek forward...");
                break;
            case UIEventSubtypeRemoteControlBeginSeekingBackward:
                NSLog(@"Begin seek backward...");
                break;
            case UIEventSubtypeRemoteControlEndSeekingBackward:
                NSLog(@"End seek backward...");
                break;
            default:
                break;
        }
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
/**
 远程控制，远程控制事件这里主要说的就是耳机线控操作。在前面的事件列表中，大家可以看到在iOS中和远程控制事件有关的只有一个- (void)remoteControlReceivedWithEvent:(UIEvent *)event NS_AVAILABLE_IOS(4_0);事件。要监听到这个事件有三个前提（视图控制器UIViewController或应用程序UIApplication只有两个）
 
 启用远程事件接收（使用[[UIApplication sharedApplication] beginReceivingRemoteControlEvents];方法）。
 对于UI控件同样要求必须是第一响应者（对于视图控制器UIViewController或者应用程序UIApplication对象监听无此要求）。
 应用程序必须是当前音频的控制者，也就是在iOS 7中通知栏中当前音频播放程序必须是我们自己开发程序。
 基于第三点我们必须明确，如果我们的程序不想要控制音频，只是想利用远程控制事件做其他的事情，例如模仿iOS7中的按音量+键拍照是做不到的，目前iOS7给我们的远程控制权限还仅限于音频控制（当然假设我们确实想要做一个和播放音频无关的应用但是又想进行远程控制，也可以隐藏一个音频播放操作，拿到远程控制操作权后进行远程控制）。
 
 运动事件中我们也提到一个枚举类型UIEventSubtype，而且我们利用它来判断是否运动事件，在枚举中还包含了我们运程控制的子事件类型，我们先来熟悉一下这个枚举（从远程控制子事件类型也不难发现它和音频播放有密切关系）：
 
 typedef NS_ENUM(NSInteger, UIEventSubtype) {
 // 不包含任何子事件类型
 UIEventSubtypeNone                              = 0,
 
 // 摇晃事件（从iOS3.0开始支持此事件）
 UIEventSubtypeMotionShake                       = 1,
 
 //远程控制子事件类型（从iOS4.0开始支持远程控制事件）
 //播放事件【操作：停止状态下，按耳机线控中间按钮一下】
 UIEventSubtypeRemoteControlPlay                 = 100,
 //暂停事件
 UIEventSubtypeRemoteControlPause                = 101,
 //停止事件
 UIEventSubtypeRemoteControlStop                 = 102,
 //播放或暂停切换【操作：播放或暂停状态下，按耳机线控中间按钮一下】
 UIEventSubtypeRemoteControlTogglePlayPause      = 103,
 //下一曲【操作：按耳机线控中间按钮两下】
 UIEventSubtypeRemoteControlNextTrack            = 104,
 //上一曲【操作：按耳机线控中间按钮三下】
 UIEventSubtypeRemoteControlPreviousTrack        = 105,
 //快退开始【操作：按耳机线控中间按钮三下不要松开】
 UIEventSubtypeRemoteControlBeginSeekingBackward = 106,
 //快退停止【操作：按耳机线控中间按钮三下到了快退的位置松开】
 UIEventSubtypeRemoteControlEndSeekingBackward   = 107,
 //快进开始【操作：按耳机线控中间按钮两下不要松开】
 UIEventSubtypeRemoteControlBeginSeekingForward  = 108,
 //快进停止【操作：按耳机线控中间按钮两下到了快进的位置松开】
 UIEventSubtypeRemoteControlEndSeekingForward    = 109,
 };

 */


@end
