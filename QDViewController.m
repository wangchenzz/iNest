//
//  QDViewController.m
//  Liwushuo
//
//  Created by why on 15/11/2.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "QDViewController.h"
#import <Foundation/NSCache.h>
#import "NSSktTOne.h"
#import "PersonalInfo.h"
#import "DXAlertView.h"
#import "MBProgressHUD+MJ.h"



@interface QDViewController ()
@property (nonatomic,retain)NSMutableArray*dayarray;
@property(nonatomic)UIImageView*imageview;
@property(nonatomic)NSMutableArray*aa;

@property(nonatomic)NSString*today;
@property(nonatomic)UIButton*bb;


@property(nonatomic)NSMutableArray*imagearray;
@property(nonatomic)NSDictionary*dataDic;
@property(nonatomic)NSArray*dataArray;


@property NSInteger cout;
@property NSInteger nowday;

@end

@implementation QDViewController

- (void)viewDidLoad {
    
  
    
    
    self.dataArray=[NSArray array];
    self.dataDic=[NSDictionary dictionary];
    self.aa = [NSMutableArray new];
    
    self.navigationItem.title=@"每日签到";
    NSSktTOne*skt1=[NSSktTOne shareskt];

    
    
    NSString*userstr=[NSString stringWithFormat:@"UserID=%@",[PersonalInfo share].UserID];
    
      [MBProgressHUD showMessage:nil];
    
    [skt1 requeset:[skt1 requestForObject:userstr somePhpFile:@"querySign.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
        
        self.dataArray=[ary objectForKey:@"info"];
        self.dataDic=[self.dataArray objectAtIndex:0];
        
        self.today=[self.dataDic objectForKey:@"signbool"];
        
        NSURL*url=[NSURL URLWithString:[NSString stringWithFormat:@"http://114.215.126.243/Lee/MyApache-PHP%@",[self.dataDic objectForKey:@"headimage"]]];
        
        NSData*data=[NSData dataWithContentsOfURL:url];

        
        dispatch_async(dispatch_get_main_queue() , ^{
            
        
            
            
            if ([self.today isEqualToString:@"0"]) {
                
                [self.bb setTitle:@"签到" forState:UIControlStateNormal];
                
            }else{
                
                [self.bb setTitle:@"已签到" forState:UIControlStateNormal];
                
            }
 
            
            self.touxiang.image=[UIImage imageWithData:data];
            
            self.touxiang.layer.cornerRadius=20;

            self.touxiang.clipsToBounds = YES;
            
            self.name.text=[self.dataDic objectForKey:@"nickname"];
            self.jifen.text=[self.dataDic objectForKey:@"grade"];
            
 
            
            NSString*strr=[self.dataDic objectForKey:@"sign"];
            
            if (strr.length!=0) {
                
                
                NSArray*array=[strr componentsSeparatedByString:@"|"];
                
                self.aa=[array mutableCopy];
                
                
                for (NSString*str in self.aa) {
                    
                    
                    int  count=[str intValue];
                    
                    UIImageView*view=[self.imagearray objectAtIndex:count];
                    
                    view.hidden=NO;
                    
                    
                    
                }
            }
            
            
           [MBProgressHUD hideHUD];
        
            
  
            
     
        });

    }];
    
    
  
    
    
 
    
    self.beijing.image=[UIImage imageNamed:@"beijing"];
    
    
    
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(100, 50, 50, 50)];
    
    label.text=@"sadsad";
    
    
    
    
    
    [super viewDidLoad];
    
    
    self.imagearray=[NSMutableArray array];
    
    self.dayarray=[NSMutableArray array];
    
    self.cout=0;
    
    
    
    NSCalendar*ca=[NSCalendar currentCalendar];
    
    
    
    NSRange range=[ca rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    
    NSInteger numerofDaysinmonth=range.length;
    
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    
    
    NSDateComponents *components = [calendar components:unitFlags fromDate:[NSDate date]];
    

    self.nowday = [components day];  // 当前的号数
    
 

    for (NSInteger i=1; i<=numerofDaysinmonth; i++) {
        

        
        NSString*str=[NSString stringWithFormat:@"%ld",i];
        
        [self.dayarray addObject:str];
        
        
    }
    
    UILabel*datelabel=[[UILabel alloc]initWithFrame:CGRectMake(50,90,200,100)];
 
    datelabel.textColor=[UIColor redColor];
    
    NSDate*Nowdate=[NSDate date];
 
    NSDateFormatter*matter=[[NSDateFormatter alloc]init];
    
    [matter setLocale:[NSLocale currentLocale]];
    
    [matter setDateFormat:@"yyyy年MM月dd日"];
    
    NSString*str=[matter stringFromDate:Nowdate];
    
    datelabel.text=str;
    

    for (int i=0; i<6; i++) {
        
        for (int k=0; k<7; k++) {
            
            
            UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(31+2*k*20.5, 120+2*i*18.5, 150, 150)];
            
            self.imageview=[[UIImageView alloc]initWithFrame:CGRectMake(28+2*k*20.5, 180+2*i*18.5, 30, 30)];
            
            self.imageview.image=[UIImage imageNamed:@"ok"];
            self.imageview.hidden=YES;
            
            
            [self.imagearray addObject:self.imageview];
            
            
            if (self.cout>numerofDaysinmonth-1) {
                
                label.text=nil;
                
                [label setTextColor:[UIColor blackColor]];
                
                [self.view addSubview:label];
                
                [self.view addSubview:datelabel];
                
             
                
            }else{
                
            
                
            label.text=[self.dayarray objectAtIndex:self.cout];
            
                 self.cout++;
                
            [label setTextColor:[UIColor blackColor]];
            
                
            [self.view addSubview:label];
            
            [self.view addSubview:datelabel];
                
           [self.view addSubview:self.imageview];
                
            }
            
            
        }
        
       
  
    }
    
    self.bb=[[UIButton alloc]initWithFrame:CGRectMake(100, 400, 100, 100)];
    

        
        [self.bb setTitle:@"签到" forState:UIControlStateNormal];
        


    
    [self.bb setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [self.bb addTarget:self action:@selector(go) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:self.bb];
    
    NSDate*date=[NSDate date];
    
    

}

