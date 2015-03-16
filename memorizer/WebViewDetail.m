//
//  WebViewDetail.m
//  memorizer
//
//  Created by 星野嵩夫 on 2015/02/20.
//  Copyright (c) 2015年 星野嵩夫. All rights reserved.
//

#import "WebViewDetail.h"


@interface WebViewDetail () <UIWebViewDelegate>
{BOOL flag;
    
    NSMutableArray *_getTitle;
}
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
        
        
        
        
    
        
    UISwipeGestureRecognizer *swipe= [[UISwipeGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(swipe:)];
        
    // スワイプの方向は右方向を指定する。
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
      
    // スワイプ動作に必要な指は1本と指定する。
    swipe.numberOfTouchesRequired = 1;
    
    
    [self.myWebView addGestureRecognizer:swipe];
        
    self.myWebView.delegate=self;
    }
        
    
}


-(void)swipe:(UISwipeGestureRecognizer *)gesture {
    
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
    
         self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        
        [self.myWebView goBack];

    }
    
   // [self.navigationController popViewControllerAnimated:YES];
    }
    




-(BOOL)pasteboardChanged:(id)sender{
    
    _pasteboard = [UIPasteboard generalPasteboard];
    
    NSUserDefaults *userdefaults=[NSUserDefaults standardUserDefaults];
    
    ////////////userdefaultは、一度配列に格納されて配列に文字を増やしたいときに呼び出されてそれを他の画面で共有できる

    NSString *string = _pasteboard.string;
    
    NSMutableArray *array = [[userdefaults objectForKey:@"copytext"] mutableCopy];   //copytextをキーとして使いmutableCopyメソッドで格納していく
    
    
    
    //////////////// versionUp
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    
    _getTitle=[[ud objectForKey:@"copytitle"]mutableCopy];
    
    
    
    
    
    ////////////////
    
    
    if(flag==NO)    //PasteBoardは、保存と消去で２回呼ばれるので、このif文を記述
        
    {
        
        if(array==nil){
            array=[[NSMutableArray alloc]init];
            
            //配列は、初期化してあげないと格納していかない nilの状態だと0に掛け算しているようなもの
        }
        
        /////////////////////////////////// versionUp
        
        if (_getTitle==nil) {
            _getTitle=[[NSMutableArray alloc]init];
            
        }
        
        [_getTitle addObject:[NSString stringWithFormat:@"%@",_passivetitle]];
        
        [ud setObject:_getTitle forKey:@"copytitle"];
        
        [ud synchronize];
        
        _getTitle=[ud objectForKey:@"copytitle"];
        
        NSLog(@"ud1=%@",_getTitle);
        
        //////////////////////////////////
        
        
        [array addObject:[NSString stringWithFormat:@"%@",string]];
        
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
