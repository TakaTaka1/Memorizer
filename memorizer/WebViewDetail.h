//
//  WebViewDetail.h
//  memorizer
//
//  Created by 星野嵩夫 on 2015/02/20.
//  Copyright (c) 2015年 星野嵩夫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewDetail : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (assign,nonatomic) NSString *passiveUrl;
@property (assign,nonatomic) NSString *passivetitle;
@property (assign,nonatomic) UIPasteboard *pasteboard;
@property (assign,nonatomic) UIPasteboard *pastetitle;
@property (assign,nonatomic) NSMutableArray *getter;
@end
