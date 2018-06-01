//
//  HFDeviceManager.h
//  HFCoreKit
//
//  Created by HayFi on 2018/6/1.
//  Copyright © 2018年 HayFi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    HFiOSScreenTypeLikeSimulator = 0,
    HFiOSScreenTypeLikeiPhone4s,// 4~
    HFiOSScreenTypeLikeiPhone5s,
    HFiOSScreenTypeLikeiPhone6,
    HFiOSScreenTypeLikeiPhone6p,
    HFiOSScreenTypeLikeiPhoneX,
    HFiOSScreenTypeLikeiPad,
    HFiOSScreenTypeLikeiPadMini,
    HFiOSScreenTypeLikeiPadPro,
} HFiOSScreenType;

@interface HFDeviceManager : NSObject

+ (instancetype)sharedInstance;

@property(nonatomic, assign) HFiOSScreenType iOSScreenType;

@property(nonatomic, copy) NSString * iOSDeviceVersion;

@property(nonatomic, assign) BOOL isFullScreenDevice;

@property(nonatomic, assign) BOOL deviceIsPad;

@property(nonatomic, assign) CGFloat screenBottomPadding;

@end
