# HFCoreKit

本项目基于XCode9.3下进行编译的，支持iOS7及以上的项目
如果出现崩溃请other linker处添加-ObjC

HFAlertViewController模仿系统的UIAlertController的接口创建的自定义AlertView，使用方法与系统的UIAlertController一样，并支持点击空白处消失，添加textField

[HFAlertViewController hfAlertControllerWithVC:self typographicStyle:HFTypographicStyleDefault title:DefaultAlertTitle message:@"详细信息" cannelTitle:@"取消" defaultTitles:@[@"确定"] sureTintColor:nil cannelTintColor:nil sureBlock:^(NSInteger index) {

} cannelBlock:^{

}];


2、HFAlertSheetViewController是我写的一个基类，可以继承于这个基类重写 - (void)hfAlertSheetCenterViewDidLoad;即可，具体可以参考demo的用法
