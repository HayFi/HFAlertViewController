//
//  ViewController.m
//  HFAlertViewController
//
//  Created by HayFi on 2018/6/1.
//  Copyright © 2018年 HayFi. All rights reserved.
//

#import "ViewController.h"
#import "HFPopViewController.h"

static NSString * const cellID = @"tableViewCellID";

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSArray * dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HFAlertControllers";
    self.dataSource = @[@"alert1",@"alert2",@"alert3",@"alert4"];
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.tableFooterView = [UIView new];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    tableView.dataSource = self;
    tableView.delegate = self;
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            [HFAlertViewController hfAlertControllerWithVC:self typographicStyle:HFTypographicStyleDefault title:DefaultAlertTitle message:@"详细信息" cannelTitle:@"取消" defaultTitles:@[@"确定"] sureTintColor:nil cannelTintColor:nil sureBlock:^(NSInteger index) {
                
            } cannelBlock:^{
                
            }];
        }
            break;
        case 1:{
            [HFAlertViewController hfAlertControllerWithVC:self typographicStyle:HFTypographicStyleHorizontal title:DefaultAlertTitle message:@"详细信息" cannelTitle:@"取消" defaultTitles:@[@"确定",@"按钮1",@"按钮2"] sureTintColor:nil cannelTintColor:nil sureBlock:^(NSInteger index) {
                
            } cannelBlock:^{
                
            }];
        }
            break;
        case 2:{
            [HFAlertViewController hfAlertControllerWithVC:self typographicStyle:HFTypographicStyleVertical title:DefaultAlertTitle message:@"详细信息" cannelTitle:@"取消" defaultTitles:@[@"确定",@"按钮1",@"按钮2"] sureTintColor:nil cannelTintColor:nil sureBlock:^(NSInteger index) {
                
            } cannelBlock:^{
                
            }];
        }
            break;
        case 3:{
            HFPopViewController * vc = [HFPopViewController createWithTitle:@"HayFi" block:^{
                
            }];
            [vc showInVC:self];
        }
            break;
        default:
            break;
    }
}

@end
