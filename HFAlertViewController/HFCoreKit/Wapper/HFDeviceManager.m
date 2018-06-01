//
//  HFDeviceManager.m
//  HFCoreKit
//
//  Created by HayFi on 2018/6/1.
//  Copyright © 2018年 HayFi. All rights reserved.
//

#import "HFDeviceManager.h"

@implementation HFDeviceManager

+ (instancetype)sharedInstance {
    static HFDeviceManager * manager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        manager = [[HFDeviceManager alloc] init];
    });
    return manager;
}

- (CGFloat)screenBottomPadding {
    if (!_screenBottomPadding) {
        _screenBottomPadding = [HFDeviceManager sharedInstance].isFullScreenDevice ? 20 : 0;
    }
    return _screenBottomPadding;
}


@end
