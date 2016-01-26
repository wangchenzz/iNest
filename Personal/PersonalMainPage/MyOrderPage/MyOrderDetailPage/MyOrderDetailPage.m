//
//  MyOrderDetailPage.m
//  Personal
//
//  Created by xlh on 15/11/9.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "MyOrderDetailPage.h"
#import "MyOrderDetailPageCell1.h"
#import "MyOrderDetailPageCell2.h"
#import "InterviewPHPMethod.h"
#import "PersonalInfo.h"
#import "MBProgressHUD+MJ.h"
//#define IP "http://192.168.1.112:8888"

@interface MyOrderDetailPage ()

//@property (nonatomic, retain) NSMutableDictionary *orderDic;
@property (nonatomic, retain) NSMutableArray *array;

@end

@implementation MyOrderDetailPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
//    self.orderDic = [NSMutableDictionary new];
    self.array = [NSMutableArray new];
    
    PersonalInfo *personInfo = [PersonalInfo share];
    
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    //显示导航栏
    self.navigationController.navigationBarHidden = NO;
    
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
    
    
 
        self.title = @"DIY订单";
        NSMutableURLRequest *request = [InterviewPHPMethod interviewPHP:@"queryDIYOrder.php" and:[NSString stringWithFormat:@"id=%@",personInfo.UserID]];
        
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:@"网络加载失败"];
                });
                return ;
            } else {
           NSDictionary *orderDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            self.array = orderDic[@"info"];
        //    NSLog(@"dic = %@",orderDic);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.myOrderDetailPage reloadData];
            });
            }
        }];
        [task resume];
 
    
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.leftBarButtonItem.title = @"< 返回";
    
    self.tabBarController.tabBar.hidden = YES;
    
    
   

}



#pragma mark - tableviewdelegate
//有n个分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.array.count + 1;
}


//每个分组里面有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

//设置TableviewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PersonalInfo *personInfo = [PersonalInfo share];
    if (indexPath.section == 0) {
        
        MyOrderDetailPageCell1 *cell = [self.myOrderDetailPage dequeueReusableCellWithIdentifier:@"MyOrderDetailPageCell1"];
        //设置cell选中之后不会显示成灰色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    } else {
        MyOrderDetailPageCell2 *cell = [self.myOrderDetailPage dequeueReusableCellWithIdentifier:@"MyOrderDetailPageCell2"];
        //设置cell选中之后不会显示成灰色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.array = self.orderDic[@"info"];
        NSDictionary *dic = self.array[indexPath.section - 1];
        cell.headType.text = @"DIY订单";
        cell.tradeHeadImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",personInfo.IP,dic[@"image"]]]]];
        cell.tradeName.text = dic[@"name"];
        cell.tradePrice.text = [NSString stringWithFormat:@"￥%@",dic[@"price"]];
        cell.tradeCount.text =  [NSString stringWithFormat:@"×%@",dic[@"count"]];
        cell.tradeTotalCount.text = [NSString stringWithFormat:@"共%@件商品,合计:%.2f元",dic[@"count"],[dic[@"price"] floatValue] * [dic[@"count"] floatValue]];
        
        cell.getTradeButton.layer.borderWidth = 1.0;
        cell.getTradeButton.layer.cornerRadius = 5.0;
        cell.getTradeButton.clipsToBounds = YES;
        cell.getTradeButton.layer.borderColor = [UIColor orangeColor].CGColor;
        cell.getTradeButton.tag = indexPath.section;
        [cell.getTradeButton addTarget:self action:@selector(getTrade:) forControlEvents:UIControlEventTouchUpInside];
        
        
        return cell;
    
    
    }
    

}


- (void)getTrade:(UIButton *)sender {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认收货?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *acAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    
    
    PersonalInfo *personInfo = [PersonalInfo share];
//    MyOrderDetailPageCell2 *cell = [self.myOrderDetailPage cellForRowAtIndexPath:[NSIndexPath indexPathWithIndex:sender.tag]];
//    self.array = self.orderDic[@"info"];
    
    NSMutableDictionary *dic = self.array[sender.tag - 1];
    NSMutableURLRequest *request = [InterviewPHPMethod interviewPHP:@"deleteOrder.php" and:[NSString stringWithFormat:@"id=%@&no=%@",personInfo.UserID,dic[@"no"]]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"网络加载失败"];
            });
            return ;
        } else {
//        self.orderDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
//        NSLog(@"dic = %@",self.orderDic);
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.array removeObjectAtIndex:sender.tag - 1];
//            [self.myOrderDetailPage reloadData];
//        });
        NSMutableURLRequest *request1 = [InterviewPHPMethod interviewPHP:@"queryDIYOrder.php" and:[NSString stringWithFormat:@"id=%@",personInfo.UserID]];
        
        NSURLSession *session1 = [NSURLSession sharedSession];
        NSURLSessionDataTask *task1 = [session1 dataTaskWithRequest:request1 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:@"网络加载失败"];
                });
                return ;
            } else {
            NSDictionary *orderDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            self.array = orderDic[@"info"];
       //     NSLog(@"dic = %@",orderDic);
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.myOrderDetailPage reloadData];
            });
            }
        }];
        [task1 resume];
        }
    }];
    [task resume];
        

    
}];
    UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [ac addAction:acAction];
    [ac addAction:returnAction];
    [self presentViewController:ac animated:YES completion:nil];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 120;
    } else {
        return 175;
        
    }


}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.1;
    } else {
    
        return 10;
    }


}

@end
