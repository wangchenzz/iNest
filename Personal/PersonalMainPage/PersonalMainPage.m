//
//  PersonalMainPage.m
//  Personal
//
//  Created by 薛立恒 on 15/10/13.
//  Copyright © 2015年 xueliheng. All rights reserved.
//
//
//                       _oo0oo_
//                      o8888888o
//                      88" . "88
//                      (| -_- |)
//                      0\  =  /0
//                    ___/`---'\___
//                  .' \\|     |// '.
//                 / \\|||  :  |||// \
//                / _||||| -:- |||||- \
//               |   | \\\  -  /// |   |
//               | \_|  ''\---/''  |_/ |
//               \  .-\__  '-'  ___/-. /
//             ___'. .'  /--.--\  `. .'___
//          ."" '<  `.___\_<|>_/___.' >' "".
//         | | :  `- \`.;`\ _ /`;.`/ - ` : | |
//         \  \ `_.   \_ __\ /__ _/   .-` /  /
//     =====`-.____`.___ \_____/___.-`___.-'=====
//                       `=---='
//
//
//     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//               佛祖保佑          永无BUG
//
//


#import "PersonalMainPage.h"
#import "PersonalMainPageCell.h"
#import "GiftRemindPage.h"
#import "MyOrderPage.h"
#import "MyCartPage.h"
#import "MyTicketPage.h"
#import "MyRaidersPage.h"
#import "LoginPage.h"
#import "PersonalInfo.h"
#import "PersonaDetailPage.h"
#import "InterviewPHPMethod.h"
#import "MyIntegralPage.h"
#import "MBProgressHUD+MJ.h"
//#define IP "http://192.168.2.15:8888"

@interface PersonalMainPage ()

@property (nonatomic,retain) NSArray *PersonalMainArray;

@end

@implementation PersonalMainPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"PersonalMainPage" ofType:@"plist"];
    self.PersonalMainArray = [NSArray arrayWithContentsOfFile:path];
//    NSLog(@"%@",self.PersonalMainArray);
    
    //调用取消多余分割线的函数
     [self setExtraCellLineHidden:self.PersonalMainPageTableView];
    
    
    //让头像变成圆形
    self.headImage.layer.cornerRadius = 30;
    self.headImage.layer.borderWidth = 1.0;
    self.headImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.headImage.clipsToBounds = YES;
    
    
    //隐藏标题栏
    self.navigationController.navigationBarHidden = YES;
    
    //设置返回键的颜色及内容
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"返回";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = returnButtonItem;
    
    
    if ([UIScreen mainScreen].bounds.size.height == 736) {
        self.headImageHeight.constant = 250;
    } else {
        self.headImageHeight.constant = 210;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    
    

    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBarHidden = YES;
    
    
    PersonalInfo *personInfo = [PersonalInfo share];
    
    
    
    //设置状态栏为白色
    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
    
    
//    PersonalInfo *personInfo = [PersonalInfo share];
    
//    NSIndexPath *index = [NSIndexPath indexPathForRow:1 inSection:0];
//    PersonaDetailCell2 *cell = [self.personDetailTableView cellForRowAtIndexPath:index];
//    
    if (personInfo.UserName.length > 0) {
        self.userName.text = personInfo.UserName;
    } else {
        self.userName.text = personInfo.UserID;
        personInfo.UserName = personInfo.UserID;
        
    }
    if (personInfo.UserID.length != 0) {
        if (personInfo.ImageData.length == 0) {
            NSMutableURLRequest *request = [InterviewPHPMethod interviewPHP:@"Search.php" and:[NSString stringWithFormat:@"UserID=%@",personInfo.UserID]];
    //        NSLog(@"%@",[NSString stringWithFormat:@"UserID=%@",personInfo.UserID]);
            
            NSURLSession *session = [NSURLSession sharedSession];
            NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                
                if (error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:@"网络加载失败"];
                    self.headImage.image = [UIImage imageNamed:@"headImage"];
                    self.userName.text = personInfo.UserID;
                        });
                    return ;
                } else {
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
          //      NSLog(@"%@",[NSString stringWithFormat:@"%@%@",personInfo.IP,dic[@"result2"]]);

                NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",personInfo.IP,dic[@"result2"]]]];
                
               
                personInfo.ImageData = data1;
                personInfo.integralCount = dic[@"result4"];
                
                self.headImage.image = [UIImage imageWithData:personInfo.ImageData];
                if (dic[@"result3"] == nil) {
                    //                personInfo.UserName = dic[@"result3"];
                    personInfo.UserName = personInfo.UserID;
                } else {
                    personInfo.UserName = dic[@"result3"];
                    //            personInfo.UserName = personInfo.UserID;
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                
                    self.headImage.image = [UIImage imageWithData:personInfo.ImageData];
                    self.userName.text = personInfo.UserName;
                   
                });
                }
            }];
            [task resume];
            
        } else {
            
            self.headImage.image = [UIImage imageWithData:personInfo.ImageData];
        }
    }
    
 
    
    if (personInfo.UserName.length > 0) {
        if (personInfo.UserID.length == 0) {
            self.userName.text = nil;
        }else {
            self.userName.text = personInfo.UserName;
        }
    } else {
        self.userName.text = personInfo.UserID;
        
    }
    
    
    if (personInfo.UserID.length == 0) {
        self.headImage.image = [UIImage imageNamed:@"headImage"];
        self.userName.text = @"登录";
    } else {
        if (personInfo.ImageData.bytes == 0) {
            self.headImage.image = [UIImage imageNamed:@"headImage"];
            personInfo.ImageData = UIImagePNGRepresentation(self.headImage.image);
        } else {
            self.headImage.image = [UIImage imageWithData:personInfo.ImageData];
        }
        
    }
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:personInfo.UserID forKey:@"UserID"];
    [ud setObject:personInfo.UserName forKey:@"UserName"];
    [ud setObject:personInfo.ImageData forKey:@"UserImage"];
    
    [ud synchronize];
    


}




