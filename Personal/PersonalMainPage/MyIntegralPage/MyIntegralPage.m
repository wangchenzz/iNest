//
//  MyIntegralPage.m
//  Personal
//
//  Created by xlh on 15/10/31.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "MyIntegralPage.h"
#import "PersonalInfo.h"
#import "MyIntegralPageCell1.h"
#import "MyIntegralPageCell2.h"
#import "MyIntegralPageCell3.h"
#import "IntegralRulePage.h"
#import "InterviewPHPMethod.h"
#import "PersonalInfo.h"
#import "MBProgressHUD+MJ.h"
//#define IP "http://192.168.2.15:8888"

@interface MyIntegralPage ()

@property (nonatomic, retain) NSArray *integralArray;

@end

@implementation MyIntegralPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *path = [[NSBundle mainBundle]pathForResource:@"MyIntegralPage" ofType:@"plist"];
    self.integralArray = [NSArray arrayWithContentsOfFile:path];
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
    
    
    self.title = @"我的积分";
    
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.leftBarButtonItem.title = @"< 返回";
    
    self.tabBarController.tabBar.hidden = YES;
    
    PersonalInfo *personInfo = [PersonalInfo share];
   // NSLog(@"%@",personInfo.integralCount);
    
    
    NSMutableURLRequest *request = [InterviewPHPMethod interviewPHP:@"Search.php" and:[NSString stringWithFormat:@"UserID=%@",personInfo.UserID]];
    
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        personInfo.integralCount = dic[@"result4"];
    }];
    [task resume];
}


//设置有几个分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}

//设置每个分组里面有几个Cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PersonalInfo *personInfo = [PersonalInfo share];
    
    if (indexPath.row == 0) {
        MyIntegralPageCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myIntegralPageCell1" forIndexPath:indexPath];
        
        return cell;
    } else if (indexPath.row == 1) {
        MyIntegralPageCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myIntegralPageCell2" forIndexPath:indexPath];
        cell.personalHeadImage.image = [UIImage imageWithData:personInfo.ImageData];
        cell.personalHeadImage.layer.cornerRadius = 25.0;
        cell.personalHeadImage.clipsToBounds = YES;
        cell.userName.text = personInfo.UserName;
        cell.integralCount.text = personInfo.integralCount;
        
        cell.integralRule.layer.cornerRadius = 2.0;
        cell.integralRule.clipsToBounds = YES;
        cell.integralRule.layer.borderWidth = 1.0;
        cell.integralRule.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        return cell;
    
    
    } else {
        NSDictionary *integralDic = self.integralArray[indexPath.row - 2];
        
        
        MyIntegralPageCell3 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myIntegralPageCell3" forIndexPath:indexPath];
        cell.giftImage.image = [UIImage imageNamed:integralDic[@"Image"]];
        cell.giftName.text = integralDic[@"name"];
        cell.integralNeed.text = integralDic[@"integral"];
        
        cell.exchangeButton.layer.cornerRadius = 2.0;
        cell.exchangeButton.clipsToBounds = YES;
        [cell.exchangeButton addTarget:self action:@selector(exchangeButton:) forControlEvents:UIControlEventTouchUpInside];
        [cell.exchangeButton setTag:indexPath.item ];
      //  NSLog(@"tag = %ld",cell.exchangeButton.tag);
        
        return cell;
    }

}


//设置item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return CGSizeMake(320, 50);
    } else if (indexPath.row == 1) {
        return CGSizeMake(304, 89);
    } else {
    
        return CGSizeMake(304, 140);
    }
    
}

//设置行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//设置每个section与周边的间距
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//    
//}

- (IBAction)integralRule:(UIButton *)sender {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
    
    IntegralRulePage *irp = [sb instantiateViewControllerWithIdentifier:@"integralRulePage"];
    
    
    [self.navigationController pushViewController:irp animated:YES];
}

