//
//  HFAlertSheetViewController.m
//  HFCoreKit
//
//  Created by HayFi on 2018/3/8.
//  Copyright © 2018年 HayFi. All rights reserved.
//

#import "HFAlertSheetViewController.h"

CGFloat const HFDefaultAlertCornerRadius = 22;
#define BTN_TAG 2100
@interface HFAlertSheetViewController (){
    CGFloat _currentY;
    CGFloat _popY;
}
@property(nonatomic, strong) UIView * bgView;

@end

@implementation HFAlertSheetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUserInterface];
}

- (void)showInVC:(UIViewController *)vc {
//    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
//    [vc presentViewController:self animated:NO completion:nil];
    [vc hf_customPresentViewController:self gaussBlurStyle:UIBlurEffectStyleDark alpha:0.7 action:@selector(processCannel)];
}

- (UIView *)bgView {
    if (!_bgView) {
        CGFloat x = 0;
        if ([HFDeviceManager sharedInstance].deviceIsPad) {
            x = RELATIVE_WIDTH(50);
        } else {
            if ([HFDeviceManager sharedInstance].isFullScreenDevice) {
                x = 0;
            } else {
                x = RELATIVE_WIDTH(10);
            }
        }
        _currentY = MAIN_SCREEN_HEIGHT;
//        CGFloat bgH = 320;
        CGFloat bgH = 320 + ([HFDeviceManager sharedInstance].isFullScreenDevice ? 20 : 0);
        CGFloat pad = [HFDeviceManager sharedInstance].isFullScreenDevice ? 0 : 10;
        _popY = _currentY - bgH - pad;
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(x, _currentY, CGRectGetWidth(self.view.bounds) - x * 2, bgH)];
        _bgView.layer.cornerRadius = HFDefaultAlertCornerRadius;
        _bgView.layer.masksToBounds = YES;
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (void)setAlertSheetCornerRadius:(CGFloat)cornerRadius {
    _bgView.layer.cornerRadius = cornerRadius;
}

- (void)initUserInterface {
    [self.view addSubview:self.bgView];
    
    CGFloat width = CGRectGetWidth(self.bgView.bounds);
    CGFloat height = CGRectGetHeight(self.bgView.bounds);
    CGFloat lbH = 48;
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(lbH, 0, width - lbH * 2, lbH)];
    [self.bgView addSubview:label];
    label.font = FONT_SIZE(15);
    label.text = self.titleString;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithR:102 g:102 b:102 a:1];
    
    UIButton * cannel = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 0, lbH, lbH)];
    [self.bgView addSubview:cannel];
    cannel.titleLabel.font = FONT_SIZE(22);
    [cannel setTitle:@"✕" forState:UIControlStateNormal];
    [cannel setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cannel addTarget:self action:@selector(processCannel) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat bottomH = 58;
//    CGFloat pad = 0;
    CGFloat pad = [HFDeviceManager sharedInstance].isFullScreenDevice ? 10 : 0;
    _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame), width, height - CGRectGetMaxY(label.frame) - bottomH - pad)];
    _centerView.backgroundColor = self.bgView.backgroundColor;
    [self.bgView addSubview:_centerView];
    
    CGFloat x = RELATIVE_WIDTH(30);
    UIButton * item = [[UIButton alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(_centerView.frame) + 10, width - x * 2, 38)];
    [self.bgView addSubview:item];
    item.titleLabel.font = FONT_SIZE(15);
    item.tag = BTN_TAG;
    item.layer.cornerRadius = 8;
    item.layer.masksToBounds = YES;
    [item setTitle:self.itemString.length > 0 ? self.itemString : @"确定" forState:UIControlStateNormal];
    [item setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [item setBackgroundColor:[UIColor colorWithR:49 g:181 b:115 a:1] forState:UIControlStateNormal];
    [item addTarget:self action:@selector(processSure:) forControlEvents:UIControlEventTouchUpInside];
    if ([self respondsToSelector:@selector(hfAlertSheetCenterViewDidLoad)]) {
        [self hfAlertSheetCenterViewDidLoad];
    }
}

- (void)hfAlertSheetCenterViewDidLoad {}

- (void)setButtonEnabled:(BOOL)enabled {
    UIButton * item = [self.bgView viewWithTag:BTN_TAG];
    item.enabled = enabled;
}

- (void)setSureButtonBackgroundColor:(UIColor *)color {
    if (color) {
        UIButton * item = [self.bgView viewWithTag:BTN_TAG];
        [item setBackgroundColor:color forState:UIControlStateNormal];
        [item setBackgroundColor:[color colorWithAlphaComponent:0.75] forState:UIControlStateHighlighted];
    }
}

- (void)processSure:(UIButton *)sender {
    if (self.submitBlock) {
        self.submitBlock(sender);
    }
}

- (void)processCannel {
    if (self.cannelBlock) {
        self.cannelBlock();
    } else {
        [self backViewRelease];
    }
}

- (void)backViewRemove:(HFAlertSheetCannelBlock)block {
    WeakObj(self)
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        selfWeak.bgView.hf_y = self->_currentY;
    } completion:^(BOOL finished) {
        [selfWeak selfRelease:block];
    }];
}

- (void)backViewRelease {
    [self backViewRemove:nil];
}

- (void)selfRelease:(HFAlertSheetCannelBlock)block {
    if (self.bgView) {
        [self.bgView removeFromSuperview];
        self.bgView = nil;
    }
    [self dismissViewControllerAnimated:NO completion:^{
        if (block) {
            block();
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    WeakObj(self)
    //    CGFloat height = MAIN_SCREEN_HEIGHT
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        selfWeak.bgView.hf_y = self->_popY;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
