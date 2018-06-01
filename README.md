# HFAlertViewController
模仿系统的UIAlertController创建的自定义AlertView
1、HFAlertViewController使用方法与系统的UIAlertController一样

[HFAlertViewController hfAlertControllerWithVC:self typographicStyle:HFTypographicStyleDefault title:DefaultAlertTitle message:@"详细信息" cannelTitle:@"取消" defaultTitles:@[@"确定"] sureTintColor:nil cannelTintColor:nil sureBlock:^(NSInteger index) {

} cannelBlock:^{

}];


2、HFAlertSheetViewController是我写的一个基类，可以继承于这个基类重写 - (void)hfAlertSheetCenterViewDidLoad;即可，具体可以参考demo的用法
