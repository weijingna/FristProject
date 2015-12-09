//
//  LoadingViewController.m
//  FristProject
//
//  Created by chedao on 15/12/9.
//  Copyright © 2015年 wei. All rights reserved.
//

#import "LoadingViewController.h"
#import "HTTP.h"
#import "HttpApi.h"
@interface LoadingViewController ()
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *pwd;

@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    self.titleName = @"登录";
    [self loginClick:nil];
}

- (IBAction)loginClick:(id)sender {
    
    NSDictionary *dict = @{@"userName": self.account.text,@"pwd":self.pwd.text, @"userId": @"123456", @"channelId": @"123456", @"deviceType": @(4)};
    
    
    //网络请求
    [[HttpApi shareHttpApi]httpAPi:LOGIN_URL Parameter:dict error:@"登录失败" controller:self hudView:self.view Success:^(id dicResult) {
        if ([[dicResult valueForKey:@"code"] intValue] == 200) {
            NSDictionary *dic = [dicResult valueForKey:@"result"];

            
            //存储用户ID
            NSUserDefaults *uds = [NSUserDefaults standardUserDefaults];
            [uds setObject:dic[@"userId"] forKey:@"userId"];
            [uds setObject:dic[@"token"] forKey:@"token"];
            [uds synchronize];
            //页面跳转.模态
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    } Error:nil];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
