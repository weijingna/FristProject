//
//  NameModel.m
//  government-applicant
//
//  Created by chedao on 15/11/26.
//  Copyright © 2015年 chedao-ios. All rights reserved.
//

#import "NameModel.h"

@implementation NameModel
+(NameModel *)packNameModel:(NSDictionary *)dic{

    NameModel *model = [[NameModel alloc] init];
    model.id0 = dic[@"id"];
    model.name = dic[@"name"];
    
    return model;
}

@end
