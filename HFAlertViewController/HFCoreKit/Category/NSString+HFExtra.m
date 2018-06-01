//
//  NSString+HFExtra.m
//  HFCoreKit
//
//  Created by HayFi on 2017/8/3.
//  Copyright © 2017年 HayFi. All rights reserved.
//

#import "NSString+HFExtra.h"

@implementation NSString (HFExtra)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    CGSize size = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil].size;
    return size;
}

@end
