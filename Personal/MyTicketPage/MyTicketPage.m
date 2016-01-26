//
//  MyTicketPage.m
//  Personal
//
//  Created by 薛立恒 on 15/10/21.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "MyTicketPage.h"
#import "MyTicketPageCell.h"
#import "PersonalInfo.h"
#import "InterviewPHPMethod.h"
//#define IP "http://192.168.1.112:8888"
#import "MBProgressHUD+MJ.h"
@interface MyTicketPage ()



@end

@implementation MyTicketPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    //显示导航栏
    self.navigationController.navigationBarHidden = NO;
    
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
    
    
    self.title = @"我的礼券";
    
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.leftBarButtonItem.title = @"< 返回";
    
    self.tabBarController.tabBar.hidden = YES;
    
    [MBProgressHUD showMessage:@"加载中..."];
    
    
    
    PersonalInfo *personInfo = [PersonalInfo share];
    
    NSMutableURLRequest *request = [InterviewPHPMethod interviewPHP:@"queryCoupon.php" and:[NSString stringWithFormat:@"id=%@",personInfo.UserID]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUD];
                [MBProgressHUD showError:@"网络加载失败"];
            });
            return ;
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            

            dispatch_async(dispatch_get_main_queue(), ^{
            personInfo.ticketArray = dic[@"info"];
        //    NSLog(@"ticketArray = %@",personInfo.ticketArray);
            [self.myTicketTableView reloadData];
            [MBProgressHUD hideHUD];
            });
        }
    }];
    [task resume];
    
    
}


#pragma mark - tableviewdelegate
//有2个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


//每个分组里面有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    PersonalInfo *personInfo = [PersonalInfo share];
    return personInfo.ticketArray.count;
}

//设置TableviewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalInfo *personInfo = [PersonalInfo share];
    MyTicketPageCell *cell = [self.myTicketTableView dequeueReusableCellWithIdentifier:@"ticketCell"];
//    NSDictionary *dic = personInfo.ticketArray[indexPath.row];
    
        cell.ticketName.text = [NSString stringWithFormat:@"DIY礼物%@元抵用券",personInfo.ticketArray[indexPath.row][@"cou"]];
        cell.priceLabel.text = personInfo.ticketArray[indexPath.row][@"cou"];


    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.whichPage == 1) {
        
        MyTicketPageCell *cell = [self.myTicketTableView cellForRowAtIndexPath:indexPath];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gouwuquanchuanzhi" object:cell.priceLabel.text userInfo:nil];
        
        [self.navigationController popViewControllerAnimated:YES];
    }


}
@end
