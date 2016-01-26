//
//  MyRaidersPage.m
//  Personal
//
//  Created by 薛立恒 on 15/10/21.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "MyRaidersPage.h"
#import "MyRaidersPageCell.h"
#import "PersonalInfo.h"
#import "InterviewPHPMethod.h"
#import "CommodityViewController.h"
//#define IP "http://192.168.1.112:8888"
#import "MBProgressHUD+MJ.h"

@interface MyRaidersPage ()

@property (nonatomic, retain) NSMutableArray *raidersArray;
@end

@implementation MyRaidersPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.raidersArray = [NSMutableArray new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    PersonalInfo *personInfo = [PersonalInfo share];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    //显示导航栏
    self.navigationController.navigationBarHidden = NO;
    
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
    
    
    self.title = @"喜欢的攻略";
    
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.leftBarButtonItem.title = @"< 返回";
    
    self.tabBarController.tabBar.hidden = YES;
    
    
    //访问数据库
    NSMutableURLRequest *request = [InterviewPHPMethod interviewPHP:@"SaveStrategy.php" and:[NSString stringWithFormat:@"id=%@",personInfo.UserID]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"网络加载失败"];
            });
            return ;
        } else {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            self.raidersArray = dic[@"info"];
        //    NSLog(@"raiderarray = %@",self.raidersArray);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.raidersPageTableView reloadData];
            });
        }
        
    }];
    [task resume];
    
    
    
}


#pragma mark - tableviewdelegate
//有1个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


//每个分组里面有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.raidersArray.count;
}

//设置TableviewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalInfo *personInfo = [PersonalInfo share];
    NSDictionary *dic = self.raidersArray[indexPath.row];
    MyRaidersPageCell *cell = [self.raidersPageTableView dequeueReusableCellWithIdentifier:@"myRaidersPage"];
    //设置cell选中之后不会显示成灰色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.raidersImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",personInfo.IP,dic[@"image"]]]]];
    cell.raidersImage.layer.cornerRadius = 3.0;
    cell.raidersImage.clipsToBounds = YES;
    
    cell.raidersLabel.text = dic[@"name"];
    return cell;


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Choiceness" bundle:nil];
    CommodityViewController *cvc = [sb instantiateViewControllerWithIdentifier:@"commodity"];
    NSDictionary *dic = self.raidersArray[indexPath.row];
    cvc.ID = dic[@"no"];
    
    
    [self.navigationController pushViewController:cvc animated:YES];
    
}
@end
