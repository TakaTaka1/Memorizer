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
}
@end

@implementation ViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.mySearchBar.delegate = self;
    self.mySearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.mySearchBar.spellCheckingType = UITextSpellCheckingTypeYes;
    self.searchTable.delegate=self;
    self.searchTable.dataSource=self;
    
    _various =[[NSMutableDictionary alloc]init];
    
    _titles=[NSMutableArray array];
    
    NSDictionary *tmp=@{@"title":@"",@"url":@""};
    
    _various=[tmp mutableCopy];
    
    isflag=YES;
   
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
    

    return cell;}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    WebViewDetail *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"WebViewDetail"];
    
    
    [[self navigationController]pushViewController:detail animated:YES];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    detail.passiveUrl=_titles[indexPath.row][@"url"];

}



-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler{

    
    NSString *userName=@"YHsrwCyBLh47XXaWRFjLXF1L8ZxQLE2hMlSgtTLbkhI";
    NSString *passWord=@"YHsrwCyBLh47XXaWRFjLXF1L8ZxQLE2hMlSgtTLbkhI";
    
    
    NSURLSessionAuthChallengeDisposition dispositon=NSURLSessionAuthChallengeUseCredential;
    NSURLCredential *credenTial=[[NSURLCredential alloc]initWithUser:userName password:passWord
    persistence:NSURLCredentialPersistenceNone];
    completionHandler(dispositon,credenTial);


}



- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    
    self.mySearchBar.delegate = self;
    self.mySearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.mySearchBar.spellCheckingType = UITextSpellCheckingTypeYes;
    
    
    _titles=[[NSMutableArray alloc]init];
    
    
    [self.searchTable reloadData];
    
    
    NSString *encoded=self.mySearchBar.text;
    
    
    NSString *name =[NSString stringWithFormat:@"%@",encoded];
    
    
    NSString *encodeName =[name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"エンコード=%@", encodeName);
    
    
    NSURLSessionConfiguration *urlsessionCofiguration=[NSURLSessionConfiguration
                                                       defaultSessionConfiguration];
    
    NSURLSession *urlSession=[NSURLSession sessionWithConfiguration:urlsessionCofiguration delegate:self
                                                      delegateQueue:nil];
    
    
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
            
        });
    }];
    
    [urlsessionDataTask resume];
    
    
}



-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
   
    
    [searchBar resignFirstResponder];
    [self.searchTable reloadData];
    
    
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

    if (isflag) {
    _various =[[NSMutableDictionary alloc]init];
    _titles=[NSMutableArray array];
        

    isflag=NO;
        
    }
    
    if(isTarget){
    
    [_various setObject:string forKey:@"title"];
        
    }else if(isUrl){
    
    
    [_various setObject:string forKey:@"url"];
    
    }
   


}


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{

    isTarget=NO;
    isUrl=NO;
    
    if(_various.count>=2){   //このタイミングでtitleとurlがvariousに入って２つ以上になって初めて呼ばれる
    
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
