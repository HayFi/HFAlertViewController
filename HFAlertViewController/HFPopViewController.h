//
//  HFPopViewController.h
//  HFAlertViewController
//
//  Created by HayFi on 2018/6/1.
//  Copyright © 2018年 HayFi. All rights reserved.
//

#import "HFAlertSheetViewController.h"

typedef void(^HFPopViewBlock)(void);

@interface HFPopViewController : HFAlertSheetViewController

+ (instancetype)createWithTitle:(NSString *)title block:(HFPopViewBlock)block;

@end
