//
//  ListRowCell.h
//  government-applicant
//
//  Created by chedao on 15/11/25.
//  Copyright © 2015年 chedao-ios. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserModel;
@interface ListRowCell : UITableViewCell{

    NSArray *arr;

}
@property (weak, nonatomic) IBOutlet UILabel *conLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


-(void)packListRowCell:(UserModel*)model With:(NSInteger)row;
@end
