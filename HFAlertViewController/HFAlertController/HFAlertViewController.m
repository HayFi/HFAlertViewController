//
//  HFAlertViewController.m
//  HFCoreKit
//
//  Created by HayFi on 2018/3/10.
//  Copyright © 2018年 HayFi. All rights reserved.
//

#import "HFAlertViewController.h"
#import "UIButton+HFExtra.h"

#define HFItemH 45
#define HF_LINE_H 0.5

@interface HFAlertViewAction()

@property(nonatomic, copy, readwrite) NSString * _Nullable title;
@property(nonatomic, copy, readwrite) HFAlertViewActionBlock _Nullable handler;
@property(nonatomic, assign, readwrite) HFAlertViewActionStyle style;

@end

@implementation HFAlertViewAction

+ (instancetype)actionWithTitle:(NSString *)title style:(HFAlertViewActionStyle)style handler:(HFAlertViewActionBlock)handler {
    HFAlertViewAction * action = [HFAlertViewAction new];
    action.title = title;
    action.style = style;
    action.enabled = YES;
    action.handler = handler;
    return action;
}

@end

@interface HFAlertViewActionCell : UICollectionViewCell

@property(nonatomic, strong) UIButton * item;
@property(nonatomic, strong) UIView * topLine;
@property(nonatomic, strong) UIView * leftLine;

@end

@implementation HFAlertViewActionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _item = [[UIButton alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:_item];
        _item.titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _item.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        [_item setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_item setBackgroundColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        _topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.bounds), HF_LINE_H)];
        [self.contentView addSubview:_topLine];
        _topLine.backgroundColor = [UIColor hfLineGrayColor];
        
        _leftLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, HF_LINE_H, CGRectGetHeight(self.contentView.bounds))];
        [self.contentView addSubview:_leftLine];
        _leftLine.hidden = YES;
        _leftLine.backgroundColor = [UIColor hfLineGrayColor];
    }
    return self;
}

@end

#define contentViewTag -100231
#define bgViewTag -203951

@protocol HFAlertControllerViewDelegate <NSObject>

- (void)hfAlertControllerViewDidAddSubView:(UIView *)subview;

@end

@interface HFAlertControllerView : UIView

@property(nonatomic, assign) id<HFAlertControllerViewDelegate> delegate;

@end

@implementation HFAlertControllerView

- (void)didAddSubview:(UIView *)subview {
    NSLog(@"didAddSubview:%@,%s",subview, __func__);
    if (subview) {
        if ([subview isKindOfClass:[UIVisualEffectView class]] && (subview.tag == contentViewTag || subview.tag == bgViewTag)) {
            [super didAddSubview:subview];
        } else {
            if ([self.subviews containsObject:subview]) {
                for (UIView * v in self.subviews) {
                    if ([v isEqual:subview]) {
                        [v removeFromSuperview];
                        break;
                    }
                }
            }
            if (self.delegate) {
                [self.delegate hfAlertControllerViewDidAddSubView:subview];
            }
        }
    }
}

@end

static NSString * const cellID = @"HFAlertViewActionCellCellID";

@interface HFAlertViewController () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HFAlertControllerViewDelegate>{
    CGSize _itemSize;
}

