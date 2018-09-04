//
//  HFAlertViewController.h
//  HFCoreKit
//
//  Created by HayFi on 2018/3/10.
//  Copyright © 2018年 HayFi. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DefaultAlertTitle @"提示"
#define DetailAlertTitle @"温馨提示"

typedef enum : NSUInteger {
    HFTypographicStyleDefault = 0,//like UIAlertView
    HFTypographicStyleVertical,
    HFTypographicStyleHorizontal,
} HFTypographicStyle;

typedef enum : NSUInteger {
    HFAlertViewActionStyleDefault = 0,
    HFAlertViewActionStyleCancel,
} HFAlertViewActionStyle;

@class HFAlertViewAction;

typedef void(^HFAlertViewActionBlock)(HFAlertViewAction * _Nonnull action);
typedef void(^HFAlertCannelBlock)(void);
typedef void(^HFAlertSureCountBlock)(NSInteger index);
typedef void(^HFAlertTextFieldHandler)(UITextField * _Nonnull textField);


@interface HFAlertViewAction : NSObject

+ (instancetype _Nonnull)actionWithTitle:(NSString *_Nullable)title style:(HFAlertViewActionStyle)style handler:(HFAlertViewActionBlock _Nullable)handler;
@property(nonatomic, copy, readonly) NSString * _Nullable title;
@property(nonatomic, copy, readonly) HFAlertViewActionBlock _Nullable handler;
@property(nonatomic, assign, readonly) HFAlertViewActionStyle style;
@property(nonatomic, strong) UIColor * _Nullable tintColor;
@property(nonatomic, strong) UIColor * _Nullable backgroundColor;
@property(nonatomic, assign) BOOL enabled;

@end

@interface HFAlertViewController : UIViewController

+ (instancetype _Nonnull)alertWithTitle:(NSString *_Nullable)title message:(NSString *_Nullable)message typographicStyle:(HFTypographicStyle)typographicStyle actions:(NSArray<HFAlertViewAction *> *_Nonnull)actions;
@property(nonatomic, assign) BOOL customSureWhenTextFieldEndEditing;
@property (nonatomic, nullable, readonly) NSArray<HFAlertViewAction *> * actions;

- (void)addTextFieldWithConfigurationHandler:(void (^ __nullable)(UITextField * _Nonnull textField))configurationHandler;
@property (nonatomic, nullable, readonly) NSArray<UITextField *> *textFields;

@property(nonatomic, assign) BOOL canNotRemoveToTouchEmpty;
- (void)showInVC:(UIViewController *_Nonnull)vc;
- (void)backViewRelease:(HFAlertCannelBlock)cannel;

@end



@interface HFAlertViewController (HFExtra)

+ (void)hfAlertControllerWithVC:(UIViewController *_Nonnull)vc typographicStyle:(HFTypographicStyle)typographicStyle title:(NSString *_Nullable)title message:(NSString *_Nullable)message cannelTitle:(NSString *_Nullable)cannelTitle defaultTitles:(NSArray<NSString *> *_Nullable)defaultTitles sureTintColor:(UIColor *_Nullable)sureTintColor cannelTintColor:(UIColor *_Nullable)cannelTintColor sureBlock:(HFAlertSureCountBlock _Nullable)sureBlock cannelBlock:(HFAlertCannelBlock _Nullable)cannelBlock;

+ (void)hfAlertControllerSystemAlertTypeWithVC:(UIViewController *_Nonnull)vc typographicStyle:(HFTypographicStyle)typographicStyle title:(NSString *_Nullable)title message:(NSString *_Nullable)message cannelTitle:(NSString *_Nullable)cannelTitle defaultTitles:(NSArray<NSString *> *_Nullable)defaultTitles sureTintColor:(UIColor *_Nullable)sureTintColor cannelTintColor:(UIColor *_Nullable)cannelTintColor sureBlock:(HFAlertSureCountBlock _Nullable)sureBlock cannelBlock:(HFAlertCannelBlock _Nullable)cannelBlock;

+ (void)hfAlertControllerTextFieldTypeWithVC:(UIViewController *_Nonnull)vc title:(NSString *_Nullable)title message:(NSString *_Nullable)message cannelTitle:(NSString *_Nullable)cannelTitle sureTitle:(NSString *_Nullable)sureTitle sureTintColor:(UIColor *_Nullable)sureTintColor cannelTintColor:(UIColor *_Nullable)cannelTintColor textFieldHandler:(HFAlertTextFieldHandler _Nonnull)textFieldHandler sureBlock:(HFAlertSureCountBlock _Nullable)sureBlock cannelBlock:(HFAlertCannelBlock _Nullable)cannelBlock;

@end
