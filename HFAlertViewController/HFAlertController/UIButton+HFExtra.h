//
//  UIButton+HFExtra.h
//  HFCoreKit
//
//  Created by HayFi on 2017/8/4.
//  Copyright © 2017年 HayFi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FileHeader.h"

@interface UIButton (HFExtra)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end

@interface UIImage (HFExtra)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end


@interface UIView (HFExtra)

@property (assign, nonatomic) CGFloat hf_x;
@property (assign, nonatomic) CGFloat hf_y;
@property (assign, nonatomic) CGSize  hf_size;
@property (assign, nonatomic) CGPoint hf_origin;
@property (assign, nonatomic) CGFloat hf_width;
@property (assign, nonatomic) CGFloat hf_height;

@end


@interface NSString (HFExtra)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

@end

@interface UIColor (HFExtra)

+ (UIColor *)colorWithR:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue a:(CGFloat)alpha;
+ (UIColor *)hfLineGrayColor;
+ (UIColor *)highlightGrayColor;

@end

