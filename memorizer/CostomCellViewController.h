//
//  CostomCellViewController.h
//  memorizer
//
//  Created by 星野嵩夫 on 2015/03/09.
//  Copyright (c) 2015年 星野嵩夫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CostomCellViewController : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *myLabel;
+ (CGFloat)rowHeight;

@end
