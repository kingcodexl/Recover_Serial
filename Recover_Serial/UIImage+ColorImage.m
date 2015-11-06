


//
//  UIImage+ColorImage.m
//  Recover_Serial
//
//  Created by renhe.cn on 15/11/6.
//  Copyright © 2015年 renhe.cn. All rights reserved.
//

#import "UIImage+ColorImage.h"
#import "UIColor+Random.h"
@implementation UIImage (ColorImage)

+ (UIImage *)getRandoColorImageWithFrame:(CGRect)frame{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
