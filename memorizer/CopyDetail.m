//
//  CopyDetail.m
//  memorizer
//
//  Created by 星野嵩夫 on 2015/02/26.
//  Copyright (c) 2015年 星野嵩夫. All rights reserved.
//

#import "CopyDetail.h"
#import "WebViewDetail.h"

@interface CopyDetail ()
{
    
    NSMutableArray *_getword;
    BOOL ischange;
    NSInteger *_count;
    
}
@end

@implementation CopyDetail

-(void)viewWillAppear:(BOOL)animated{
    
    
    NSUserDefaults *userdefaults=[NSUserDefaults standardUserDefaults];
    
    _getword=[[NSMutableArray alloc]init];
   
    _getword=[[userdefaults objectForKey:@"copytext"]mutableCopy];
    
    //[_getword addObject:[NSString stringWithFormat:@"%@"]];
    
    [userdefaults objectForKey:[NSString stringWithFormat:@"%@",_getword]];
    
    [userdefaults synchronize];
    
    [self.CopyTableView reloadData];



}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    
    self.CopyTableView.delegate=self;
    self.CopyTableView.dataSource=self;
    //_getword=[[NSMutableArray alloc]init];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _getword.count;

}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
   
   static NSString *cellidentifier=@"Cell2";
    
   UITableViewCell *cell2=[tableView dequeueReusableCellWithIdentifier:cellidentifier];
    
    if(cell2==nil){
    
        cell2=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
    
    }
    
    
        NSLog(@"==%@",_getword[indexPath.row]);
    
    cell2.textLabel.text=[NSString stringWithFormat:@"%@",_getword[indexPath.row]];
    
//    [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    
    return cell2;
    
}
 
    

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    
    NSString* term = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    
    
    if (term) {
    
        
    UIReferenceLibraryViewController* libraryViewController = [[UIReferenceLibraryViewController alloc]
                                                               initWithTerm:term];
    
        
    [self presentViewController:libraryViewController animated:YES completion:^(void){
    
        
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
        }];
    }
    
    
   
    
    NSLog(@"tap");

}

//-(BOOL)tableView:(UITableView*)tableView canEditRowAtIndexPath:(NSIndexPath*)indexPath
//{
//    return YES;
//}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  //  [self.CopyTableView setEditing:YES animated:YES];
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  //インスタンス生成
        
        WebViewDetail *array;
        
        _getword=array.getter;
        
        [ud removeObjectForKey:@"copytext"];
//       
//        //_getword=[ud objectForKey:@"copytext"];
//        
        [ud synchronize];
//      
        NSIndexPath *path = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
//        
//        
//        
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:path] withRowAnimation:UITableViewRowAnimationFade];
//        
    }
    
}

- (NSString *)tableView:(UITableView *)tableView
titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"delete";

}


//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    [_CopyTableView deleteRowsAtIndexPaths:_getword[indexPath.row][@"copytext"] withRowAnimation:UITableViewRowAnimationAutomatic];
//    
//    NSLog(@"test");
//    
//    
//    
//}






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