-(void)go{

    if ([self.today isEqualToString:@"0"]) {
        int a= [[self.dataDic objectForKey:@"grade"]intValue];
        
        
        int b=a+2;
        
        NSString*stra=[NSString stringWithFormat:@"%d",b];
        
        self.jifen.text=stra;
        
        
        
        UIImageView*view=[self.imagearray objectAtIndex:self.nowday-1];
        
        NSString*str=[NSString stringWithFormat:@"%ld",self.nowday-1];
        
        [self.aa addObject:str];
        
        NSString *str1 = [self.aa componentsJoinedByString:@"|"];
        
      //  NSLog(@"字符串%@",str1);
        
        NSString*userstr=[NSString stringWithFormat:@"UserID=%@&sign=%@",[PersonalInfo share].UserID,str1];
        
        
        NSSktTOne*skt1=[NSSktTOne shareskt];
        
        [skt1 requeset:[skt1 requestForObject:userstr somePhpFile:@"SignIn.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
            
            
        //    NSLog(@"%@",ary);
            
            
            dispatch_async(dispatch_get_main_queue() , ^{
                
                
                
                
            });
            
        }];
        
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"Congratulations！" contentText:@"签到成功！~连续签到6天，积分加倍哦" leftButtonTitle:nil rightButtonTitle:@"确定"];
        [alert show];
        alert.rightBlock = ^() {
        //    NSLog(@"right button clicked");
        };
        alert.dismissBlock = ^() {
         //   NSLog(@"Do something interesting after dismiss block");
        };
        
        view.hidden=NO;
        
        self.today=@"1";
 [self.bb setTitle:@"已签到" forState:UIControlStateNormal];

    }else{
        
    
     //   NSLog(@"不能签到");
    }
    


}


-(void)viewWillAppear:(BOOL)animated{

    self.tabBarController.tabBar.hidden=YES;
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
