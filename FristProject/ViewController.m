//
//  ViewController.m
//  FristProject
//
//  Created by chedao on 15/12/9.
//  Copyright © 2015年 wei. All rights reserved.
//

#import "ViewController.h"
#import "ListRowCell.h"
#import "HttpApi.h"
#import "HTTP.h"
#import "UserModel.h"
#import "NameModel.h"
#import "LoadingViewController.h"
#import "LinkInfoViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>{

    UserModel *userModel;
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"信息展示";
    [self.navigationController pushViewController:[LoadingViewController new] animated:YES];
    
    _myTableView.tableFooterView = [[UIView alloc] init];
    _myTableView.dataSource = self;
    _myTableView.delegate = self;
    [_myTableView registerNib:[UINib nibWithNibName:@"ListRowCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (!userModel) {
        return 0;
    }
    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ListRowCell *cell
    = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell packListRowCell:userModel With:indexPath.row];
    return cell;
}

- (IBAction)getInfoClick:(id)sender {
    LinkInfoViewController *linkVC = [LinkInfoViewController new];
    __weak ViewController *weakSelf = self;
    [linkVC getSelectBlock:^(NameModel *model) {
        [weakSelf loadTransportUnit:model];
    }];
    
    [self.navigationController pushViewController:linkVC animated:YES];
    

}
#pragma mark === 用车单位
-(void)loadTransportUnit:(NameModel*)model{
    
    [[HttpApi shareHttpApi] httpAPi:GETDEPART_URL Parameter:@{@"id": model.id0} error:@"获取部门信息失败" controller:self hudView:self.view Success:^(id dicResult) {
        NSDictionary *dic = dicResult[@"result"];
        userModel = [UserModel packUserModel:dic];
        userModel.name = model.name;
        
        [self.myTableView reloadData];
        
    } Error:nil];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
