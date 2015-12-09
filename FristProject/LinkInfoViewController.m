//
//  LinkInfoViewController.m
//  government-applicant
//
//  Created by chedao on 15/11/26.
//  Copyright © 2015年 chedao-ios. All rights reserved.
//

#import "LinkInfoViewController.h"
#import "NameModel.h"
#import "HttpApi.h"
#import "HTTP.h"
#import "LinkCell.h"
@interface LinkInfoViewController ()<UITableViewDataSource,UITableViewDelegate>{

    NSMutableArray *dataArr;//tableView数据源
    NSMutableArray *nameArr;//组名数据源
    NSMutableArray *searchArr;//搜索数据源


    
}
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation LinkInfoViewController



-(void)loadData{

    [[HttpApi shareHttpApi] httpAPi:GETUSER_URL Parameter:@{} error:@"获取用户列表失败" controller:self hudView:self.view Success:^(id dicResult) {
        NSArray *arr = dicResult[@"result"];
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            NameModel *model = [NameModel packNameModel:dic];
            [tmpArr addObject:model];
        }
  
        [self createDataArray:tmpArr];
        [_myTableView reloadData];
    } Error:nil];
    

}
-(void)createDataArray:(NSMutableArray*)array{
    
    for (int i = 'A'; i <= 'Z'; i++) {
        NSMutableArray *sectionArray = [[NSMutableArray alloc] init];
        for (int j = 0; j < array.count; j++) {
            NameModel *model = [array objectAtIndex:j];
            NSString *pinyinCity = [self chineseToPinyin:model.name];
            unichar c = [pinyinCity characterAtIndex:0];
            if (c - 32 == i) {
                [sectionArray addObject:model];
            }
            
        }
        if (sectionArray.count > 0) {
            [nameArr addObject:[NSString stringWithFormat:@"%c",i]];
            [dataArr addObject:sectionArray];
        }
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    dataArr = [NSMutableArray array];
    nameArr = [NSMutableArray array];
    searchArr = [NSMutableArray array];
    self.titleName = @"搜索联系人";
    [self leftItem];
    [self makeUI];
    [self loadData];
    
}

-(void)getSelectBlock:(void (^)(NameModel *))block{

    selectedBlock = [block copy];

}

-(void)backLastInfo:(NameModel*)model{

    if (selectedBlock) {
        selectedBlock(model);
        [self.navigationController popViewControllerAnimated:YES];
    }

}

#pragma mark - 创建TableView
-(void)makeUI{
    
    _myTableView.separatorStyle =UITableViewCellSeparatorStyleSingleLine;
    _myTableView.backgroundColor = [UIColor clearColor];
    _myTableView .tableFooterView = [[UIView alloc] init];
    [_myTableView registerNib:[UINib nibWithNibName:@"LinkCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}






#pragma mark - tableDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

        return [[dataArr objectAtIndex:section ] count];
     
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LinkCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NameModel *model = [[dataArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = model.name;

    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return dataArr.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
 

        if ([[dataArr objectAtIndex:section] count]) {
            NSString *titleStr = [nameArr objectAtIndex:section];
            return titleStr;
        }
        
    return @"";
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
        if ([[dataArr objectAtIndex:section]count]) {
            return 25;
        }else{
            return 0.01;
        }
  
    
}

//设置右侧标题
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [arr addObject:UITableViewIndexSearch];
    
    for (NSString *str  in nameArr) {
        [arr addObject:str];
    }

    return arr;
    
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index-1;

}


//点击选择
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
 
        NameModel *model = [[dataArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
       [self backLastInfo:model];
        
}

//汉字转拼音方法
-(NSString *)chineseToPinyin:(NSString *)chineseStr{
    NSMutableString *mutableStr = [NSMutableString stringWithString:chineseStr];
    BOOL ret = CFStringTransform((__bridge CFMutableStringRef)mutableStr, NULL, kCFStringTransformMandarinLatin, NO);
    if (ret) {
        BOOL ret1 = CFStringTransform((__bridge CFMutableStringRef)mutableStr, NULL, kCFStringTransformStripDiacritics, NO);
        if (ret1) {
            return [mutableStr copy];
        }
    }
    return chineseStr;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