#pragma mark - tableviewdelegate
//有2个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


//每个分组里面有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *array = self.PersonalMainArray[section];
    return array.count;
}

//设置TableviewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *array = self.PersonalMainArray[indexPath.section];
    NSDictionary *dic = array[indexPath.row];
    static NSString *first = @"PersonalFirst";

    PersonalMainPageCell *cell = [tableView dequeueReusableCellWithIdentifier:first forIndexPath:indexPath];
    //设置cell选中之后不会显示成灰色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.MainCellImage.image = [UIImage imageNamed:[dic objectForKey:@"image"]];
    cell.MainCellImage.layer.cornerRadius = 12.0;
    cell.MainCellImage.clipsToBounds = YES;
    
    cell.MainCellName.text = [dic objectForKey:@"name"];
//    NSLog(@"%@",cell.MainCellName.text);
    return cell;

}

//选中cell之后的操作
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        PersonalInfo *personInfo = [PersonalInfo share];
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
    //跳转到"我的订单"
    if (indexPath.section == 0 && indexPath.row == 1) {
        

        if (personInfo.UserID.length > 0) {
            MyOrderPage *mop = [sb instantiateViewControllerWithIdentifier:@"myOrderPage"];
            
            
            [self.navigationController pushViewController:mop animated:YES];
        } else {
            LoginPage *lp = [sb instantiateViewControllerWithIdentifier:@"loginPage"];
            
            
            [self transitionPush];
            [self.navigationController pushViewController:lp animated:YES];
            
        }
        
    }
    //跳转到"我的购物车"
    else if (indexPath.section == 0 && indexPath.row == 0) {

        if (personInfo.UserID.length > 0) {
            
            MyCartPage *mcp = [sb instantiateViewControllerWithIdentifier:@"myCartPage"];
            
            mcp.whichPage = 0;
            
            [self.navigationController pushViewController:mcp animated:YES];
        } else {
            LoginPage *lp = [sb instantiateViewControllerWithIdentifier:@"loginPage"];
            
            
            
            [self.navigationController pushViewController:lp animated:YES];
//            [self transitionPush];
            
        }
    }
    //跳转到"喜欢的礼物"
    else if (indexPath.section == 1 && indexPath.row == 0) {

        if (personInfo.UserID.length > 0) {
            
            MyCartPage *mcp = [sb instantiateViewControllerWithIdentifier:@"myCartPage"];
            
            mcp.whichPage = 1;
            
            [self.navigationController pushViewController:mcp animated:YES];
        } else {
            LoginPage *lp = [sb instantiateViewControllerWithIdentifier:@"loginPage"];
            
            
//            [self transitionPush];
            [self.navigationController pushViewController:lp animated:YES];
            
        }
        
    
    }
    //跳转到"我的积分"
    else if (indexPath.section == 0 && indexPath.row == 3) {

        if (personInfo.UserID.length > 0) {
            MyIntegralPage *mip = [sb instantiateViewControllerWithIdentifier:@"myIntegralPage"];
            
            [self.navigationController pushViewController:mip animated:YES];
        } else {
            LoginPage *lp = [sb instantiateViewControllerWithIdentifier:@"loginPage"];
            
            
//            [self transitionPush];
            [self.navigationController pushViewController:lp animated:YES];
            
        }
    
    
    }
    //跳转到"我的礼券"
    else if (indexPath.section == 0 && indexPath.row == 2) {
        

        if (personInfo.UserID.length > 0) {
            MyTicketPage *mtp = [sb instantiateViewControllerWithIdentifier:@"myTicketPage"];
            mtp.whichPage = 0;
            
            [self.navigationController pushViewController:mtp animated:YES];
        } else {
            LoginPage *lp = [sb instantiateViewControllerWithIdentifier:@"loginPage"];
            
            
//            [self transitionPush];
            [self.navigationController pushViewController:lp animated:YES];
            
        }
        
    }
    //跳转到"喜欢的攻略"
    else {

        if (personInfo.UserID.length > 0) {
            MyRaidersPage *mrp = [sb instantiateViewControllerWithIdentifier:@"myRaidersPage"];
            
            
            [self.navigationController pushViewController:mrp animated:YES];
        } else {
            LoginPage *lp = [sb instantiateViewControllerWithIdentifier:@"loginPage"];
            
            
//            [self transitionPush];
            [self.navigationController pushViewController:lp animated:YES];
            
        }
    
    }

}


