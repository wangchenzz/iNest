//
//  FLViewController.m
//  Liwushuo
//
//  Created by administrator on 15/10/29.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "FLViewController.h"

#import "FLTableViewCell.h"
#import "SPXQViewController.h"
#import "CommodityViewController.h"

@interface FLViewController ()


@property(nonatomic,retain)NSDictionary*dic;

@property(nonatomic,retain)NSArray*array;


@end

@implementation FLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.array=[NSArray array];
    self.dic=[NSDictionary dictionary];
       [MBProgressHUD showMessage:nil];
   
    [self.bar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self.bar setBackgroundColor:[UIColor colorWithRed:235/255.0 green:59/255.0 blue:70/255.0 alpha:1 ]];

    [self.view setBackgroundColor:[UIColor colorWithRed:240/255.0 green:80/255.0 blue:80/255.0 alpha:1 ]];
    
    
    NSString*str=@"http://114.215.126.243/Lee/MyApache-PHP/queryStrategy.php";
    
    
    NSURL*url=[NSURL URLWithString:str];
    
    NSMutableURLRequest*request=[NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod=@"POST";
    
    NSInteger cou=self.cout+1;
    
    NSString*index=[NSString stringWithFormat:@"index=11020%ld",cou];
    
    
    
    request.HTTPBody=[index dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSURLSession*session=[NSURLSession sharedSession];
    
    NSURLSessionDataTask*task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary*DIC=[[NSDictionary alloc]init];
        DIC=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        
        
        
        self.dic=[NSDictionary dictionaryWithDictionary:DIC];
        
        
        
        
        self.array=[self.dic objectForKey:@"info"];
        
      //  NSLog(@"xxxxxx%@",self.array);
        
        dispatch_async(dispatch_get_main_queue() , ^{
            
            [MBProgressHUD hideHUD];
            [self.tableview reloadData];
            
            if (cou==1) {
                
                  self.Title.title=@"礼物";
                
            }else{
        self.Title.title=@"美物";
            }
        
            
        });
        
        
    }];
    
    
    
    [task resume];
    
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    static NSString*str=@"cell";
    
    FLTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
    
    NSDictionary*dic=[self.array objectAtIndex:indexPath.row];
    
    
    
    NSURL*url=[NSURL URLWithString:[NSString stringWithFormat:@"http://114.215.126.243/Lee/MyApache-PHP%@",[dic objectForKey:@"image"]]];
    
    NSData*data=[NSData dataWithContentsOfURL:url];
    
    
    cell.image.image=[UIImage imageWithData:data];
    cell.image.layer.cornerRadius =10;
    cell.image.clipsToBounds = YES;
    
    [cell.beijing setBackgroundColor:[UIColor colorWithRed:109/255.0 green:109/255.0 blue:109/255.0 alpha:0.5]];
    [cell.name setBackgroundColor:[UIColor colorWithRed:109/255.0 green:109/255.0 blue:109/255.0 alpha:0.5]];
    cell.name.text=[dic objectForKey:@"name"];
    
    cell.like.text=[dic objectForKey:@"savecount"];
    
    cell.love.image=[UIImage imageNamed:@"dontxihuan"];
    cell.beijing.layer.cornerRadius=7.5;
    
    cell.beijing.clipsToBounds=YES;
    
    cell.beijing.alpha=0.3;
    
 
  
   
    
    return cell;
    
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    SPXQViewController*spxq=[self.storyboard instantiateViewControllerWithIdentifier:@"SPXQ"];
//
//    [self presentViewController:spxq animated:YES completion:nil];


//    [spxq setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//    
//    [self presentModalViewController:spxq animated:YES];
    CommodityViewController*com=[self.storyboard instantiateViewControllerWithIdentifier:@"commodity"];
    NSDictionary*dic=[self.array objectAtIndex:indexPath.row];
    
    NSString*str=[dic objectForKey:@"no"];
    
    
    com.ID=str;
    
    [com setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    [self presentModalViewController:com animated:YES];


    
    
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 170;
    
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)returnback:(id)sender {
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
