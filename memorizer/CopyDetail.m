//
//  CopyDetail.m
//  memorizer
//
//  Created by 星野嵩夫 on 2015/02/26.
//  Copyright (c) 2015年 星野嵩夫. All rights reserved.
//

#import "CopyDetail.h"
#import "WebViewDetail.h"
#import "ViewController.h"
#import "TableViewCell2.h"
#import "Const.h"
@interface CopyDetail ()
{
    NSMutableArray *_gotTitle;
    NSMutableArray *_getword;   
    NSInteger *_count;
    
}
@end

@implementation CopyDetail

-(void)viewWillAppear:(BOOL)animated{
    
    
    NSUserDefaults *userdefaults=[NSUserDefaults standardUserDefaults];
    
    if (_getword==nil) {
           _getword=[[NSMutableArray alloc]init];
 
    }
    
    _getword=[[userdefaults objectForKey:@"copytext"]mutableCopy];
   
    [userdefaults synchronize];

    
    
    
//////////////// versionUp
    
    
    
    NSUserDefaults *log=[NSUserDefaults standardUserDefaults];
    
    if (_gotTitle==nil) {
        _gotTitle=[[NSMutableArray alloc]init];
    }
    
    _gotTitle=[[log objectForKey:@"copytitle"]mutableCopy];
    
  //  [log objectForKey:[NSString stringWithFormat:@"%@",_gotTitle]];
    
    [log synchronize];
    

    
    UINib *nib2 = [UINib nibWithNibName:customcell2 bundle:nil];    //CustomCellを認識
    [self.CopyTableView registerNib:nib2 forCellReuseIdentifier:@"Cell2"]; //さらにsearchTableにCellタグで認識
//
    
    
    
    [self.CopyTableView reloadData];



}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.CopyTableView.delegate=self;
    self.CopyTableView.dataSource=self;
   // [self.CopyTableView setEditing:nO animated:YES];
    
    
    
   

    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _getword.count;

}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
   
//   static NSString *cellidentifier=@"Cell2";
//    
//   UITableViewCell *cell2=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
//    
//    if(cell2==nil){
//    
//        cell2=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
//    
//    }
//    
//    
//    NSLog(@"==%@",_getword[indexPath.row]);
//    
//    cell2.textLabel.text=[NSString stringWithFormat:@"%@",_getword[indexPath.row]];
//
//    
//    
    
    
    ///////////////VersionUpのため　customCell 実装
    
    static NSString *const customCell2=@"Cell2";
    
//    static NSString *const customCell2=@"customCell2";
//
//
//
    
    TableViewCell2 *cell2=[tableView dequeueReusableCellWithIdentifier:customCell2];
    
//  cell2.textLabel.text=[NSString stringWithFormat:@"%@",_gotTitle[indexPath.row][@"title"]];

    cell2.logLabel.text=[NSString stringWithFormat:@"%@",_gotTitle[indexPath.row]];
//    
//   
    
    cell2.Label2.text=[NSString stringWithFormat:@"%@",_getword[indexPath.row]];
   
    NSLog(@"%ld",(long)indexPath.row);
    
    return cell2;
    
    

}
 
    

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
  //  TableViewCell2 *cell2=[tableView dequeueReusableCellWithIdentifier:customCell2];
    
    
    
    
    NSString *term = _getword[indexPath.row];
    
    
    
   // NSString *term = [tableView cellForRowAtIndexPath:indexPath].textlabel.text;
    
    
    
    if (term) {
    
        
    UIReferenceLibraryViewController* libraryViewController = [[UIReferenceLibraryViewController alloc]
                                                               initWithTerm:term];
    
        
    [self presentViewController:libraryViewController animated:YES completion:^(void){
    
        
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
        }];
    }
    
    
   
    
    NSLog(@"tap");

}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        //インスタンス生成
        
        NSMutableArray *copytext=[[ud objectForKey:@"copytext"]mutableCopy];
        //ローカルで配列を作成　mutablecopyメソッドを忘れずに
        
        [copytext removeObjectAtIndex:indexPath.row];
        //row毎のobjectを削除
        
        [ud setObject:copytext forKey:@"copytext"];
        //copytext配列をuserdefaultに保存
        
        [ud synchronize];
        //userdefaultを更新

        _getword = copytext;
        
        NSUserDefaults *ud2=[NSUserDefaults standardUserDefaults];
        
        NSMutableArray *copytitle=[[ud2 objectForKey:@"copytitle"]mutableCopy];
        
        [copytitle removeObjectAtIndex:indexPath.row];
        
        [ud2 setObject:copytitle forKey:@"copytitle"];
        
        [ud2 synchronize];
        
        _gotTitle=copytitle;
        
        
        
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
      
    }
   
    
}

- (NSString *)tableView:(UITableView *)tableView
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"delete";

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return [TableViewCell2 rowHeight];
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