//设置每个cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
    
}

//设置cell的header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 10;
}
//设置cell的footer的高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
    
}
//将多余的cell的线条
- (void)setExtraCellLineHidden: (UITableView *)tableView {

    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
    
}

//跳转到礼物提醒的界面
- (IBAction)ClockButton:(UIButton *)sender {
    PersonalInfo *personInfo = [PersonalInfo share];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];

    if (personInfo.UserID.length > 0) {
        GiftRemindPage *gep = [sb instantiateViewControllerWithIdentifier:@"giftRemind"];
        
        [self.navigationController pushViewController:gep animated:YES];
    } else {
        LoginPage *lp = [sb instantiateViewControllerWithIdentifier:@"loginPage"];
        
        
//        [self transitionPush];
        [self.navigationController pushViewController:lp animated:YES];
        
    }
  
}

//跳转到个人用户界面,如果没有登录就跳转到登录界面
- (IBAction)personalDetail:(UIButton *)sender {
    PersonalInfo *personInfo = [PersonalInfo share];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];

    if (personInfo.UserID.length > 0) {
        PersonaDetailPage *pdp = [sb instantiateViewControllerWithIdentifier:@"personalDetailPage"];
        
        [self.navigationController pushViewController:pdp animated:YES];
    } else {
        LoginPage *lp = [sb instantiateViewControllerWithIdentifier:@"loginPage"];
    
    
//        [self transitionPush];
        [self.navigationController pushViewController:lp animated:YES];
    
    }
    

    
}

//转场动画
- (void)transitionPush {
    CATransition *tran = [CATransition animation];
    tran.duration = 0.3;
    
    tran.type = @"moveIn";
    tran.subtype = kCATransitionFromTop;
    
    [self.navigationController.view.layer addAnimation:tran forKey:nil];


}




//跳转消息界面
- (IBAction)MessageButton:(UIButton *)sender {
    
    
}





@end
