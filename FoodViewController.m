//
//  FoodViewController.m
//  Liwushuo
//
//  Created by administrator on 15/10/14.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "FoodViewController.h"
#import "CommodityViewController.h"
#import "QDViewController.h"
#import "coujiangViewController.h"
#import "HeadTableViewCell.h"
#import "PersonalInfo.h"
#import "NSSktTOne.h"
#import "LoginPage.h"
#import "UIImageView+WebCache.h"


@interface FoodViewController ()

@property(nonatomic,strong)NSMutableDictionary*dic;
@property BOOL go;


@property(nonatomic)NSIndexPath*aaa;
@property(nonatomic,copy)NSString*love;

@property(nonatomic,strong)NSMutableDictionary*getRspndDic;
@property(nonatomic,strong)NSMutableArray*personalLikedGift;

@property NSInteger cou;

@property(nonatomic,strong)NSMutableArray*array;

@property(nonatomic,strong)UIView*Aview;





@end

@implementation FoodViewController

- (void)viewDidLoad {
    
    self.go=YES;
    
    [super viewDidLoad];
    
    NSTimer*time=[NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(annimao) userInfo:self repeats:YES];
    
   
  

    
  }



-(void)viewWillAppear:(BOOL)animated{
    
    self.personalLikedGift=[NSMutableArray new];
    
    NSSktTOne *skt1 = [NSSktTOne shareskt];
    
    [skt1 requeset:[skt1 requestForObject:[NSString stringWithFormat:@"id=%@",[PersonalInfo share].UserID] somePhpFile:@"SaveStrategy.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
        
        
        [self.personalLikedGift removeAllObjects];
        
        for (NSDictionary *dic in [ary objectForKey:@"info"]) {
            
            
            [self.personalLikedGift addObject:[dic objectForKey:@"no"]];
            
            
            
            
            
        }
        
    }];
    
    
    //开始上拉下拉刷新
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headLoading)];
    
    self.tableview.header.automaticallyChangeAlpha = YES;
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footLoading)];
    

    self.array=[NSMutableArray new];
    
    self.dic=[NSMutableDictionary new];
    self.cou=self.pageIndex+1;
    
    
    
    if (self.cou<=2) {
        
        
        
        NSString*str=@"http://114.215.126.243/Lee/MyApache-PHP/queryStrategy.php";
        
        NSURL*url=[NSURL URLWithString:str];
        
        NSMutableURLRequest*request=[NSMutableURLRequest requestWithURL:url];
        
        request.HTTPMethod=@"POST";
        
        
        NSString*index=[NSString stringWithFormat:@"index=11020%ld",self.cou];
        
        request.HTTPBody=[index dataUsingEncoding:NSUTF8StringEncoding];
        
        
        
        NSURLSession*session=[NSURLSession sharedSession];
        
        NSURLSessionDataTask*task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            
            
            NSMutableDictionary *DIC = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            self.dic=[NSMutableDictionary dictionaryWithDictionary:DIC];
            self.array=[self.dic objectForKey:@"info"];
            
            
       //     NSLog(@"!!!!!!!!%@",self.array);
            
            dispatch_async(dispatch_get_main_queue() , ^{
                
                
                
                [self.tableview reloadData];
                
                
                
            });
            
        }];
        
        
        [task resume];
        
    }
    
    if (self.A==1) {
        self.tabBarController.tabBar.hidden=YES;
    }else{
        
   self.tabBarController.tabBar.hidden=NO;
        
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    if (self.pageIndex==0) {
        
        return 2;
    }
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (self.pageIndex) {
        case 0:
            
            if (section==0) {
                return 1;
            }
            return self.array.count;
            
            break;
            case 1:
            
            return self.array.count;
            
        default:
            
            return 5;
            break;
    }
    
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    if (self.pageIndex==0) {
        
        
        if (indexPath.section==0) {
            
        
        HeadTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"Head"];
        
         if(cell==nil){
        
        
            cell=[[HeadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Head"];
             //设置cell选中之后不会显示成灰色
             cell.selectionStyle = UITableViewCellSelectionStyleNone;
         }
            self.Aview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
       

            
            UIImageView*image1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 170)];
             UIImageView*image2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 170)];
              UIImageView*image3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 170)];
             UIImageView*image4=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 170)];
            
            image1.image=[UIImage imageNamed:@"yundong3"];
            image2.image=[UIImage imageNamed:@"shuma3"];
            image3.image=[UIImage imageNamed:@"yule3"];
            image4.image=[UIImage imageNamed:@"yundong4"];
           
            
           
           
            
            [self.Aview addSubview:image2];
            [self.Aview addSubview:image1];
            [self.Aview addSubview:image3];
            [self.Aview addSubview:image4];
            
            UIButton*button=[[UIButton alloc]initWithFrame:CGRectMake(50, 130, 100, 100)];
            
      
            
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        
            
            [button addTarget:self action:@selector(qiandao) forControlEvents:UIControlEventTouchUpInside];
            
            
            UIButton*button1=[[UIButton alloc]initWithFrame:CGRectMake(180, 150, 100, 100)];
            
            
            
            [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            
            
            [button1 addTarget:self action:@selector(choujiang) forControlEvents:UIControlEventTouchUpInside];
            UILabel *qiandaoback = [[UILabel alloc]initWithFrame:CGRectMake(5, 175, 152, 70)];

            
            [qiandaoback setBackgroundColor:[UIColor colorWithRed:200/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]];
        
            UILabel*qiandao=[[UILabel alloc]initWithFrame:CGRectMake(70, 160, 100, 100)];
            qiandao.text=@"今日签到";
            
            [qiandao setTextColor:[UIColor colorWithRed:50/255.0 green:178/255.0 blue:245/255.0 alpha:1.0]];
            
            UIImageView*qiandaoimage=[[UIImageView alloc]initWithFrame:CGRectMake(25, 195, 30, 30)];
            qiandaoimage.image=[UIImage imageNamed:@"qiandao"];
            
 
            
            
            UILabel *choujiangback = [[UILabel alloc]initWithFrame:CGRectMake(162, 175, 155, 70)];
            [choujiangback setBackgroundColor:[UIColor colorWithRed:255/255.0 green:227/255.0 blue:242/255.0 alpha:1.0]];
            

            UILabel*choujiang=[[UILabel alloc]initWithFrame:CGRectMake(220, 160, 100, 100)];
            
            choujiang.text=@"每日抽奖";
            
            [choujiang setTextColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1.0]];
            
            UIImageView*choujiangimage=[[UIImageView alloc]initWithFrame:CGRectMake(175, 195, 30, 30)];
            choujiangimage.image=[UIImage imageNamed:@"choujiang"];
            

            
            [cell addSubview:qiandaoback];
            [cell addSubview:choujiangback];
            
            [cell addSubview:qiandao];
            [cell addSubview:qiandaoimage];
            
            [cell addSubview:choujiang];
            [cell addSubview:choujiangimage];
            
            
            [cell addSubview:button];
            
            [cell addSubview:button1];
            
            
                             
            
       
            
            [cell addSubview:self.Aview];
            
  
            
            
            return cell;
        }
        
       
    

    static NSString*str=@"cell";
    
  
        FoodTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
        //设置cell选中之后不会显示成灰色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
 
     
    
        NSMutableDictionary*Dic=[NSMutableDictionary dictionary];
        
       Dic= [self.array objectAtIndex:indexPath.row];
 
       NSURL*url=[NSURL URLWithString:[NSString stringWithFormat:@"http://114.215.126.243/Lee/MyApache-PHP%@",[Dic objectForKey:@"image"]]];
        
        NSLog(@"%@",url);

        [cell.image sd_setImageWithPreviousCachedImageWithURL:url placeholderImage:[UIImage imageNamed:@"cg"] options:nil progress:nil completed:nil];
        
        

    cell.image.layer.cornerRadius =10;
        
    cell.image.clipsToBounds = YES;
        
        cell.miaoshu.text=[Dic objectForKey:@"name"];
 
        
        [cell.likecout setTextColor:[UIColor whiteColor]];
      
            NSString*satr=[Dic objectForKey:@"savecount"];
        
                cell.likecout.text=satr;
            
    
        
      
        
       
    
   
        if ([self.personalLikedGift containsObject:[[[self.dic objectForKey:@"info"]objectAtIndex:indexPath.row]objectForKey:@"no"]]) {
            
            
            
            cell.like.image = [UIImage imageNamed:@"xihuan"];
            
     
        }else{

            cell.like.image = [UIImage imageNamed:@"dontxihuan"];

        }



        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dianji:)];
        
        tap.numberOfTapsRequired = 1;
        
        tap.numberOfTouchesRequired = 1;
        
        cell.beijing.layer.cornerRadius=7.5;
        cell.beijing.clipsToBounds=YES;
        cell.beijing.alpha=0.3;
        
        cell.like.layer.cornerRadius = 10;
        
        cell.like.clipsToBounds = YES;
        

        cell.tuceng.image=[UIImage imageNamed:@"wode"];
        
        [cell.likecout addGestureRecognizer:tap];
        
        [cell.likecout setUserInteractionEnabled:YES];
        

 
    return cell;
        
    }
    if (self.pageIndex==1) {
        

        static NSString*str=@"cell";
        
        FoodTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
        
        //设置cell选中之后不会显示成灰色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary*Dic=[NSDictionary new];
        
        Dic=[self.array objectAtIndex:indexPath.row];
        
        
        NSURL*url=[NSURL URLWithString:[NSString stringWithFormat:@"http://114.215.126.243/Lee/MyApache-PHP%@",[Dic objectForKey:@"image"]]];
        
        NSData*data=[NSData dataWithContentsOfURL:url];
        
        cell.image.image=[UIImage imageWithData:data];

        cell.likecout.text=[Dic objectForKey:@"savecount"];
        
        if ([self.personalLikedGift containsObject:[[[self.dic objectForKey:@"info"]objectAtIndex:indexPath.row]objectForKey:@"no"]]) {
            
            
            
            cell.like.image = [UIImage imageNamed:@"xihuan"];
            
            
        }else{
            
            cell.like.image = [UIImage imageNamed:@"dontxihuan"];
            
            
        }

        cell.beijing.layer.cornerRadius=7.5;
        
        cell.beijing.clipsToBounds=YES;
        
        cell.beijing.alpha=0.3;
        
        cell.image.clipsToBounds = YES;
        
        cell.miaoshu.text=[Dic objectForKey:@"name"];
      
        
        cell.tuceng.image=[UIImage imageNamed:@"wode"];
        
        
        return cell;
    }
    if(self.pageIndex==2){
        
        NSArray*array=@[@"yundong1",@"yundong2",@"yundong3",@"yundong4",@"yundong5"];
    
    static NSString*str=@"cell";
    
    FoodTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
        //设置cell选中之后不会显示成灰色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.image.image=[UIImage imageNamed:[array objectAtIndex:indexPath.row]];
      cell.tuceng.image=[UIImage imageNamed:@"wode"];
        
        NSArray*countarray=@[@"133",@"543",@"321",@"223",@"531",@"325"];
        NSArray*textarray=@[@"送给喜爱运动的男朋友",@"骑行必备，不二选择",@"时尚运动服，送给心爱的她",@"运动手链"];
        
        cell.beijing.layer.cornerRadius=7.5;
        
        cell.beijing.clipsToBounds=YES;
        
        cell.beijing.alpha=0.3;
        cell.miaoshu.text=[textarray objectAtIndex:indexPath.row];
        
        cell.likecout.text=[countarray objectAtIndex:indexPath.row];
        cell.like.image = [UIImage imageNamed:@"dontxihuan"];
        
        return cell;
        
   
        

    
    }
    if(self.pageIndex==3){
        
        NSArray*array=@[@"yule1",@"yule2",@"yule3",@"yule4",@"yule5"];
        
        static NSString*str=@"cell";
        
        FoodTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
        
        //设置cell选中之后不会显示成灰色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.image.image=[UIImage imageNamed:[array objectAtIndex:indexPath.row]];
          cell.tuceng.image=[UIImage imageNamed:@"wode"];
        
        NSArray*countarray=@[@"133",@"543",@"321",@"223",@"531",@"325"];
       NSArray*textarray=@[@"家有萌宠，爱不释手啊",@"动漫周边随你挑",@"时尚运绘画，送给心爱的她",@"运动手链"];
        
        cell.beijing.layer.cornerRadius=7.5;
        
        cell.beijing.clipsToBounds=YES;
        
        cell.beijing.alpha=0.3;
        cell.miaoshu.text=[textarray objectAtIndex:indexPath.row];
        
        cell.likecout.text=[countarray objectAtIndex:indexPath.row];
        cell.like.image = [UIImage imageNamed:@"dontxihuan"];
      
        return cell;
        
    }
    if(self.pageIndex==4){
        
        NSArray*array=@[@"meishi1",@"meishi2",@"meishi3",@"meishi4",@"meishi5"];
        
        static NSString*str=@"cell";
        
        FoodTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
        //设置cell选中之后不会显示成灰色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
           cell.image.image=[UIImage imageNamed:[array objectAtIndex:indexPath.row]];
          cell.tuceng.image=[UIImage imageNamed:@"wode"];
        
        NSArray*countarray=@[@"243",@"443",@"621",@"423",@"731",@"325"];
     NSArray*textarray=@[@"零食零食不要再减肥了",@"看电影，打游戏必备美食",@"饭团",@"运动手链"];
        
        cell.beijing.layer.cornerRadius=7.5;
        
        cell.beijing.clipsToBounds=YES;
        
        cell.beijing.alpha=0.3;
        cell.miaoshu.text=[textarray objectAtIndex:indexPath.row];
        
        cell.likecout.text=[countarray objectAtIndex:indexPath.row];
        cell.like.image = [UIImage imageNamed:@"dontxihuan"];
        return cell;
        
    }
    NSArray*array=@[@"shuma1",@"shuma2",@"shuma3",@"shuma4",@"shuma5"];
        
        static NSString*str=@"cell";
        
        FoodTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:str forIndexPath:indexPath];
    //设置cell选中之后不会显示成灰色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
          cell.image.image=[UIImage imageNamed:[array objectAtIndex:indexPath.row]];
          cell.tuceng.image=[UIImage imageNamed:@"wode"];
    NSArray*countarray=@[@"833",@"1543",@"3321",@"2223",@"5311",@"325"];
    NSArray*textarray=@[@"送给在电脑前工作的她/他",@"看电影，打游戏必备",@"绕线小木马",@"运动手链"];
    
    cell.beijing.layer.cornerRadius=7.5;
    
    cell.beijing.clipsToBounds=YES;
    
    cell.beijing.alpha=0.3;
    cell.miaoshu.text=[textarray objectAtIndex:indexPath.row];
    
    cell.likecout.text=[countarray objectAtIndex:indexPath.row];
    cell.like.image = [UIImage imageNamed:@"dontxihuan"];
    
    
        return cell;
    
  
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     CommodityViewController*cv=[self.storyboard instantiateViewControllerWithIdentifier:@"commodity"];
    
