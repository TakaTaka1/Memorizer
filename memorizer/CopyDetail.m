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


}
@end

@implementation CopyDetail

-(void)viewWillAppear:(BOOL)animated{

    NSUserDefaults *userdefaults=[NSUserDefaults standardUserDefaults];
    _getword=[userdefaults objectForKey:@"copytext"];
    
    [self.CopyTableView reloadData];



}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.CopyTableView.delegate=self;
    self.CopyTableView.dataSource=self;
   
    _getword=[[NSMutableArray alloc]init];

    
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
    
    
    //NSUserDefaults *userdefaults=[NSUserDefaults standardUserDefaults];
    
    //_getword=[[userdefaults objectForKey:@"copytext"]mutableCopy];
    
    //[userdefaults setObject:_getword forKey:@"copytext"];
    
    //[userdefaults synchronize];
    
    NSLog(@"==%@",_getword[indexPath.row]);
    
    cell2.textLabel.text=[NSString stringWithFormat:@"%@",_getword[indexPath.row]];
    
    
    return cell2;
    
}
 
    

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"tap");

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
