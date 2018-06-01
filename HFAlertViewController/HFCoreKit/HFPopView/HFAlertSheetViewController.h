//
//  HFAlertSheetViewController.h
//  HFCoreKit
//
//  Created by HayFi on 2018/3/8.
//  Copyright © 2018年 HayFi. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const HFDefaultAlertCornerRadius;

typedef void(^HFAlertSheetSubmitBlock)(UIButton * sender);
typedef void(^HFAlertSheetCannelBlock)(void);

@interface HFAlertSheetViewController : UIViewController

@property(nonatomic, copy) NSString * titleString;
@property(nonatomic, strong) UIView * centerView;
@property(nonatomic, copy) NSString * itemString;
@property(nonatomic, copy) HFAlertSheetSubmitBlock submitBlock;
@property(nonatomic, copy) HFAlertSheetCannelBlock cannelBlock;
- (void)setAlertSheetCornerRadius:(CGFloat)cornerRadius;
- (void)hfAlertSheetCenterViewDidLoad;
- (void)showInVC:(UIViewController *)vc;
- (void)backViewRelease;
- (void)backViewRemove:(HFAlertSheetCannelBlock)block;
- (void)selfRelease:(HFAlertSheetCannelBlock)block;
- (void)setButtonEnabled:(BOOL)enabled;
- (void)setSureButtonBackgroundColor:(UIColor *)color;

@end
