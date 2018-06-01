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

#import <sys/utsname.h>

@implementation UIDevice (HFExtra)

+ (void)load {
    [UIDevice hf_getUserDeviceVersion];
}

+ (NSString*)hf_getUserDeviceVersion {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //iPhone
//    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
//    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
//    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    NSString * version = deviceString;
    if ([deviceString isEqualToString:@"x86_64"] || [deviceString isEqualToString:@"i386"]) {
        version = @"Simulator";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeSimulator;
        if (iOS_IPHONE4) {
            [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhone4s;
        } else if (iOS_IPHONE5S) {
            [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhone5s;
        } else if (iOS_IPHONE6) {
            [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhone6;
        } else if (iOS_IPHONE6P) {
            [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhone6p;
        } else if (iOS_IPHONEX) {
            [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhoneX;
            [HFDeviceManager sharedInstance].isFullScreenDevice = YES;
        } else {
            [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPad;
            [HFDeviceManager sharedInstance].deviceIsPad = YES;
        }
    }
    
    if ([deviceString isEqualToString:@"iPhone3,1"] || [deviceString isEqualToString:@"iPhone3,2"] || [deviceString isEqualToString:@"iPhone3,3"]) {
        version = @"iPhone 4";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhone4s;
    }
    if ([deviceString isEqualToString:@"iPhone4,1"] || [deviceString isEqualToString:@"iPhone4,2"] || [deviceString isEqualToString:@"iPhone4,3"]) {
        version = @"iPhone 4S";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhone4s;
    }
    if ([deviceString isEqualToString:@"iPhone5,1"] || [deviceString isEqualToString:@"iPhone5,2"]) {
        version = @"iPhone 5";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhone5s;
    }
    if ([deviceString isEqualToString:@"iPhone5,3"] || [deviceString isEqualToString:@"iPhone5,4"]) {
        version = @"iPhone 5C";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhone5s;
    }
    if ([deviceString isEqualToString:@"iPhone6,1"] || [deviceString isEqualToString:@"iPhone6,2"]) {
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhone5s;
        version = @"iPhone 5S";
    }
    if ([deviceString isEqualToString:@"iPhone7,1"]) {
        version = @"iPhone 6 Plus";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhone6p;
    }
    if ([deviceString isEqualToString:@"iPhone7,2"]) {
        version = @"iPhone 6";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhone6;
    }
    if ([deviceString isEqualToString:@"iPhone8,1"]) {
        version = @"iPhone 6s";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhone6;
    }
    if ([deviceString isEqualToString:@"iPhone8,2"]) {
        version = @"iPhone 6s Plus";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhone6p;
    }
    if ([deviceString isEqualToString:@"iPhone8,4"]) {
        version = @"iPhone SE";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhone5s;
    }
    if ([deviceString isEqualToString:@"iPhone9,1"]) {
        version = @"iPhone 7";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhone6;
    }
    if ([deviceString isEqualToString:@"iPhone9,2"]) {
        version = @"iPhone 7 Plus";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhone6p;
    }
    
    if ([deviceString isEqualToString:@"iPhone10,1"] || [deviceString isEqualToString:@"iPhone10,4"]) {
        version = @"iPhone 8";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhone6;
    }
    
    if ([deviceString isEqualToString:@"iPhone10,2"] || [deviceString isEqualToString:@"iPhone10,5"]) {
        version = @"iPhone 8 Plus";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhone6p;
    }
    if ([deviceString isEqualToString:@"iPhone10,3"] || [deviceString isEqualToString:@"iPhone10,6"]) {
        version = @"iPhone X";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhoneX;
        [HFDeviceManager sharedInstance].isFullScreenDevice = YES;
    }
    //iPod
//    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
//    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
//    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
//    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"]) {
        version = @"iPod Touch 5G";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhone5s;
    }
    if ([deviceString isEqualToString:@"iPod7,1"]) {
        version = @"iPod Touch 6G";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPhone5s;
    }
    //iPad
//    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"] || [deviceString isEqualToString:@"iPad2,2"] || [deviceString isEqualToString:@"iPad2,3"] || [deviceString isEqualToString:@"iPad2,4"]) {
        version = @"iPad 2";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPad;
    }
    if ([deviceString isEqualToString:@"iPad2,5"] || [deviceString isEqualToString:@"iPad2,6"] || [deviceString isEqualToString:@"iPad2,7"]) {
        version = @"iPad mini";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPadMini;
    }
    
    if ([deviceString isEqualToString:@"iPad3,1"] || [deviceString isEqualToString:@"iPad3,2"] || [deviceString isEqualToString:@"iPad3,3"]) {
        version = @"iPad 3";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPad;
    }
    if ([deviceString isEqualToString:@"iPad3,4"] || [deviceString isEqualToString:@"iPad3,5"] || [deviceString isEqualToString:@"iPad3,6"]) {
        version = @"iPad 4";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPad;
    }
    
    if ([deviceString isEqualToString:@"iPad4,1"] || [deviceString isEqualToString:@"iPad4,2"] || [deviceString isEqualToString:@"iPad4,3"]) {
        version = @"iPad Air";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPad;
    }
    if ([deviceString isEqualToString:@"iPad5,3"] || [deviceString isEqualToString:@"iPad5,4"]) {
        version = @"iPad Air 2";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPad;
    }
    
    if ([deviceString isEqualToString:@"iPad4,4"] || [deviceString isEqualToString:@"iPad4,5"] || [deviceString isEqualToString:@"iPad4,6"]) {
        version = @"iPad mini 2";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPadMini;
    }
    
    if ([deviceString isEqualToString:@"iPad4,7"] || [deviceString isEqualToString:@"iPad4,8"] || [deviceString isEqualToString:@"iPad4,9"]) {
        version = @"iPad mini 3";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPadMini;
    }
    
    if ([deviceString isEqualToString:@"iPad5,1"] || [deviceString isEqualToString:@"iPad5,2"]) {
        version = @"iPad mini 4";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPadMini;
    }
    
    if ([deviceString isEqualToString:@"iPad6,3"] || [deviceString isEqualToString:@"iPad6,4"] || [deviceString isEqualToString:@"iPad6,7"] || [deviceString isEqualToString:@"iPad6,8"]) {
        version = @"iPad Pro";
        [HFDeviceManager sharedInstance].iOSScreenType = HFiOSScreenTypeLikeiPadPro;
    }
    if (![HFDeviceManager sharedInstance].deviceIsPad) {
        [HFDeviceManager sharedInstance].deviceIsPad = [deviceString hasPrefix:@"iPad"] ? YES : NO;
    }
    
    [HFDeviceManager sharedInstance].iOSDeviceVersion = version;
    return deviceString;
}

@end