@property(nonatomic, strong) UIVisualEffectView * contentView;
@property(nonatomic, strong) UIVisualEffectView * cover;
@property(nonatomic, copy) NSString * titleString;
@property(nonatomic, copy) NSString * message;
@property (nonatomic, nullable, readwrite) NSArray<HFAlertViewAction *> * actions;
@property (nonatomic, nullable, readwrite) NSArray<UITextField *> *textFields;
@property(nonatomic, assign) HFTypographicStyle typographicStyle;
@property(nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

@end


#define HFTitleTag 1000
#define HFDetailTag 1001
#define HFCenterViewTag 10000
#define HFLineTag 15090
#define HFCollectionViewTag 25903

#define BTNTAG 100
#define HFAPadding 10
#define HFAPadding1 15
#define HFAPadding2 20
#define HFAPadding3 25
#define HFAPadding4 30
#define HFDefaultItemFont 16.5

@implementation HFAlertViewController

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message typographicStyle:(HFTypographicStyle)typographicStyle actions:(NSArray<HFAlertViewAction *> *)actions {
    HFAlertViewController * vc = [HFAlertViewController new];
    vc.titleString = title;
    vc.message = message;
    vc.actions = [HFAlertViewController createActionSource:actions type:typographicStyle];
    vc.typographicStyle = typographicStyle;
    [vc initUserInterface];
    return vc;
}

+ (NSArray *)createActionSource:(NSArray *)array type:(HFTypographicStyle)type {
    if (array.count > 1) {
        NSMutableArray * sure = [NSMutableArray array];
        NSMutableArray * cannel = [NSMutableArray array];
        for (HFAlertViewAction * action in array) {
            if (action.style == HFAlertViewActionStyleCancel) {
                [cannel addObject:action];
            } else if (action.style == HFAlertViewActionStyleDefault) {
                [sure addObject:action];
            }
        }
        NSMutableArray * arr = [NSMutableArray array];
        if (sure.count == 1 && cannel.count == 1) {
            if (type == HFTypographicStyleVertical) {
                [arr addObjectsFromArray:sure];
                [arr addObjectsFromArray:cannel];
            } else {
                [arr addObjectsFromArray:cannel];
                [arr addObjectsFromArray:sure];
            }
        } else {
            if (sure.count > 0) {
                [arr addObjectsFromArray:sure];
            }
            if (cannel.count > 0) {
                [arr addObjectsFromArray:cannel];
            }
        }
        return arr;
    } else {
        return array;
    }
}

- (void)showInVC:(UIViewController *)vc {
    [vc presentViewController:self animated:NO completion:nil];
}

- (NSArray<HFAlertViewAction *> *)actions {
    if (!_actions) {
        _actions = [NSArray array];
    }
    return _actions;
}

- (NSArray<UITextField *> *)textFields {
    if (!_textFields) {
        _textFields = [NSArray array];
    }
    return _textFields;
}

- (UIVisualEffectView *)contentView {
    if (!_contentView) {
        _contentView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
        _contentView.frame = CGRectMake(0, 0, 270, 0);
        _contentView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.96];
        _contentView.tag = contentViewTag;
        _contentView.layer.cornerRadius = 12;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}

- (void)initUserInterface {
    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    HFAlertControllerView * view = [[HFAlertControllerView alloc] initWithFrame:self.view.bounds];
    self.view = view;
    view.delegate = self;
    
    UIVisualEffectView * bg = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    bg.frame = self.view.bounds;
    bg.tag = bgViewTag;
    bg.alpha = 0.8;
    [view addSubview:bg];
    [view sendSubviewToBack:bg];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(processCannel)];
    [bg addGestureRecognizer:tap];
    
    self.cover = bg;
    
    [self.view addSubview:self.contentView];
    CGFloat x = 18;
    CGFloat lbW = CGRectGetWidth(self.contentView.bounds) - x * 2;
    UIFont * titleFont = BOLD_SIZE(17);
    CGFloat titleH = self.titleString.length > 0 ? [self.titleString sizeWithFont:titleFont maxSize:CGSizeMake(lbW, MAXFLOAT)].height : 0;
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, HFAPadding2, lbW, titleH)];
    [self.contentView.contentView addSubview:titleLabel];
    titleLabel.font = titleFont;
    titleLabel.tag = HFTitleTag;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor blackColor];
    if (self.titleString.length > 0) {
        titleLabel.text = self.titleString;
    }
    UIFont * detailFont = FONT_SIZE(13);
    CGFloat detailH = self.message.length > 0 ? [self.message sizeWithFont:detailFont maxSize:CGSizeMake(lbW, MAXFLOAT)].height + HFAPadding : 0;
    UILabel * detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, CGRectGetMaxY(titleLabel.frame), lbW, detailH)];
    [self.contentView.contentView addSubview:detailLabel];
    detailLabel.font = detailFont;
    detailLabel.tag = HFDetailTag;
    detailLabel.textColor = [UIColor blackColor];
    detailLabel.textAlignment = NSTextAlignmentCenter;
    detailLabel.numberOfLines = 0;
    if (self.message.length > 0) {
        detailLabel.text = self.message;
    }
    BOOL lineResult = self.titleString.length == 0 && self.message.length == 0;
    CGFloat centerY = lineResult ? 0 : CGRectGetMaxY(detailLabel.frame);
    UIScrollView * center = [[UIScrollView alloc]  initWithFrame:CGRectMake(0, centerY, CGRectGetWidth(self.contentView.bounds), 0)];
    [self.contentView.contentView addSubview:center];
    center.tag = HFCenterViewTag;
    center.scrollsToTop = NO;
    center.showsHorizontalScrollIndicator = NO;
    CGFloat lineY = lineResult ? CGRectGetMaxY(center.frame) : (CGRectGetMaxY(center.frame) + HFAPadding1);
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, lineY, CGRectGetWidth(self.contentView.bounds), HF_LINE_H)];
    [self.contentView.contentView addSubview:line];
    line.tag = HFLineTag;
    line.backgroundColor = lineResult ? [UIColor clearColor] : [UIColor hfLineGrayColor];
    
    UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    CGFloat itemW = 0;
    if (self.typographicStyle == HFTypographicStyleDefault) {
        if (self.actions.count == 2) {
            itemW = CGRectGetWidth(self.contentView.bounds) / 2;
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        } else {
            itemW = CGRectGetWidth(self.contentView.bounds);
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        }
    } else {
        if (self.typographicStyle == HFTypographicStyleVertical) {
            itemW = CGRectGetWidth(self.contentView.bounds);
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        } else {
            itemW = CGRectGetWidth(self.contentView.bounds) / 2;
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        }
    }
    CGFloat collectionH = 0;
    if (self.actions.count > 0) {
        if (layout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            collectionH = HFItemH;
        } else {
            NSInteger count = iOS_LessThanIPhone6 ? 6 : 8;
            if (self.actions.count > count) {
                collectionH = HFItemH * count;
            } else {
                collectionH = HFItemH * self.actions.count;
            }
        }
    }
    self.scrollDirection = layout.scrollDirection;
    layout.itemSize = CGSizeMake(itemW, HFItemH);
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line.frame), CGRectGetWidth(self.contentView.bounds), collectionH) collectionViewLayout:layout];
    [self.contentView.contentView addSubview:collectionView];
    collectionView.tag = HFCollectionViewTag;
    collectionView.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
    [collectionView registerClass:[HFAlertViewActionCell class] forCellWithReuseIdentifier:cellID];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    self.contentView.hf_height = CGRectGetMaxY(collectionView.frame);
