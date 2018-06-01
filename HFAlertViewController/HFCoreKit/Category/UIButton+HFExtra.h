//
//  UIButton+HFExtra.h
//  HFCoreKit
//
//  Created by HayFi on 2017/8/4.
//  Copyright © 2017年 HayFi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (HFExtra)

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end

@interface UIDevice (HFExtra)

+ (NSString*)hf_getUserDeviceVersion;

@end
