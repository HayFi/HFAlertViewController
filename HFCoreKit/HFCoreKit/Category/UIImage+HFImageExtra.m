//
//  UIImage+HFImageExtra.m
//  HFCoreKit
//
//  Created by HayFi on 2017/8/11.
//  Copyright © 2017年 HayFi. All rights reserved.
//

#import "UIImage+HFImageExtra.h"

@implementation UIImage (HFImageExtra)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
