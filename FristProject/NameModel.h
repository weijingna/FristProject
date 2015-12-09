//
//  NameModel.h
//  government-applicant
//
//  Created by chedao on 15/11/26.
//  Copyright © 2015年 chedao-ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NameModel : NSObject
@property(nonatomic,copy)NSString *id0;
@property(nonatomic,copy)NSString *name;
+(NameModel*)packNameModel:(NSDictionary*)dic;
@end