//    self.contentView.center = self.view.center;
}

- (void)hasCenterViewAndReloadBottomY {
    UIScrollView * center = [self.contentView viewWithTag:HFCenterViewTag];
    if (center.hf_height > 260) {
        CGFloat height = center.hf_height;
        center.hf_height = 260;
        center.contentSize = CGSizeMake(0, height);
    }
    UIView * line = [self.contentView viewWithTag:HFLineTag];
    UICollectionView * collectionView = [self.contentView viewWithTag:HFCollectionViewTag];
    if (self.titleString.length == 0 && self.message.length == 0) {
        center.hf_y = HFAPadding1;
    } else {
        if (self.message.length == 0) {
            UIView * title = [self.contentView viewWithTag:HFTitleTag];
            center.hf_y = CGRectGetMaxY(title.frame) + HFAPadding1;
        }
    }
    line.backgroundColor = [UIColor hfLineGrayColor];
    line.hf_y = CGRectGetMaxY(center.frame) + HFAPadding1;
    collectionView.hf_y = CGRectGetMaxY(line.frame);
    self.contentView.hf_height = CGRectGetMaxY(collectionView.frame);
    self.contentView.center = self.view.center;
}

- (void)processCannel {
    if (!self.canNotRemoveToTouchEmpty) {
        [self backViewRelease:nil];
    }
}

- (void)backViewRelease:(HFAlertCannelBlock)cannel {
    [self.view endEditing:YES];
    WeakObj(self)
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        selfWeak.contentView.alpha = 0.0;
        selfWeak.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [selfWeak selfRelease:cannel];
    }];
}

- (void)selfRelease:(HFAlertCannelBlock)cannel {
    if (_contentView) {
        [_contentView.layer removeAllAnimations];
        [_contentView removeFromSuperview];
        _contentView = nil;
    }
    if (cannel) {
        [self dismissViewControllerAnimated:NO completion:^{
            if (cannel) {
                cannel();
            }
        }];
    } else {
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}

- (void)hfAlertWillAppearAnimationDuration {
    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.2)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.contentView.layer addAnimation:animation forKey:@"animation"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hfAlertWillAppearAnimationDuration];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.cover.frame = self.view.bounds;
    self.contentView.center = self.view.center;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addTextFieldWithConfigurationHandler:(void (^ __nullable)(UITextField *textField))configurationHandler {
    if (configurationHandler) {
        UIView * center = [self.contentView viewWithTag:HFCenterViewTag];
        CGFloat textY = 0;
        CGFloat pad = 4;
        if (center.subviews.count > 0) {
            for (UIView * v in center.subviews) {
                textY = CGRectGetMaxY(v.frame) + pad;
            }
        }
        UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(HFAPadding1, textY, CGRectGetWidth(center.bounds) - HFAPadding1 * 2, HFAPadding3)];
        textField.font = FONT_SIZE(15);
        textField.borderStyle = UITextBorderStyleRoundedRect;
        [center addSubview:textField];
        center.hf_height = CGRectGetMaxY(textField.frame);
        [self hasCenterViewAndReloadBottomY];
        NSMutableArray * arr = (_textFields && _textFields.count > 0) ? [_textFields mutableCopy] : [NSMutableArray array];
        [arr addObject:textField];
        self.textFields = [arr copy];
        configurationHandler(textField);
    }
}

