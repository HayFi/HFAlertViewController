//
//  UIButton+HFExtra.m
//  HFCoreKit
//
//  Created by HayFi on 2017/8/4.
//  Copyright © 2017年 HayFi. All rights reserved.
//

#import "UIButton+HFExtra.h"

@implementation UIButton (HFExtra)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIImage imageWithColor:backgroundColor] forState:state];
}

@end

@implementation UIImage (HFExtra)

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


@implementation NSString (HFExtra)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    CGSize size = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil].size;
    return size;
}

@end

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