- (void)exchangeButton:(UIButton *)sender{
    PersonalInfo *personInfo = [PersonalInfo share];
    
    
    NSIndexPath *index = [NSIndexPath indexPathForItem:sender.tag inSection:0];
    MyIntegralPageCell3 *cell = (MyIntegralPageCell3 *)[self.myIntegralCollectionView cellForItemAtIndexPath:index];
    if (sender.tag == 7 || sender.tag == 8) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定兑换此优惠券?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *checkAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showMessage:@"处理中..."];
            });
           
            NSMutableURLRequest *request1 = [InterviewPHPMethod interviewPHP:@"GradeExchange.php" and:[NSString stringWithFormat:@"id=%@&grade=%@",personInfo.UserID,cell.integralNeed.text]];
            
            
            NSURLSession *session1 = [NSURLSession sharedSession];
            NSURLSessionDataTask *task1 = [session1 dataTaskWithRequest:request1 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:@"网络加载失败"];
//                        cell.integralNeed.text = @"0";
                        
                    });
                    return ;
                } else {
                
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
             //   NSLog(@"dic = %@",dic);
                if (dic[@"error"] == nil || dic[@"error"] == [NSNull null]) {
//                    if ([dic[@"error" ] isEqualToString:@"<null>"]) {
//                        NSLog(@"sdfsdfsdfsdf");
//                    } else
                    if (dic[@"error"] == [NSNull null]) {
                       // NSLog(@"%@",dic[@"error"]);
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [MBProgressHUD hideHUD];
                            //[MBProgressHUD showError:@"兑换失败!"];
                             [MBProgressHUD showSuccess:@"兑换成功!"];
                            NSMutableURLRequest *request = [InterviewPHPMethod interviewPHP:@"InsertCoupon.php" and:[NSString stringWithFormat:@"id=%@&cou=%@",personInfo.UserID,[NSString stringWithFormat:@"%ld",20*sender.tag - 122]]];
                            
                            
                            NSURLSession *session = [NSURLSession sharedSession];
                            NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                
                                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                                if ([dic[@"info"] isEqualToString:@"is success"]) {
                                 //   NSLog(@"添加购物券成功!");
                                }
                                
                            }];
                            [task resume];
                        });
                    } else {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            personInfo.integralCount = dic[@"info"][@"index"][@"grade"];
                            
                            [self.myIntegralCollectionView reloadData];
                            [MBProgressHUD hideHUD];
                            [MBProgressHUD showSuccess:@"兑换成功!"];
                        });
                    }
                    
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [MBProgressHUD hideHUD];
                        [MBProgressHUD showError:@"兑换失败!您的积分可能不够哦~"];
                    });
                }
                }
                
            }];
            [task1 resume];
            
        }];
        
        [ac addAction:returnAction];
        [ac addAction:checkAction];
        
        [self presentViewController:ac animated:YES completion:nil];
        
    } else {
        
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定兑换此礼品?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *checkAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
             dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showMessage:@"处理中..."];
                 });
            NSMutableURLRequest *request = [InterviewPHPMethod interviewPHP:@"GradeExchange.php" and:[NSString stringWithFormat:@"id=%@&grade=%@",personInfo.UserID,cell.integralNeed.text]];
            
            
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
             //   NSLog(@"dic = %@",dic);
                if (dic[@"error"] == nil || dic[@"error"] == [NSNull null]) {
                    if (dic[@"error"] == nil) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             [MBProgressHUD hideHUD];
                             [MBProgressHUD showError:@"兑换失败!"];
                        });
                    } else {
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            personInfo.integralCount = dic[@"info"][@"index"][@"grade"];
                            
                            [self.myIntegralCollectionView reloadData];
                            [MBProgressHUD hideHUD];
                            [MBProgressHUD showSuccess:@"兑换成功!"];
                        });
                    }
                    
                    
                    } else {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [MBProgressHUD hideHUD];
                            [MBProgressHUD showError:@"兑换失败!您的积分可能不够哦~"];
                        });
                }
                }
                
            }];
            [task resume];
            
        }];
        
        
        [ac addAction:returnAction];
        [ac addAction:checkAction];
        
        [self presentViewController:ac animated:YES completion:nil];
        
    }
}
@end
