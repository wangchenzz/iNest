//
//  CommodityViewController.m
//  Liwushuo
//
//  Created by administrator on 15/10/17.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "CommodityViewController.h"

#import "GLXQCollectionViewCell.h"

#import "SPXQViewController.h"

#import "LoginPage.h"

#import "PersonalInfo.h"

#import "UMSocial.h"

#import "NSSktTOne.h"

#import "WZFlashButton.h"

#define ip 10.110.5.73


@interface CommodityViewController ()


@property(nonatomic,retain)NSDictionary*dic;

@property(nonatomic,retain)NSArray*array;

@property(nonatomic)NSString*number;

@property(nonatomic,retain)NSDictionary*likedic;
@property(nonatomic,retain)NSArray*likearray;

@property(nonatomic,retain)NSMutableArray*dataArray;
@property(nonatomic)BOOL a;




@end

@implementation CommodityViewController


- (void)viewDidLoad {
    
    //NSLog(@"攻略编号%@",self.ID);
    [self.bar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.title=@"攻略详情";

    self.likedic=[NSDictionary dictionary];
    self.likearray=[NSArray array];
    self.dataArray=[NSMutableArray array];
    
    

   PersonalInfo*pronson = [PersonalInfo share];
    
    
    if (pronson.UserID.length!=0) {
        
     NSSktTOne*skt1=   [NSSktTOne shareskt];
        
        NSString*objecStr=[NSString stringWithFormat:@"id=%@",pronson.UserID];
        
        
        [skt1 requeset:[skt1 requestForObject:objecStr somePhpFile:@"Strategy.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
        
        //    NSLog(@"~~~~~~%@",ary);
            self.likearray=[ary objectForKey:@"info"];
            
            for (int i=0;i<self.likearray.count;i++) {
                
                
                NSString*NB=[[self.likearray objectAtIndex:i] objectForKey:@"no"];
                
                [self.dataArray addObject:NB];
             
               
                
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                if ([self.dataArray containsObject:self.ID]) {
                  self.love.image=[UIImage imageNamed:@"dontxihuan"];
                    
                     self.a=YES;
                }else{
                self.a=NO;
                }
              
                
            });
        }];
        
        
    }

NSInteger cou=[self.ID integerValue];
    
   

    
    NSString*str=@"http://114.215.126.243/Lee/MyApache-PHP/queryStrategyToTrade.php";
    
    NSURL*url=[NSURL URLWithString:str];
    
    NSMutableURLRequest*request=[NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod=@"POST";
    
       [MBProgressHUD showMessage:nil];
    
    NSString*index=[NSString stringWithFormat:@"no=%ld",cou];
    
    
    
    request.HTTPBody=[index dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    NSURLSession*session=[NSURLSession sharedSession];
    
    NSURLSessionDataTask*task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary*DIC=[[NSDictionary alloc]init];
        DIC=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        
        
        
        self.dic=[NSDictionary dictionaryWithDictionary:DIC];

        self.array=[self.dic objectForKey:@"info"];
        
      //  NSLog(@"%@",self.dic);
        
        dispatch_async(dispatch_get_main_queue() , ^{
            
            
            [MBProgressHUD hideHUD];
            
            [self.collection reloadData];
            
        });
        
        
        
        
    }];
    
    [task resume];

    
    
    [super viewDidLoad];
 

    self.like.layer.cornerRadius=10;
    
    self.like.layer.borderWidth=1.5;
    
    self.like.layer.borderColor=[UIColor redColor].CGColor;
    
    self.like.clipsToBounds=YES;

    self.fenxiang.layer.cornerRadius=10;
    
    self.fenxiang.layer.borderWidth=1.5;
    
    self.fenxiang.layer.borderColor=[UIColor redColor].CGColor;
    
    self.fenxiang.clipsToBounds=YES;
    
}