- (void)hfAlertControllerViewDidAddSubView:(UIView *)subview {
    UIView * center = [self.contentView viewWithTag:HFCenterViewTag];
    CGFloat y = 0;
    CGFloat pad = 4;
    if (center.subviews.count > 0) {
        for (UIView * v in center.subviews) {
            y = CGRectGetMaxY(v.frame) + pad;
        }
    }
    [subview layoutIfNeeded];
    CGRect rect = subview.bounds;
    CGFloat width = CGRectGetWidth(center.bounds) - HFAPadding1 * 2;
    CGFloat scale = 0.0;
    if (rect.size.width > width) {
        scale = width / rect.size.width;
    } else {
        scale = rect.size.width / width;
    }
    subview.frame = CGRectMake(HFAPadding1, y, width, rect.size.height * scale);
    [center addSubview:subview];
    center.hf_height = CGRectGetMaxY(subview.frame);
    [self hasCenterViewAndReloadBottomY];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.actions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HFAlertViewActionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    HFAlertViewAction * action = self.actions[indexPath.item];
    cell.item.tag = BTNTAG + indexPath.item;
    [cell.item setTitle:action.title ? action.title : @"" forState:UIControlStateNormal];
    cell.item.enabled = action.enabled;
    if (action.backgroundColor) {
        [cell.item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell.item setBackgroundColor:action.backgroundColor forState:UIControlStateNormal];
        [cell.item setBackgroundColor:[action.backgroundColor colorWithAlphaComponent:0.8] forState:UIControlStateHighlighted];
        if (action.style == HFAlertViewActionStyleCancel) {
            cell.item.titleLabel.font = BOLD_SIZE(HFDefaultItemFont);
        } else {
            cell.item.titleLabel.font = FONT_SIZE(HFDefaultItemFont);
        }
    } else {
        if (action.style == HFAlertViewActionStyleCancel) {
            cell.item.titleLabel.font = BOLD_SIZE(HFDefaultItemFont);
            [cell.item setTitleColor:action.tintColor ? action.tintColor : [UIColor redColor] forState:UIControlStateNormal];
        } else {
            cell.item.titleLabel.font = FONT_SIZE(HFDefaultItemFont);
            [cell.item setTitleColor:action.tintColor ? action.tintColor : [UIColor colorWithR:65 g:172 b:255 a:1] forState:UIControlStateNormal];
        }
        [cell.item setBackgroundColor:[UIColor colorWithR:237 g:237 b:237 a:1] forState:UIControlStateHighlighted];
    }
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        cell.topLine.hidden = YES;
        cell.leftLine.hidden = indexPath.item > 0 ? NO : YES;
    } else {
        cell.topLine.hidden = indexPath.item > 0 ? NO : YES;
        cell.leftLine.hidden = YES;
    }
    [cell.item addTarget:self action:@selector(processTouchItem:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)processTouchItem:(UIButton *)sender {
    NSInteger index = sender.tag - BTNTAG;
    __block HFAlertViewAction * action = self.actions[index];
    void (^cannelBlock)(void) = ^() {
        [self backViewRelease:^{
            if (action.handler) {
                action.handler(action);
            }
        }];
    };
    if (action.style == HFAlertViewActionStyleCancel) {
        cannelBlock();
    } else {
        if (self.customSureWhenTextFieldEndEditing) {
            if (action.handler) {
                action.handler(action);
            }
        } else {
            cannelBlock();
        }
    }
}

@end

@implementation HFAlertViewController (HFExtra)

+ (void)hfAlertControllerWithVC:(UIViewController *)vc typographicStyle:(HFTypographicStyle)typographicStyle title:(NSString *)title message:(NSString *)message cannelTitle:(NSString *)cannelTitle defaultTitles:(NSArray<NSString *> *)defaultTitles sureTintColor:(UIColor *)sureTintColor cannelTintColor:(UIColor *)cannelTintColor sureBlock:(HFAlertSureCountBlock)sureBlock cannelBlock:(HFAlertCannelBlock)cannelBlock {
    NSMutableArray * array = [NSMutableArray array];
    if (defaultTitles.count > 0) {
        for (NSInteger i = 0; i < defaultTitles.count; i ++) {
            HFAlertViewAction * action = [HFAlertViewAction actionWithTitle:defaultTitles[i] style:HFAlertViewActionStyleDefault handler:^(HFAlertViewAction * _Nonnull action) {
                if (sureBlock) {
                    sureBlock(i);
                }
            }];
            if (sureTintColor) {
                action.tintColor = sureTintColor;
            }
            [array addObject:action];
        }
    }
    if (cannelTitle.length > 0) {
        HFAlertViewAction * action = [HFAlertViewAction actionWithTitle:cannelTitle style:HFAlertViewActionStyleCancel handler:^(HFAlertViewAction * _Nonnull action) {
            if (cannelBlock) {
                cannelBlock();
            }
        }];
        if (cannelTintColor) {
            action.tintColor = cannelTintColor;
        }
        [array addObject:action];
    }
    HFAlertViewController * alert = [HFAlertViewController alertWithTitle:title message:message typographicStyle:typographicStyle actions:array];
    [alert showInVC:vc];
}

+ (void)hfAlertControllerSystemAlertTypeWithVC:(UIViewController *)vc typographicStyle:(HFTypographicStyle)typographicStyle title:(NSString *)title message:(NSString *)message cannelTitle:(NSString *)cannelTitle defaultTitles:(NSArray<NSString *> *)defaultTitles sureTintColor:(UIColor *)sureTintColor cannelTintColor:(UIColor *)cannelTintColor sureBlock:(HFAlertSureCountBlock)sureBlock cannelBlock:(HFAlertCannelBlock)cannelBlock {
    NSMutableArray * array = [NSMutableArray array];
    if (defaultTitles.count > 0) {
        for (NSInteger i = 0; i < defaultTitles.count; i ++) {
            __block NSInteger index = i;
            HFAlertViewAction * action = [HFAlertViewAction actionWithTitle:defaultTitles[i] style:HFAlertViewActionStyleDefault handler:^(HFAlertViewAction * _Nonnull action) {
                if (sureBlock) {
                    sureBlock(index);
                }
            }];
            if (sureTintColor) {
                action.tintColor = sureTintColor;
            }
            [array addObject:action];
        }
    }
    if (cannelTitle.length > 0) {
        HFAlertViewAction * action = [HFAlertViewAction actionWithTitle:cannelTitle style:HFAlertViewActionStyleCancel handler:^(HFAlertViewAction * _Nonnull action) {
            if (cannelBlock) {
                cannelBlock();
            }
        }];
        if (cannelTintColor) {
            action.tintColor = cannelTintColor;
        }
        [array addObject:action];
    }
    HFAlertViewController * alert = [HFAlertViewController alertWithTitle:title message:message typographicStyle:typographicStyle actions:array];
    alert.canNotRemoveToTouchEmpty = YES;
    [alert showInVC:vc];
}

+ (void)hfAlertControllerTextFieldTypeWithVC:(UIViewController *)vc title:(NSString *)title message:(NSString *)message cannelTitle:(NSString *)cannelTitle sureTitle:(NSString *)sureTitle sureTintColor:(UIColor *)sureTintColor cannelTintColor:(UIColor *)cannelTintColor textFieldHandler:(HFAlertTextFieldHandler)textFieldHandler sureBlock:(HFAlertSureCountBlock)sureBlock cannelBlock:(HFAlertCannelBlock)cannelBlock {
    NSMutableArray * array = [NSMutableArray array];
    if (sureTitle.length > 0) {
        HFAlertViewAction * action = [HFAlertViewAction actionWithTitle:sureTitle style:HFAlertViewActionStyleDefault handler:^(HFAlertViewAction * _Nonnull action) {
            if (sureBlock) {
                sureBlock(0);
            }
        }];
        if (sureTintColor) {
            action.tintColor = sureTintColor;
        }
        [array addObject:action];
    }
    if (cannelTitle.length > 0) {
        HFAlertViewAction * action = [HFAlertViewAction actionWithTitle:cannelTitle style:HFAlertViewActionStyleCancel handler:^(HFAlertViewAction * _Nonnull action) {
            if (cannelBlock) {
                cannelBlock();
            }
        }];
        if (cannelTintColor) {
            action.tintColor = cannelTintColor;
        }
        [array addObject:action];
    }
    HFAlertViewController * alert = [HFAlertViewController alertWithTitle:title message:message typographicStyle:HFTypographicStyleDefault actions:array];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textFieldHandler(textField);
    }];
    alert.canNotRemoveToTouchEmpty = YES;
    [alert showInVC:vc];
}

@end
