//
//  WebViewDetail.m
//  memorizer
//
//  Created by 星野嵩夫 on 2015/02/20.
//  Copyright (c) 2015年 星野嵩夫. All rights reserved.
//

#import "WebViewDetail.h"

@interface WebViewDetail () <UIWebViewDelegate>
{BOOL flag;}
@end

@implementation WebViewDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    NSString *str = [NSString stringWithFormat:@"%@",_passiveUrl];
    
    NSRange range = [str rangeOfString:@"https"];
    
    if (range.location !=NSNotFound) {
        
    
        NSURL *myurl2=[NSURL URLWithString:[NSString stringWithFormat:@"%@",_passiveUrl]];
        
        NSURLRequest *secondreq=[[NSURLRequest alloc]initWithURL:myurl2];
        
        [self.myWebView loadRequest:secondreq];
        
        NSLog(@"get=%@",myurl2);}
        
     else if (range.location ==NSNotFound){

      NSURL *myUrl=[NSURL URLWithString:[NSString stringWithFormat:@"http://%@",_passiveUrl]];
    
    NSURLRequest *reqmyurl=[[NSURLRequest alloc]initWithURL:myUrl];
    
    [self.myWebView loadRequest:reqmyurl];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pasteboardChanged:)
                                                 name:UIPasteboardChangedNotification
                                               object:nil];

    
    
        
        NSLog(@"get2=%@",myUrl);
        
    
    self.myWebView.delegate=self;
    }
    
    
    
    
}

-(BOOL)pasteboardChanged:(id)sender{
    
    //NSString *change=[NSString stringWithFormat:@"%d",i];    //インスタンス作成
    
    
    
    _pasteboard = [UIPasteboard generalPasteboard];
    
    
    
    NSUserDefaults *userdefaults=[NSUserDefaults standardUserDefaults];
    
    
    
    
    ////////////userdefaultは、一度配列に格納されて配列に文字を増やしたいときに呼び出されてそれを他の画面で共有できる
    
    
    
    
    NSString *string = _pasteboard.string;
    
    NSMutableArray *array = [[userdefaults objectForKey:@"copytext"] mutableCopy];   //copytextをキーとして使いmutableCopyメソッドで格納していく
    
    
    if(flag==NO)
        
    {
        
        
        if(array==nil){
            array=[[NSMutableArray alloc]init];
            //配列は、初期化してあげないと格納していかない nilの状態だと0に掛け算しているようなもの
        }
        
        
        [array addObject:[NSString stringWithFormat:@"%@",string]];//////配列の終わりを表すnil
        
        [userdefaults setObject:array forKey:@"copytext"];
        
        [userdefaults synchronize];
        
        _getter=[userdefaults objectForKey:@"copytext"];
        
        NSLog(@"ud=%@",_getter);
        
        flag=YES;
        
    }
    else if (flag==YES)
    {
        
        flag=NO;
        
    }
    
    
    
    
    
    
    return YES;
    
    
    
    
    // 文字列を取り出す。(消去と書き込みで2回呼ばれる)
    
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
    
}




-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
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
