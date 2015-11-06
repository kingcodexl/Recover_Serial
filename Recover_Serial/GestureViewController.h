//
//  GestureViewController.h
//  Recover_Serial
//
//  Created by renhe.cn on 15/11/6.
//  Copyright © 2015年 renhe.cn. All rights reserved.
//  手势识别,对触摸事件进行封装
/**
 使用手势
 
 在iOS中添加手势比较简单，可以归纳为以下几个步骤：
 
 创建对应的手势对象；
 设置手势识别属性【可选】；
 附加手势到指定的对象；
 编写手势操作方法；
 为了帮助大家理解，下面以一个图片查看程序演示一下上面几种手势，在这个程序中我们完成以下功能：
 
 如果点按图片会在导航栏显示图片名称；
 
 如果长按图片会显示删除按钮，提示用户是否删除；
 
 如果捏合会放大、缩小图片；
 
 如果轻扫会切换到下一张或上一张图片；
 
 如果旋转会旋转图片；
 
 如果拖动会移动图片；
 
 具体布局草图如下：
 */
#import <UIKit/UIKit.h>

@interface GestureViewController : UIViewController

@end
