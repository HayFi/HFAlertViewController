//
//  FileHeader.h
//  HFCoreKit
//
//  Created by HayFi on 2017/5/26.
//  Copyright © 2017年 HayFi. All rights reserved.
//

#ifndef FileHeader_h
#define FileHeader_h
//尺寸
#define MAIN_SCREEN_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define MAIN_SCREEN_HEIGHT CGRectGetHeight([UIScreen mainScreen].bounds)

#define iOS_IPHONE4 (MAIN_SCREEN_HEIGHT < 568.0)
#define iOS_IPHONE5S (MAIN_SCREEN_HEIGHT == 568.0)
#define iOS_IPHONE6 (MAIN_SCREEN_HEIGHT == 667.0)
#define iOS_IPHONE6P (MAIN_SCREEN_HEIGHT == 736.0)
#define iOS_IPHONEX (MAIN_SCREEN_HEIGHT == 812.0)
#define iOS_LessThanIPhone6 (MAIN_SCREEN_HEIGHT < 667.0)

#define FONT_SIZE(size) [UIFont systemFontOfSize:size]
#define BOLD_SIZE(size) [UIFont boldSystemFontOfSize:size]

#define WeakObj(obj) @autoreleasepool{} __weak typeof(obj) obj##Weak = obj;

#endif /* FileHeader_h */

