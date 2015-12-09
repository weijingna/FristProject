//
//  LinkCell.h
//  FristProject
//
//  Created by chedao on 15/12/9.
//  Copyright © 2015年 wei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NameModel;
@interface LinkCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *idlabel;

-(void)packLinkCell:(NameModel*)model;
@end
