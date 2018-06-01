//
//  UIViewController+HFExtra.m
//  HFCoreKit
//
//  Created by HayFi on 2017/8/3.
//  Copyright © 2017年 HayFi. All rights reserved.
//

#import "UIViewController+HFExtra.h"

CGFloat const hf_defaultPresentViewAlpha = 0.46;

@implementation UIViewController (HFExtra)

- (void)hf_customPresentViewController:(UIViewController *)vc gaussBlurStyle:(UIBlurEffectStyle)style alpha:(CGFloat)alpha action:(SEL)action {
    if (style >= 0) {
        UIVisualEffectView * view = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:style]];
        view.frame = vc.view.bounds;
        view.alpha = alpha > 0 ? alpha : hf_defaultPresentViewAlpha;
        [vc.view addSubview:view];
        [vc.view sendSubviewToBack:view];
        if (action) {
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:vc action:action];
            [view addGestureRecognizer:tap];
        }
    } else {
        if (action) {
            UIControl * tap = [[UIControl alloc] initWithFrame:vc.view.bounds];
            [tap addTarget:vc action:action forControlEvents:UIControlEventTouchUpInside];
            [vc.view addSubview:tap];
            [vc.view sendSubviewToBack:tap];
        }
        vc.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:alpha];
    }
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:vc animated:NO completion:nil];
}

@end
