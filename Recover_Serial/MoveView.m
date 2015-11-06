//
//  MoveView.m
//  Recover_Serial
//
//  Created by renhe.cn on 15/11/6.
//  Copyright © 2015年 renhe.cn. All rights reserved.
//

#import "MoveView.h"
#import "UIColor+Random.h"
@implementation MoveView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor randomColor];
    }
    return self;
}

#pragma mark - 设置空间可以成为第一相应者
- (BOOL)canBecomeFirstResponder{
    return YES;
}

#pragma mark - 运动开始
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (motion == UIEventSubtypeMotionShake) {
        self.backgroundColor = [UIColor randomColor];
    }
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
}

@end
