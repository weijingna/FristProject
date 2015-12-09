//
//  UserModel.m
//  FristProject
//
//  Created by chedao on 15/12/9.
//  Copyright © 2015年 wei. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+(UserModel *)packUserModel:(NSDictionary *)dic{

    UserModel *model = [[UserModel alloc] init];

    model.mobile = dic[@"mobile"];
    model.useUnitName = dic[@"useUnitName"];
    model.useUnitId = dic[@"useUnitId"];

    return model;
}
@end
