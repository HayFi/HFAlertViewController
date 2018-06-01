//
//  HFPopViewController.m
//  HFAlertViewController
//
//  Created by HayFi on 2018/6/1.
//  Copyright © 2018年 HayFi. All rights reserved.
//

#import "HFPopViewController.h"

@interface HFPopViewController ()

@property(nonatomic, copy) HFPopViewBlock choiceBlock;

@end

@implementation HFPopViewController

+ (instancetype)createWithTitle:(NSString *)title block:(HFPopViewBlock)block {
    HFPopViewController * vc = [[HFPopViewController alloc] init];
    vc.titleString = title;
    vc.choiceBlock = block;
    return vc;
}

- (void)hfAlertSheetCenterViewDidLoad {
    [super hfAlertSheetCenterViewDidLoad];
    UILabel * label = [[UILabel alloc] initWithFrame:self.centerView.bounds];
    [self.centerView addSubview:label];
    label.text = @"thanks to use HFCoreKit";
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    WeakObj(self)
    self.submitBlock = ^(UIButton *sender) {
        [selfWeak processSure:sender];
    };
}

- (void)processSure:(UIButton *)sender {
    WeakObj(self)
    [self backViewRemove:^{
        selfWeak.choiceBlock();
    }];
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
