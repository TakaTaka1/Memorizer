//
//  ViewController.m
//  memorizer
//
//  Created by 星野嵩夫 on 2015/02/20.
//  Copyright (c) 2015年 星野嵩夫. All rights reserved.
//

#import "ViewController.h"
#import "WebViewDetail.h"
#import "CustomTableViewCell.h"
#import "Const.h"

@interface ViewController ()
{

//@private
    BOOL isflag;
    BOOL isUrl;
    BOOL isTarget;
    NSMutableArray *_titles;
    NSMutableDictionary *_various;
    NSMutableArray *_gottitle2;
}
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.mySearchBar.showsCancelButton=YES;
    self.mySearchBar.delegate = self;
    self.mySearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.mySearchBar.spellCheckingType = UITextSpellCheckingTypeYes;
    self.searchTable.delegate=self;
    self.searchTable.dataSource=self;
    
    _various =[[NSMutableDictionary alloc]init];
    
    _titles=[[NSMutableArray alloc]init];
    
    NSDictionary *tmp=@{@"title":@"",@"url":@""};
    
    _various=[tmp mutableCopy];
   
    _titles=[NSMutableArray arrayWithObjects:_various, nil];
    
    
    // カスタマイズしたセルをテーブルビューにセット
    
    UINib *nib = [UINib nibWithNibName:CustomCell bundle:nil];    //CustomCellを認識
    [self.searchTable registerNib:nib forCellReuseIdentifier:@"Cell"]; //さらにsearchTableにCellタグで認
    
    isflag=YES;    //XMLの解析が終了した時に一度だけ0番目の行を消すため
    
   }



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section   //////   2
{
    
     return _titles.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //static NSString *CellIdentifier=@"Cell";   //static 定数
    static NSString *const CustomCell=@"Cell";
    
    CustomTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CustomCell];
    
    
    
//customCell利用時は、このコードは、必要ない
    
//    if(cell==nil){
//        
//    cell=[[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CustomCell];
//    
//                    UINib *nib = [UINib nibWithNibName:CustomCell bundle:nil];
//    [self.searchTable registerNib:nib forCellReuseIdentifier:@"CustomTableViewCell"];
//    [self.searchDisplayController.searchResultsTableView registerNib:nib forCellReuseIdentifier:@"CustomTableViewCell"];
//   
//    
//   
//        
//        
//   }
    
    
    
    
    
    
    
    cell.myLabel1.text=[NSString stringWithFormat:@"%@",_titles[indexPath.row][@"title"]];
    
    cell.myLabel2.text=[NSString stringWithFormat:@"%@",_titles[indexPath.row][@"url"]];
    
    
    ///////////////versionUpのため追加
   
    return cell;
    
    
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    WebViewDetail *detail=[self.storyboard instantiateViewControllerWithIdentifier:@"WebViewDetail"];
    
    
    [[self navigationController]pushViewController:detail animated:YES];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    detail.passiveUrl=_titles[indexPath.row][@"url"];
    
    detail.passivetitle=_titles[indexPath.row][@"title"];
     

}



-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler{

    
    NSString *userName=@"YHsrwCyBLh47XXaWRFjLXF1L8ZxQLE2hMlSgtTLbkhI";
    NSString *passWord=@"YHsrwCyBLh47XXaWRFjLXF1L8ZxQLE2hMlSgtTLbkhI";
    
    
    NSURLSessionAuthChallengeDisposition dispositon=NSURLSessionAuthChallengeUseCredential;
    NSURLCredential *credenTial=[[NSURLCredential alloc]initWithUser:userName password:passWord
    persistence:NSURLCredentialPersistenceNone];
    completionHandler(dispositon,credenTial);


}




-(void)searchBarSearchButtonClicked:(UISearchBar*)searchBar{
    
    self.mySearchBar.delegate = self;
    self.mySearchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.mySearchBar.spellCheckingType = UITextSpellCheckingTypeYes;
    
    
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
            [self.searchTable reloadData];
          
        });
    }];
    
    [urlsessionDataTask resume];
    
    _titles=[[NSMutableArray alloc]init];
  
    [searchBar resignFirstResponder];
    
     
    
}




- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CustomTableViewCell rowHeight];
    
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
    
    if(_various.count>=2){   //このタイミングでtitleとurlがvariousに入って２つ以上になって初めて呼ばれる
    
    [_titles addObject:_various];
    
    _various=[[NSMutableDictionary alloc]init];
   
    }

   

}




//////////////////デリゲートメソッド（解析終了時）
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    

    if (isflag) {

    
    [_titles removeObjectAtIndex:0];
        isflag=NO;
        
    }
    

}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