//    
//    NSDictionary*dic=[NSDictionary dictionary];
//    
//    dic=[self.array objectAtIndex:indexPath.row];
//    
//    NSString*str=[dic objectForKey:@"no"];
    
    
   
    if (indexPath.section!=0&&self.pageIndex==0) {
        
        NSDictionary*dic=[NSDictionary dictionary];
        
        dic=[self.array objectAtIndex:indexPath.row];
        
        NSString*str=[dic objectForKey:@"no"];
        cv.ID=str;
        
        [self.navigationController pushViewController:cv animated:YES];
        
        
    }else{
    
        cv.ID=@"11020101";
         [self.navigationController pushViewController:cv animated:YES];
        
    
    }
    
  

    
   
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    if (indexPath.section==0&&self.pageIndex==0) {
        
        return 250;
        
    }
    
    return 170;
  
}

-(void)annimao{

 
    CATransition *transition = [CATransition animation];
    transition.duration = 0.8f;
    transition.type = @"cube";//rippleEffect cude suckEffect oglFlip pageCurl pageUnCurl cameraIrisHollowOpen cameraIrisHollowClose
    transition.subtype = @"fromLeft";//type为fade的时候subtype无效
    
    [self.Aview exchangeSubviewAtIndex:3 withSubviewAtIndex:2];
    [self.Aview exchangeSubviewAtIndex:2 withSubviewAtIndex:1];
    [self.Aview exchangeSubviewAtIndex:1 withSubviewAtIndex:0];

    
    [self.Aview.layer addAnimation:transition forKey:@"animation"];

}
-(void)qiandao{
    
        PersonalInfo *personalInfo = [PersonalInfo share];
    
 
    if (personalInfo.UserID.length!=0) {
        QDViewController*qd=[self.storyboard instantiateViewControllerWithIdentifier:@"QD"];
        
        [self.navigationController pushViewController:qd animated:YES];
    }else{
    
        
        UIAlertController *uc =[UIAlertController alertControllerWithTitle:@"签到失败!" message:@"你没有登录!" preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *ac = [UIAlertAction actionWithTitle:@"跳转登录界面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //此处 应该要跳转到登录界面
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
            
            LoginPage *lp = [sb instantiateViewControllerWithIdentifier:@"loginPage"];
            
            
            [self.navigationController pushViewController:lp animated:YES];
        }];
        
        UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [uc addAction:ac1];
        
        [uc addAction:ac];
        
        [self presentViewController:uc animated:YES completion:nil];

    
    }
  


}