-(void)viewWillAppear:(BOOL)animated{

       self.tabBarController.tabBar.hidden=YES;
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if(section==0){
    
        return 1;
    }
    
    return self.array.count;
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    

    return 2;

}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        GLXQCollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        NSDictionary*dic=[self.array objectAtIndex:indexPath.row];
       
        NSURL*url=[NSURL URLWithString:[NSString stringWithFormat:@"http://114.215.126.243/Lee/MyApache-PHP%@",[dic objectForKey:@"sImage"]]];
        
        
        NSData*data=[NSData dataWithContentsOfURL:url];
        
        cell.image1.image=[UIImage imageWithData:data];
        
        cell.TitleLabel1.text=[dic objectForKey:@"sName"];
        
        cell.label1.text=[dic objectForKey:@"sInfo"];
        
     
        return cell;
    }else{
        
      GLXQCollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell2" forIndexPath:indexPath];
    
        
        NSDictionary*dic=[self.array objectAtIndex:indexPath.row];
        
        NSURL*url=[NSURL URLWithString:[NSString stringWithFormat:@"http://114.215.126.243/Lee/MyApache-PHP%@",[dic objectForKey:@"tImage"]]];
        
        
        NSData*data=[NSData dataWithContentsOfURL:url];
        
        cell.image2.image=[UIImage imageWithData:data];
        
        cell.TitleLabel2.text=[dic objectForKey:@"tName"];
        
        cell.label2.text=[dic objectForKey:@"tBrief"];
        
        cell.like.text=[dic objectForKey:@"tlike"];
        
        cell.price.text=[dic objectForKey:@"tPrice"];
        
        
        cell.xihuanimage.layer.cornerRadius=10;
        
        cell.xihuanimage.clipsToBounds=YES;
        
        cell.go.layer.cornerRadius=10;
        
        cell.go.layer.borderWidth=1.5;
        
        cell.go.layer.borderColor=[UIColor redColor].CGColor;
     
        
        
        [cell.button addTarget:self action:@selector(GO:) forControlEvents:UIControlEventTouchUpInside];
        

        
        [cell.button setTag:indexPath.row];
      
     
        
   
        
        return cell;
        
    }
    
    
    
}

-(void)GO:(UIButton*)sender{
    
    
    NSDictionary*dic=[self.array objectAtIndex:sender.tag];
    
//    self.number=[dic objectForKey:@"tNo"];
    
    SPXQViewController*spsq=[self.storyboard instantiateViewControllerWithIdentifier:@"SPXQ"];
    
//    spsq.number=self.number;
    spsq.BH=[[dic objectForKey:@"tNo"] integerValue];
    
 
    
    if (!self.navigationController) {
        
        [spsq setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        
        [self presentModalViewController:spsq animated:YES];
        
    }else{
    
       [self.navigationController pushViewController:spsq animated:YES];
    }

   
    
}

- (void)inviteFriends {
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5636c41be0f55a34fc0019d4"
                                      shareText:@"我最近用的一款线上购买礼物的APP简直太棒了!大家都来看看吧~"
                                     shareImage:[UIImage imageNamed:@"lijiHeadImage"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToQzone,UMShareToQQ,UMShareToWechatSession,nil]
                                       delegate:nil];
    
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section==0) {
        
        CGSize size=CGSizeMake(self.view.frame.size.width, 300);
        
        return size;
        
    }else{
        
        CGSize size=CGSizeMake(self.view.frame.size.width, 500);
    
        return size;
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction)like:(id)sender{
    
    PersonalInfo *personalInfo = [PersonalInfo share];

//    if (self.a==YES) {
//        
//        self.love.image=[UIImage imageNamed:@"asdasd"];
//        
//        self.a=NO;
//    }else{
//        self.love.image=[UIImage imageNamed:@"dontxihuan"];
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
    
    if (personalInfo.UserID.length != 0){
        
        
          NSSktTOne*skt1 = [NSSktTOne shareskt];
        

        NSString *objecStr = [NSString stringWithFormat:@"no=%@&id=%@",self.ID,[PersonalInfo share].UserID];
        
        
        [skt1 requeset:[skt1 requestForObject:objecStr somePhpFile:@"PutIntoStrategy.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
            
            
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
        
        UIAlertController *uc =[UIAlertController alertControllerWithTitle:@"提醒!" message:@"你没有登录!" preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *ac = [UIAlertAction actionWithTitle:@"跳转登录界面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //此处 应该要跳转到登录界面
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
            
            LoginPage *lp = [sb instantiateViewControllerWithIdentifier:@"loginPage"];
            
            
            [self.navigationController pushViewController:lp animated:YES];
            
        //    NSLog(@"xiexie");
        }];
        
        UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [uc addAction:ac1];
        
        [uc addAction:ac];
        [self presentViewController:uc animated:YES completion:nil];
        
        
        
    }
   
}

-(IBAction)fenxiang:(id)sender{

     [self inviteFriends];
}
@end
