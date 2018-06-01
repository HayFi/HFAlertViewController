//
//  UIColor+HFExtra.m
//  HFCoreKit
//
//  Created by HayFi on 2017/8/3.
//  Copyright © 2017年 HayFi. All rights reserved.
//

#import "UIColor+HFExtra.h"

@implementation UIColor (HFExtra)

+ (UIColor *)colorWithR:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue a:(CGFloat)alpha {
    return [UIColor colorWithRed:(red / 255.0) green:(green / 255.0) blue:(blue / 255.0) alpha:alpha];
}

+ (UIColor *)hfLineGrayColor {
    return [UIColor colorWithR:222 g:222 b:222 a:1];
}

+ (UIColor *)highlightGrayColor {
    return [UIColor colorWithR:237 g:237 b:237 a:1];
}


@end
