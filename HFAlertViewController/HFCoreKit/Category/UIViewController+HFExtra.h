//
//  UIViewController+HFExtra.h
//  HFCoreKit
//
//  Created by HayFi on 2017/8/3.
//  Copyright © 2017年 HayFi. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const hf_defaultPresentViewAlpha;

@interface UIViewController (HFExtra)

- (void)hf_customPresentViewController:(UIViewController *)vc gaussBlurStyle:(UIBlurEffectStyle)style alpha:(CGFloat)alpha action:(SEL)action;

@end
