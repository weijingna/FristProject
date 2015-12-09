//
//  UserModel.h
//  FristProject
//
//  Created by chedao on 15/12/9.
//  Copyright © 2015年 wei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *useUnitName;
@property(nonatomic,copy)NSString *useUnitId;

+(UserModel*)packUserModel:(NSDictionary*)dic;
@end
