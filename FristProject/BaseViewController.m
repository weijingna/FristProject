//
//  BaseViewController.m
//  FristProject
//
//  Created by chedao on 15/12/9.
//  Copyright © 2015年 wei. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

-(void)setTitleName:(NSString *)titleName{
    if (titleName) {
        self.navigationItem.title = titleName;
    }

}

-(void)leftItem{

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItem = item;

}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    self.view.backgroundColor = [UIColor orangeColor];
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
