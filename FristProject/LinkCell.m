//
//  LinkCell.m
//  FristProject
//
//  Created by chedao on 15/12/9.
//  Copyright © 2015年 wei. All rights reserved.
//

#import "LinkCell.h"
#import "NameModel.h"
@implementation LinkCell

-(void)packLinkCell:(NameModel *)model{

    self.name.text = model.name;
    self.idlabel.text = [NSString stringWithFormat:@"id:%@",model.id0];

}

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