-(void)choujiang{
    
  

UIStoryboard*sb=[UIStoryboard storyboardWithName:@"Choiceness" bundle:nil];
    
    coujiangViewController*cj=[sb instantiateViewControllerWithIdentifier:@"xxx"];
    
    
    PersonalInfo *personalInfo = [PersonalInfo share];
    
    
    if (personalInfo.UserID.length!=0) {
        
        
    
        NSSktTOne*skt1=[NSSktTOne shareskt];
        
        [skt1 requeset:[skt1 requestForObject:[NSString stringWithFormat:@"UserID=%@",[PersonalInfo share].UserID] somePhpFile:@"queryWinner.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
            
         //   NSLog(@"!!!!!!!!!!!!%@",ary);
            
            NSArray*array=[ary objectForKey:@"info"];
            NSDictionary*dic=[array objectAtIndex:0];
            
            self.cc=[dic objectForKey:@"bool"];
            
          //  NSLog(@"~~~当前%@",self.cc);
            
            dispatch_async(dispatch_get_main_queue() , ^{
                
                
                if ([self.cc isEqualToString:@"0"]) {
              //      NSLog(@"不能");
                    
                    UIAlertController *uc =[UIAlertController alertControllerWithTitle:@"Sorry!" message:@"你今天已经抽奖了!" preferredStyle: UIAlertControllerStyleAlert];
                    
                    
                    UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                    
                    [uc addAction:ac1];
                    
                    [self presentViewController:uc animated:YES completion:nil];
                    
                }else{
                    
                    [self.navigationController pushViewController:cj animated:YES];
                    
                    
                }
                
                
            });
            
      
        
         }];
    }else{
        
        UIAlertController *uc =[UIAlertController alertControllerWithTitle:@"收藏不能!" message:@"你没有登录!" preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *ac = [UIAlertAction actionWithTitle:@"跳转登录界面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //此处 应该要跳转到登录界面
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
            
            LoginPage *lp = [sb instantiateViewControllerWithIdentifier:@"loginPage"];
            
            
            [self.navigationController pushViewController:lp animated:YES];
        }];
        
        UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [uc addAction:ac1];
        
        [uc addAction:ac];
        
        [self presentViewController:uc animated:YES completion:nil];
        
        
    }
    
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    
}



