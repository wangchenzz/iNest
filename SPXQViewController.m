//
//  SPXQViewController.m
//  Liwushuo
//
//  Created by administrator on 15/10/19.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "SPXQViewController.h"
#import "MBProgressHUD+MJ.h"
#import "WebViewController.h"
#import "jieshaoTableViewCell.h"
#import "LYTableViewCell.h"
#import "tuwenTableViewCell.h"
#import "HcCustomKeyboard.h"
#import "PersonalInfo.h"
#import "LoginPage.h"
#import "NSSktTOne.h"

@interface SPXQViewController ()<HcCustomKeyboardDelegate>

@property(nonatomic,copy)NSString*text;

@property(nonatomic)BOOL a;

@property(nonatomic,retain)NSMutableArray*Array;

@property(nonatomic,strong)UIImageView*imageview;
@property(nonatomic,retain)NSDictionary*dic;
@property(nonatomic,retain)NSArray*aarray;

@property(nonatomic,retain)UIButton*pl;



@property BOOL BB;



@end

@implementation SPXQViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title=@"商品详情";
   // NSLog(@"sadasdsadas");
    [self.bar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.aarray=[NSArray array];
    self.dic=[NSDictionary dictionary];
    self.commentsary=[NSMutableArray new];

  //  NSLog(@"编号编号%ld",self.BH);
    
    

    

    
        [self.view setBackgroundColor:[UIColor colorWithRed:240/255.0 green:80/255.0 blue:80/255.0 alpha:1 ]];
    
    self.like.layer.cornerRadius=10;
    
    
    self.like.layer.borderWidth=1.5;
    
    
    self.like.layer.borderColor=[UIColor redColor].CGColor;
    
    
    self.like.clipsToBounds=YES;
    
    
    self.go.layer.cornerRadius=10;
    
    
    self.go.layer.borderWidth=1.5;
    
    
    self.go.layer.borderColor=[UIColor whiteColor].CGColor;
    
    
    self.go.clipsToBounds=YES;
    
    
    self.BB=NO;
  
    
    self.Array=[NSMutableArray new];
    
    
   
    
    
   self.pl=[[UIButton alloc]initWithFrame:CGRectMake(270, 450, 38, 38)];
    
    
    [self.pl setHidden:YES];
    
    [self.pl setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
    
    
    
    [self.pl addTarget:self action:@selector(tan) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.pl];
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if(section==0){
    return 1;
    }else{
        
        if (self.BB) {
            


//            return self.commentsary.count;
            return self.commentsary.count;
            
        }else{
        
            return 1;
        }
    
        
    }

}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    
    if (indexPath.section==0) {
        
    jieshaoTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"jieshao"];
        
        if (self.aarray.count == 0) {
            
            
            return cell;
        }else{
        NSDictionary*dic=[self.aarray objectAtIndex:0];
        
        
        NSURL*url=[NSURL URLWithString:[NSString stringWithFormat:@"http://114.215.126.243/Lee/MyApache-PHP%@",[dic objectForKey:@"image"]]];
        
        NSData*data=[NSData dataWithContentsOfURL:url];
        
        
        cell.image.image=[UIImage imageWithData:data];
        cell.name.text=[dic objectForKey:@"name"];
        cell.price.text=[dic objectForKey:@"price"];
        cell.jieshao.text=[dic objectForKey:@"brief"];
        
        
        
            return cell;
        }
    
    }
    else{
        
    
        if(self.BB){
            
            LYTableViewCell*LYcell=[tableView dequeueReusableCellWithIdentifier:@"liuyan"];
            
            if(!LYcell){
                
                LYcell=[[LYTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"liuyan"];
            
            }
            
           
            
            LYcell.image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSSktTOne shareskt].ipstr,[[self.commentsary objectAtIndex:indexPath.row]objectForKey:@"userimage"]]]]];
            
            LYcell.image.layer.cornerRadius=25;
            LYcell.image.clipsToBounds=YES;
            LYcell.date.text= [[[self.commentsary objectAtIndex:indexPath.row]objectForKey:@"commenttime"] substringWithRange:NSMakeRange(5, 11)];
            
            
            LYcell.name.text = [[self.commentsary objectAtIndex:indexPath.row]objectForKey:@"usernickname"];
            
            LYcell.pinglun.text = [[self.commentsary objectAtIndex:indexPath.row]objectForKey:@"comment"];
            
            
    

    
   
            return LYcell;
            
            
    }
    
     else {
         
        tuwenTableViewCell*TWcell=[tableView dequeueReusableCellWithIdentifier:@"hehe"];
        
        if(!TWcell){
        
            TWcell=[[tuwenTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hehe"];
            
            
        }
         if (self.aarray.count==0) {
             return TWcell;
         }
         
         NSDictionary*dic=[self.aarray objectAtIndex:0];
         
         
         NSURL*url=[NSURL URLWithString:[NSString stringWithFormat:@"http://114.215.126.243/Lee/MyApache-PHP%@",[dic objectForKey:@"otherImage"]]];
         
         NSData*data=[NSData dataWithContentsOfURL:url];
        
            self.imageview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 400)];
            
            [self.imageview setImage:[UIImage imageWithData:data]];
            
            
            [TWcell addSubview:self.imageview];
            
            return TWcell;
         
     

       }
    
 }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
        return 400;
    }else{
        if (self.BB) {
            return 100;
        }
    
        return self.imageview.frame.size.height;
    
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if(section==0){
    
        return 0;
    }else{
    
        return 40;
    }

}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    
    
    UIButton* leftbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 160 , 37)];
    
    UIButton* rightbutton = [[UIButton alloc]initWithFrame:CGRectMake(160, 1, 160, 37)];
    
    [leftbutton setTag:11];
    
    [rightbutton setTag:12];
    
    [leftbutton setTitle:@"图文介绍" forState:UIControlStateNormal];
    
    
    [rightbutton setTitle:[NSString stringWithFormat:@"评论(%lu)",(unsigned long)self.commentsary.count] forState:UIControlStateNormal];
    
    [leftbutton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [leftbutton setTitleColor:[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:1] forState:UIControlStateNormal];
    [rightbutton setTitleColor:[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:1] forState:UIControlStateNormal];
    [rightbutton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    rightbutton.layer.borderWidth = 0.5;
    leftbutton.layer.borderWidth = 0.5;
    rightbutton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    leftbutton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [header setBackgroundColor:[UIColor colorWithWhite:0.94 alpha:1]];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"leftandright"] highlightedImage:[UIImage imageNamed:@"leftandright"]];
    
    [header addSubview:image];
    
    [image setTag:110];
    
    if (!self.BB) {
        [image setFrame:CGRectMake(160, 0, 160, 38)];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1 animations:^{
                [UIView setAnimationDuration:0.5];
                [image setFrame:CGRectMake(0, 0, 160, 38)];


            }];
        });
        
        
        
        
        
        
        
    } else {
        
        [image setFrame:CGRectMake(0, 0, 160, 38)];
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:1 animations:^{
                [UIView setAnimationDuration:0.5];
                [image setFrame:CGRectMake(160, 0, 160, 38)];

            }];
        });
        
    }
    
    
    
    [leftbutton addTarget:self action:@selector(tuwen) forControlEvents:UIControlEventTouchUpInside];
    
    [rightbutton addTarget:self action:@selector(pinglun) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [header addSubview:leftbutton];
    
    [header addSubview:rightbutton];
    
    return header;
    
    }

    


