//
//  ViewController.h
//  memorizer
//
//  Created by 星野嵩夫 on 2015/02/20.
//  Copyright (c) 2015年 星野嵩夫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <NSXMLParserDelegate,UITableViewDataSource,UITableViewDelegate,UIWebViewDelegate,NSURLSessionDataDelegate>

@property (weak, nonatomic) IBOutlet UITextField *myTextView;
- (IBAction)searchText:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *searchTable;

@end

