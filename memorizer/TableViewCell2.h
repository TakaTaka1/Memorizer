//
//  TableViewCell2.h
//  memorizer
//
//  Created by 星野嵩夫 on 2015/03/15.
//  Copyright (c) 2015年 星野嵩夫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *Label2;

@property (weak, nonatomic) IBOutlet UILabel *logLabel;
+ (CGFloat)rowHeight;



@end
