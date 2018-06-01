//
//  UIView+HFExtra.m
//  HFCoreKit
//
//  Created by HayFi on 2017/8/3.
//  Copyright © 2017年 HayFi. All rights reserved.
//

#import "UIView+HFExtra.h"

@implementation UIView (HFExtra)

- (void)setHf_x:(CGFloat)hf_x {
    CGRect frame = self.frame;
    frame.origin.x = hf_x;
    self.frame = frame;
}

- (CGFloat)hf_x {
    return self.frame.origin.x;
}

- (void)setHf_y:(CGFloat)hf_y {
    CGRect frame = self.frame;
    frame.origin.y = hf_y;
    self.frame = frame;
}

- (CGFloat)hf_y
{
    return self.frame.origin.y;
}

- (void)setHf_size:(CGSize)hf_size
{
    CGRect frame = self.frame;
    frame.size = hf_size;
    self.frame = frame;
}

- (CGSize)hf_size
{
    return self.frame.size;
}

- (void)setHf_origin:(CGPoint)hf_origin
{
    CGRect frame = self.frame;
    frame.origin = hf_origin;
    self.frame = frame;
}

- (CGPoint)hf_origin
{
    return self.frame.origin;
}

- (void)setHf_width:(CGFloat)hf_width
{
    CGRect frame = self.frame;
    frame.size.width = hf_width;
    self.frame = frame;
}

- (CGFloat)hf_width
{
    return self.frame.size.width;
}

- (void)setHf_height:(CGFloat)hf_height
{
    CGRect frame = self.frame;
    frame.size.height = hf_height;
    self.frame = frame;
}

- (CGFloat)hf_height
{
    return self.frame.size.height;
}

@end
