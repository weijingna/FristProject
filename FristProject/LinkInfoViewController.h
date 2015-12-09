//
//  LinkInfoViewController.h
//  government-applicant
//
//  Created by chedao on 15/11/26.
//  Copyright © 2015年 chedao-ios. All rights reserved.
//

#import "BaseViewController.h"
@class NameModel;
@interface LinkInfoViewController : BaseViewController{

    void(^selectedBlock)(NameModel *model);

}

-(void)getSelectBlock:(void(^)(NameModel *model))block;

@end