-(void)pinglun{
    
    self.BB=YES;
    
    NSSktTOne*skt1=[NSSktTOne shareskt];
    
    
    NSString*urlstr = [NSString stringWithFormat:@"no=%ld",self.BH];
    [skt1 requeset:[skt1 requestForObject:urlstr somePhpFile:@"queryComment.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
        
        self.commentsary = [ary objectForKey:@"info"];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            
            [self.tableview reloadData];
        
            
        });
        
    }];
    

    
    
     [self.pl setHidden:NO];
    
  
    [self.tableview reloadData];
    
}
-(void)tuwen{
    
    
    self.BB=NO;
    
  //  NSLog(@"tuwen");
    
    [self.pl setHidden:YES];
    
    [self.tableview reloadData];
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
-(void)tan{
    
//  [[HcCustomKeyboard customKeyboard]textViewShowView:self customKeyboardDelegate:self];
    
     PersonalInfo *personalInfo = [PersonalInfo share];
    if (personalInfo.UserID.length == 0){
    
    UIAlertController *uc =[UIAlertController alertControllerWithTitle:@"评论失败!" message:@"你没有登录!" preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction *ac = [UIAlertAction actionWithTitle:@"跳转登录界面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //此处 应该要跳转到登录界面
        
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
        
        LoginPage *lp = [sb instantiateViewControllerWithIdentifier:@"loginPage"];
        
        if (self.navigationController==nil) {
            
            [self presentViewController:lp animated:YES completion:nil];
        }
        [self.navigationController pushViewController:lp animated:YES];
        
        
    }];
    
    UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [uc addAction:ac1];
    
    [uc addAction:ac];
    [self presentViewController:uc animated:YES completion:nil];

    }else{
    
    
      [[HcCustomKeyboard customKeyboard]textViewShowView:self customKeyboardDelegate:self];
    }

}

-(void)talkBtnClick:(UITextView *)textViewGet
{
    
    
    self.write=textViewGet.text;
  
    [self.Array addObject:textViewGet.text];
    
    PersonalInfo *personalInfo = [PersonalInfo share];
    
    if (personalInfo.UserID.length != 0){
        
        [MBProgressHUD showMessage:nil];
        
        NSSktTOne *skt1 = [NSSktTOne shareskt];
    
        NSString *objectstr = [NSString stringWithFormat:@"no=%ld&userid=%@&commenttext=%@&time=%@",self.BH,personalInfo.UserID,self.write,[NSDate date]];
        
        [skt1 requeset:[skt1 requestForObject:objectstr somePhpFile:@"insertTradeComment.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
            
            NSString*urlstr = [NSString stringWithFormat:@"no=%ld",self.BH];
            [skt1 requeset:[skt1 requestForObject:urlstr somePhpFile:@"queryComment.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
                
    
                self.commentsary = [ary objectForKey:@"info"];
                
              //  NSLog(@"%@",self.commentsary);
                
                dispatch_sync(dispatch_get_main_queue(), ^{

                    [MBProgressHUD hideHUD];
            
                    [self.tableview reloadData];

                  
              });
               
            }];
        
        }];
        
        textViewGet.text = nil;
        
      
        
    }else{
        
        
        
        
        UIAlertController *uc =[UIAlertController alertControllerWithTitle:@"评论失败!" message:@"你没有登录!" preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *ac = [UIAlertAction actionWithTitle:@"跳转登录界面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //此处 应该要跳转到登录界面
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
            
            LoginPage *lp = [sb instantiateViewControllerWithIdentifier:@"loginPage"];
            
            if (self.navigationController==nil) {
                
                [self presentViewController:lp animated:YES completion:nil];
            }
            [self.navigationController pushViewController:lp animated:YES];
          
            
        }];
        
        UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [uc addAction:ac1];
        
        [uc addAction:ac];
        [self presentViewController:uc animated:YES completion:nil];
        
        
        
    }
    
    [self.tableview reloadData];
   
}


- (IBAction)GO:(id)sender {
    
    
    WebViewController*wvc=[self.storyboard instantiateViewControllerWithIdentifier:@"web"];
    
    
    
    [self.navigationController pushViewController:wvc animated:YES];
    
}

- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

-(IBAction)like:(id)sender{
    
    
    
//    if (self.a==YES) {
//        
//        self.love.image=[UIImage imageNamed:@"asdasd"];
//        
//        self.a=NO;
//    }else{
//        self.love.image=[UIImage imageNamed:@"dontxihuan"];
//        
//        CABasicAnimation *amt = [CABasicAnimation animation];
//        amt.keyPath = @"transform.scale";
//        amt.fromValue = [NSNumber numberWithFloat:0.5];
//        amt.toValue = [NSNumber numberWithFloat:1.5];
//        
//        CAAnimationGroup *groupAnnimation = [CAAnimationGroup animation];
//        groupAnnimation.duration = 0.3;
//        groupAnnimation.autoreverses = YES;
//        groupAnnimation.animations = @[amt];
//        groupAnnimation.repeatCount = 1;
//        
//        [self.love.layer addAnimation:groupAnnimation forKey:@"groupAnnimation"];
//        
//        self.a=YES;
//    }
    PersonalInfo *personalInfo = [PersonalInfo share];
    
    
    if (personalInfo.UserID.length != 0){
        
        //这里得到点击了第几行的按钮
        
        
        
        // NSLog(@"点中了第几行%ld",(long)tapnumber.row);
        
#pragma mark --celikshua    //第一步修改数据库;
        
        NSSktTOne*skt1 = [NSSktTOne shareskt];
        
        NSString*str=[NSString stringWithFormat:@"%ld",self.BH];
        
        
        NSString *objecStr = [NSString stringWithFormat:@"no=%@&id=%@",str,[PersonalInfo share].UserID];
        
        
        
        //添加或者删除喜好的东西到表中
        
        [skt1 requeset:[skt1 requestForObject:objecStr somePhpFile:@"queryTradeUserSave.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
            
            
        }];
        
        
        
        if (self.a==YES) {
            
            self.love.image=[UIImage imageNamed:@"asdasd"];
            
            self.a=NO;
        }else{
            self.love.image=[UIImage imageNamed:@"dontxihuan"];
            
            CABasicAnimation *amt = [CABasicAnimation animation];
            amt.keyPath = @"transform.scale";
            amt.fromValue = [NSNumber numberWithFloat:0.5];
            amt.toValue = [NSNumber numberWithFloat:1.5];
            
            CAAnimationGroup *groupAnnimation = [CAAnimationGroup animation];
            groupAnnimation.duration = 0.3;
            groupAnnimation.autoreverses = YES;
            groupAnnimation.animations = @[amt];
            groupAnnimation.repeatCount = 1;
            
            [self.love.layer addAnimation:groupAnnimation forKey:@"groupAnnimation"];
            
            self.a=YES;
        }

        
    }
    
    
    
    else{
        
        UIAlertController *uc =[UIAlertController alertControllerWithTitle:@"收藏不能!" message:@"你没有登录!" preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *ac = [UIAlertAction actionWithTitle:@"跳转登录界面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //此处 应该要跳转到登录界面
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
            
            LoginPage *lp = [sb instantiateViewControllerWithIdentifier:@"loginPage"];
            
            
            [self.navigationController pushViewController:lp animated:YES];
            
       //     NSLog(@"xiexie");
        }];
        
        UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [uc addAction:ac1];
        
        [uc addAction:ac];
        [self presentViewController:uc animated:YES completion:nil];
        
        
        
    }


  
}
-(void)viewWillAppear:(BOOL)animated{

    NSString*str=@"http://114.215.126.243/Lee/MyApache-PHP/queryTradeInfo.php";
    
    NSURL*url=[NSURL URLWithString:str];
    
    NSMutableURLRequest*request=[NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod=@"POST";
    
    
    NSString*index=[NSString stringWithFormat:@"no=%ld",self.BH];
    
    
    
    request.HTTPBody=[index dataUsingEncoding:NSUTF8StringEncoding];
    
    [MBProgressHUD showMessage:nil];
    
    NSURLSession*session=[NSURLSession sharedSession];
    
    NSURLSessionDataTask*task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary*DIC=[[NSDictionary alloc]init];
        DIC=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
       
        
    

        
        NSString*urlstr = [NSString stringWithFormat:@"no=%ld",self.BH];
        NSSktTOne*skt1=[NSSktTOne shareskt];
        
        [skt1 requeset:[skt1 requestForObject:urlstr somePhpFile:@"queryComment.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
            
            self.commentsary = [ary objectForKey:@"info"];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                
                [MBProgressHUD hideHUD];
                
                [self.tableview reloadData];
                
            });
            
        }];
        
        
        self.dic=[NSDictionary dictionaryWithDictionary:DIC];
        
        
        
//        
        self.aarray=[self.dic objectForKey:@"info"];
        
        
        
    //    NSLog(@"商品%@",self.aarray);
        
        dispatch_async(dispatch_get_main_queue() , ^{
            
            [self.tableview reloadData];
            
           
            
        });
        
        
        
        
    }];
    
    [task resume];
    



}



@end