- (void)headLoading {
    
    
    
    NSSktTOne *skt1 = [NSSktTOne shareskt];
    [skt1 getRequeset:[skt1 requestforPhpfile:@"queryDIYOrderDate.php"] :^(NSData *dat, NSError *er, NSDictionary *dic) {
        self.getRspndDic = [NSMutableDictionary dictionaryWithDictionary:dic];
        
        //  NSLog(@"==============================================%@",self.getRspndDic);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableview reloadData];
            [self.tableview.header endRefreshing];
            
        });
        
        PersonalInfo *personInfo = [PersonalInfo share];
        personInfo.refreshDate = [NSDate date];
        
    }];
    
    
    self.personalLikedGift = [NSMutableArray new];
    
    [skt1 requeset:[skt1 requestForObject:[NSString stringWithFormat:@"id=%@",[PersonalInfo share].UserID] somePhpFile:@"querySave.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
        for (NSDictionary *dic in [ary objectForKey:@"info"]) {
            [self.personalLikedGift addObject:[dic objectForKey:@"no"]];
        }
    }];
    
    
}


- (void)footLoading {

        NSSktTOne *skt1 = [NSSktTOne shareskt];
        
        self.array = [[self.dic objectForKey:@"info"]mutableCopy];
      

               NSString*index=[NSString stringWithFormat:@"index=11020%ld&count=%@",self.cou,[NSString stringWithFormat:@"limit %ld,3",self.array.count]];

        
        [skt1 requeset:[skt1 requestForObject:index somePhpFile:@"QSTrategy.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
            
       
            [self.array addObjectsFromArray:[ary objectForKey:@"info"]];
      
            
        //    NSLog(@"!!!!!!%@",self.array);
            
            [self.dic removeObjectForKey:@"info"];
            
            [self.dic setObject:self.array forKey:@"info"];
          
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableview reloadData];
                [self.tableview.header endRefreshing];
            });
            
            
        }];
        
        
        
    
    
}


