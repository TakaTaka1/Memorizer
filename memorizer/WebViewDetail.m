//
//  WebViewDetail.m
//  memorizer
//
//  Created by 星野嵩夫 on 2015/02/20.
//  Copyright (c) 2015年 星野嵩夫. All rights reserved.
//

#import "WebViewDetail.h"

@interface WebViewDetail () <UIWebViewDelegate>

@end

@implementation WebViewDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSURL *myUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@",_passiveUrl]];
    
    NSURLRequest *reqmyurl=[[NSURLRequest alloc]initWithURL:myUrl];
    
    [self.myWebView loadRequest:reqmyurl];
    
    
    self.myWebView.delegate=self;
    
    NSLog(@"%@",myUrl);
    
    
    
    
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

















/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
