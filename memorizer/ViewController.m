//
//  ViewController.m
//  memorizer
//
//  Created by 星野嵩夫 on 2015/02/20.
//  Copyright (c) 2015年 星野嵩夫. All rights reserved.
//

#import "ViewController.h"
#import "WebViewDetail.h"

@interface ViewController ()
{

@private
    BOOL isflag;
    BOOL isUrl;
    BOOL isTarget;
    NSMutableArray *_titles;
    NSMutableDictionary *_various;
    int i;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.searchTable.delegate=self;
    self.searchTable.dataSource=self;
    
    _various =[[NSMutableDictionary alloc]init];
    _titles=[NSMutableArray array];
    _titles=[NSMutableArray arrayWithObjects:_various, nil];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section   //////   2
{
    return _titles.count;
    
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier=@"Cell";   //static 定数
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell==nil){
    
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    }
    
   
    cell.textLabel.text=[NSString stringWithFormat:@"%@",_titles[indexPath.row][@"title"]];
    
    
    
//    
//    if ([self.myTextView.text isEqual:@""]) {
//        
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        
//        _titles=[[defaults objectForKey:@"title"]mutableCopy];
//
//        [defaults synchronize];
//        
//        [defaults removeObjectForKey:@"title"];          // 削除
//        
//        cell.textLabel.text=@"";
//    }
        return cell;}






-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   

    WebViewDetail *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"WebViewDetail"];
    
    //detail.passiveUrl=[NSString stringWithFormat:@"https://api.datamarket.azure.com/Bing/Search/v1/Web?Query=%@",self.myTextView.text];
    
  
    //APIから取ってきたURLを入れる
    
    
    [[self navigationController]pushViewController:detail animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    detail.passiveUrl=_titles[indexPath.row][@"url"];

}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler{

    NSString *userName=@"YHsrwCyBLh47XXaWRFjLXF1L8ZxQLE2hMlSgtTLbkhI";
    NSString *passWord=@"YHsrwCyBLh47XXaWRFjLXF1L8ZxQLE2hMlSgtTLbkhI";
    
    NSURLSessionAuthChallengeDisposition dispositon=NSURLSessionAuthChallengeUseCredential;
    NSURLCredential *credenTial=[[NSURLCredential alloc]initWithUser:userName password:passWord persistence:NSURLCredentialPersistenceNone];
    completionHandler(dispositon,credenTial);


}



- (IBAction)searchText:(id)sender {
    
    
    NSString *encoded=self.myTextView.text;
    
    
    NSString *name =[NSString stringWithFormat:@"%@",encoded];
    
    
    NSString *encodeName =[name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"エンコード=%@", encodeName);
    
    NSURLSessionConfiguration *urlsessionCofiguration=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession=[NSURLSession sessionWithConfiguration:urlsessionCofiguration delegate:self delegateQueue:nil];
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"https://api.datamarket.azure.com/Bing/Search/v1/Web?Query='%@'",encodeName]];
    
    NSLog(@"search=%@",url);
    
    
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
    NSURLSessionDataTask *urlsessionDataTask;
    
    urlsessionDataTask=[urlSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSXMLParser *parser=[[NSXMLParser alloc]initWithData:data];
        
        parser.delegate=self;
        
        [parser parse];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
            
//        if(_titles.count==20)
//        {
//        [self.searchTable reloadData];
//        }
//            
//            
        });
    }];
    
    [urlsessionDataTask resume];
    
    
    self.searchTable.delegate=self;
    self.searchTable.dataSource=self;
    
    isflag=YES;
    
    NSLog(@"%d",isflag);
    
    
//    if (isflag==YES) {
//        if(self.myTextView.text)
//    
//            NSLog(@"tap");
//            
//            }
//    
//    
    
}









//////////////////デリゲートメソッド（解析開始時）
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    isTarget=NO;
    isUrl=NO;
}

//////////////////デリゲートメソッド（要素の開始タグを読み込んだ時）
-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
 namespaceURI:(NSString *)namespaceURI
qualifiedName:(NSString *)qName
   attributes:(NSDictionary *)attributeDict{

    if([elementName isEqualToString:@"d:Title"]){
    
        isTarget=YES;
    }else if([elementName isEqualToString:@"d:DisplayUrl"]){
    
        isUrl=YES;
    
    
    }
}

//////////////////デリゲートメソッド（タグ以外のテキストを読み込んだ時）
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{

    if(isTarget){
    
        [_various setObject:string forKey:@"title"];
    
    
    
    }else if(isUrl){
    
    
        [_various setObject:string forKey:@"url"];
    
    }
   


}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{

    isTarget=NO;
    isUrl=NO;
    
    if(_various.count>=2){
    
    [_titles addObject:_various];
    
    _various=[[NSMutableDictionary alloc]init];
    }




}




//////////////////デリゲートメソッド（解析終了時）
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    
    [self.searchTable reloadData];
    
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