-(void)dianji:(UITapGestureRecognizer*)sender{

   
    PersonalInfo *personalInfo = [PersonalInfo share];
    
    self.go=NO;
    
    if (personalInfo.UserID.length != 0){
        
        //这里得到点击了第几行的按钮
        CGPoint location = [sender locationInView:self.tableview];
        
        NSIndexPath *tapnumber = [self.tableview indexPathForRowAtPoint:location];
        
        self.aaa=tapnumber;
        
        FoodTableViewCell*cell = [self.tableview cellForRowAtIndexPath:tapnumber];
        
        cell.like.image = [UIImage imageNamed:@"xihuan"];
        
        CABasicAnimation *amt = [CABasicAnimation animation];
        amt.keyPath = @"transform.scale";
        amt.fromValue = [NSNumber numberWithFloat:0.5];
        amt.toValue = [NSNumber numberWithFloat:1.5];
        
        CAAnimationGroup *groupAnnimation = [CAAnimationGroup animation];
        groupAnnimation.duration = 0.3;
        groupAnnimation.autoreverses = YES;
        groupAnnimation.animations = @[amt];
        groupAnnimation.repeatCount = 1;
        
        [cell.like.layer addAnimation:groupAnnimation forKey:@"groupAnnimation"];

        if ([self.personalLikedGift containsObject:[[[self.dic objectForKey:@"info"]objectAtIndex:tapnumber.row]objectForKey:@"no"]]) {
    //        NSLog(@"array%@",self.array);
            
         NSString*str=[[self.array objectAtIndex:tapnumber.row]objectForKey:@"savecount"];
            
            NSString*new=[NSString stringWithFormat:@"%d",[str intValue]-1];
            
            [[self.array objectAtIndex:tapnumber.row]setObject:new forKey:@"savecount"];

            
        }else{

            
            NSString*str=[[self.array objectAtIndex:tapnumber.row]objectForKey:@"savecount"];
            
            NSString*new=[NSString stringWithFormat:@"%d",[str intValue]+1];
            
            [[self.array objectAtIndex:tapnumber.row]setObject:new forKey:@"savecount"];
            
            
            
        }

        
#pragma mark --celikshua    //第一步修改数据库;
        NSSktTOne*skt1 = [NSSktTOne shareskt];
        
        NSString *objecStr = [NSString stringWithFormat:@"no=%@&id=%@",[[[self.dic objectForKey:@"info"]objectAtIndex:tapnumber.row]objectForKey:@"no"],[PersonalInfo share].UserID];
        

        //添加或者删除喜好的东西到表中
        
        [skt1 requeset:[skt1 requestForObject:objecStr somePhpFile:@"queryStrategyUserSave.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
            
            //在目标表中检测数据
            [skt1 requeset:[skt1 requestForObject:[NSString stringWithFormat:@"id=%@",[PersonalInfo share].UserID] somePhpFile:@"SaveStrategy.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
                
                
                [self.personalLikedGift removeAllObjects];
                
                for (NSDictionary *dic in [ary objectForKey:@"info"]) {
                    
                    
                    [self.personalLikedGift addObject:[dic objectForKey:@"no"]];
                    
           
                    
                    
                }
                
                
   dispatch_async(dispatch_get_main_queue(), ^{
       
   
       
           [self performSelector:@selector(donghua) withObject:nil afterDelay:0.8];
   });

  
            }];
            
        }];
        

        
    }else{
        
        UIAlertController *uc =[UIAlertController alertControllerWithTitle:@"收藏不能!" message:@"你没有登录!" preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *ac = [UIAlertAction actionWithTitle:@"跳转登录界面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //此处 应该要跳转到登录界面
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
            
            LoginPage *lp = [sb instantiateViewControllerWithIdentifier:@"loginPage"];
            
            
            [self.navigationController pushViewController:lp animated:YES];
            
     //       NSLog(@"xiexie");
        }];
        
        UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [uc addAction:ac1];
        
        [uc addAction:ac];
        
        [self presentViewController:uc animated:YES completion:nil];
        
        
        
    }
    

    
}


-(void)donghua{

    [self.tableview reloadRowsAtIndexPaths:@[self.aaa] withRowAnimation:UITableViewRowAnimationNone];


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
