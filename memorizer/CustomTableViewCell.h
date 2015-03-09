//
//  CustomTableViewCell.h
//  memorizer
//
//  Created by 星野嵩夫 on 2015/03/09.
//  Copyright (c) 2015年 星野嵩夫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *myLabel1;
@property (weak, nonatomic) IBOutlet UILabel *myLabel2;

+ (CGFloat)rowHeight;

@end
