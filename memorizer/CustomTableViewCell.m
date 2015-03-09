//
//  CustomTableViewCell.m
//  memorizer
//
//  Created by 星野嵩夫 on 2015/03/09.
//  Copyright (c) 2015年 星野嵩夫. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
//    self.myLabel1.text=nil;
//    self.myLabel2.text=nil;

    // Configure the view for the selected state
}


+ (CGFloat)rowHeight
{
    return 50.0f;
}

@end
