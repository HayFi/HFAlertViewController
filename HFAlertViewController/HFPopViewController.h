//
//  HFPopViewController.h
//  HFAlertViewController
//
//  Created by netmon on 2018/6/1.
//  Copyright © 2018年 HayFi. All rights reserved.
//

#import <HFCoreKit/HFCoreKit.h>

typedef void(^HFPopViewBlock)(void);

@interface HFPopViewController : HFAlertSheetViewController

+ (instancetype)createWithTitle:(NSString *)title block:(HFPopViewBlock)block;

@end
