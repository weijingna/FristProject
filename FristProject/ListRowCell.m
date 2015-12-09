//
//  ListRowCell.m
//  government-applicant
//
//  Created by chedao on 15/11/25.
//  Copyright © 2015年 chedao-ios. All rights reserved.
//

#import "ListRowCell.h"
#import "UserModel.h"
@implementation ListRowCell

-(void)packListRowCell:(UserModel *)model With:(NSInteger)row{
    
    self.nameLabel.text = arr[row];
    if (row == 0) {
        self.conLabel.text = model.name;
    }else if (row == 1){
        self.conLabel.text = model.mobile;

    }else if (row == 2){
        self.conLabel.text = model.useUnitName;

    }
    

}
- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    arr = @[@"联系人姓名",@"电话",@"单位"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
