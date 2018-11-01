# HFAlertViewController

NSMutableArray * array = [NSMutableArray array];
            HFAlertViewAction * sure = [HFAlertViewAction actionWithTitle:@"确定" style:HFAlertViewActionStyleDefault handler:^(HFAlertViewAction * _Nonnull action) {
                //do something...
            }];
            [array addObject:sure];
            HFAlertViewAction * cannel = [HFAlertViewAction actionWithTitle:@"取消" style:HFAlertViewActionStyleCancel handler:^(HFAlertViewAction * _Nonnull action) {
                //do something...
            }];
            [array addObject:cannel];
            
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
            view.backgroundColor = [UIColor redColor];
            
            UILabel * view1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 120)];
            view1.backgroundColor = [UIColor grayColor];
            view1.text = @"HayFi";
            view1.textAlignment = NSTextAlignmentCenter;
            view1.textColor = [UIColor whiteColor];
            
            UIView * view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 300)];
            view2.backgroundColor = [UIColor blueColor];
            
            HFAlertViewController * alert = [HFAlertViewController alertWithTitle:@"custom" message:@"详细信息" typographicStyle:HFTypographicStyleDefault actions:array];
            [alert.view addSubview:view];
            [alert.view addSubview:view1];
            
            [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                NSLog(@"%@",textField.text);
            }];
            [alert.view addSubview:view2];
            alert.canNotRemoveToTouchEmpty = YES;//默认为NO,当为YES时，点击空白处alert不会消失
            [alert showInVC:self];
            
支持直接用alert.view去添加自定义子视图，添加的视图会显示在title、message下排
