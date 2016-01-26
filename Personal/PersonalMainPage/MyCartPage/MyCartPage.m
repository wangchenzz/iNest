//
//  MyCartPage.m
//  Personal
//
//  Created by 薛立恒 on 15/10/21.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "MyCartPage.h"
#import "MyCartPageCell.h"
#import "InterviewPHPMethod.h"
#import "PersonalInfo.h"
#import "HeadView.h"
#import "IntroduceController.h"
#import "MBProgressHUD+MJ.h"
#import "cartFootView.h"
#import "ZCTradeView.h"
#import "InterviewPHPMethod.h"
//#define IP "http://192.168.1.112:8888"

@interface MyCartPage ()
@property (nonatomic, retain) NSMutableArray *cartArray;
@property (nonatomic, retain) NSMutableArray *DIYCartArray;
@property (nonatomic, retain) NSMutableArray *collectArray;
@property (nonatomic, retain) NSMutableArray *DIYCollectArray;
//@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) int selectCount;
@property (nonatomic ,retain) cartFootView *cartFoot;
@property (nonatomic, assign) float totalPrice;
@property (nonatomic, retain) NSMutableArray *selectTradeNoArray;



@end

@implementation MyCartPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.cartArray = [NSMutableArray new];
    self.DIYCartArray = [NSMutableArray new];
    self.collectArray = [NSMutableArray new];
    self.DIYCollectArray = [NSMutableArray new];
    
    self.selectCount = 0;
//    self.isSelected = NO;
    self.totalPrice = 0;
    self.selectTradeNoArray = [NSMutableArray new];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zhifujianpanxiayi1:) name:@"zhifujianpan1" object:nil];
    
    self.cartFoot = [[[NSBundle mainBundle]loadNibNamed:@"cartFoot" owner:nil options:nil]firstObject];

    self.cartFoot.totalButton.enabled = NO;
[self.cartFoot setFrame:CGRectMake(0, 518, 320, 50)];
    
}

//添加下方按钮
-(void)addFootView{
    
    
    
    self.cartFoot.totalButton.titleLabel.text = [NSString stringWithFormat:@"结算(%d)",self.selectCount];
    
    [self.cartFoot.totalButton addTarget:self action:@selector(totalCountButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.cartFoot];
    
}

//支付界面完成之后做的动作
- (void)zhifujianpanxiayi1:(NSNotification *)notification {
    
    for (int i = 0; i < self.selectTradeNoArray.count; i++) {
        for (int j = 0; j < self.DIYCartArray.count; j++) {
            if ([self.DIYCartArray[j][@"no"] isEqualToString:self.selectTradeNoArray[i]]) {
                [self.DIYCartArray removeObjectAtIndex:j];
                break;
            }
        }
    }

        PersonalInfo *personInfo = [PersonalInfo share];
        //    [MBProgressHUD showMessage:@"处理中..."];
        NSString *tradeNoStr = [self.selectTradeNoArray componentsJoinedByString:@","];
        NSMutableURLRequest *request = [InterviewPHPMethod interviewPHP:@"deleteShoppingCar.php" and:[NSString stringWithFormat:@"no=%@&id=%@",tradeNoStr,personInfo.UserID]];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([dic[@"code"]intValue] == 200) {
                dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showSuccess:@"支付成功"];
               
                [self.cartFoot.totalButton setTitle:@"结算(0)" forState:UIControlStateNormal];
                
                self.cartFoot.totalPrice.text = @"￥0.00";
                    for (int i = 0; i < self.DIYCartArray.count; i ++) {
                        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
                    MyCartPageCell *cell = [self.cartCollectionView cellForItemAtIndexPath:index];
                        cell.isSelected = NO;
                    }
                    self.totalPrice = 0;
                    self.selectCount = 0;
                    [self.selectTradeNoArray removeAllObjects];
                     [self.cartCollectionView reloadData];
                    if (self.selectCount == 0) {
                        self.cartFoot.totalButton.enabled = NO;
                    } else {
                        
                        self.cartFoot.totalButton.enabled = YES;
                    }
                    
                });
            } else {
            [MBProgressHUD showSuccess:@"支付失败"];
            }
        }];
        [task resume];
        
        //    dispatch_async(dispatch_get_main_queue(), ^{
//        [MBProgressHUD showSuccess:@"支付成功"];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//设置结算按钮的事件
- (void)totalCountButton:(UIButton *)sender {
    
    
    [[[ZCTradeView alloc]init]show];
    

}


//设置有几个分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (self.whichPage == 0) {
        if (self.cartArray.count == 0) {
            return 1;
        } else {
            return 2;
        }
    } else {
    
        if (self.collectArray.count == 0) {
            return 1;
        } else {
            return 2;
        }
    }
    
}

//设置每个分组里面有几个Cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
     if (self.whichPage == 1) {
         if (self.collectArray.count == 0) {
             return self.DIYCollectArray.count;
         } else {
            if (section == 0) {
                return self.collectArray.count;
            } else {
                return self.DIYCollectArray.count;
            
            }
         }
     } else {
         if (self.cartArray.count == 0) {
             return self.DIYCartArray.count;
         } else {
             if (section == 0) {
                 return self.cartArray.count;
             } else {
                 return self.DIYCartArray.count;
                 
             }
         }
     }
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PersonalInfo *personInfo = [PersonalInfo share];
    
    NSMutableDictionary *collectDic = [NSMutableDictionary new];
    NSMutableDictionary *DIYCollectDic =[NSMutableDictionary new];
    NSMutableDictionary *cartDic = [NSMutableDictionary new];
    NSMutableDictionary *DIYCartDic = [NSMutableDictionary new];

    if (self.whichPage == 0) {
        
        if (self.cartArray.count == 0) {
            cartDic = nil;
            DIYCartDic = [self.DIYCartArray objectAtIndex:indexPath.row];
        } else {
            if (indexPath.section == 0) {

                cartDic = [self.DIYCartArray objectAtIndex:indexPath.row];
            }else{

                DIYCartDic = [self.DIYCartArray objectAtIndex:indexPath.row];
            }
        }
        


        MyCartPageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cartCell" forIndexPath:indexPath];
        cell.tickImage.hidden = !cell.isSelected;
        cell.layer.cornerRadius = 2.0;
        cell.clipsToBounds = YES;
        cell.tickImage.layer.cornerRadius = 11.0;
        cell.tickImage.clipsToBounds = YES;
        
        if (self.cartArray.count == 0) {
            cell.cartImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",personInfo.IP,DIYCartDic[@"image"]]]]];
            cell.cartNameLabel.text = DIYCartDic[@"name"];
            cell.cartPriceLabel.text = [NSString stringWithFormat:@"￥%@",DIYCartDic[@"price"]];
            cell.cartLikeCountLabel.text = [NSString stringWithFormat:@"♡ %@",DIYCartDic[@"likeNum"]];
            return cell;
        } else {
        
            if (indexPath.section == 0) {
                
                cell.cartImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",personInfo.IP,cartDic[@"image"]]]]];
                cell.cartNameLabel.text = cartDic[@"name"];
                cell.cartPriceLabel.text = [NSString stringWithFormat:@"￥%@",cartDic[@"price"]];
                cell.cartLikeCountLabel.text = [NSString stringWithFormat:@"♡ %@",cartDic[@"likeNum"]];
                return cell;
            } else {
                cell.cartImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",personInfo.IP,DIYCartDic[@"image"]]]]];
                cell.cartNameLabel.text = DIYCartDic[@"name"];
                cell.cartPriceLabel.text = [NSString stringWithFormat:@"￥%@",DIYCartDic[@"price"]];
                cell.cartLikeCountLabel.text = [NSString stringWithFormat:@"♡ %@",DIYCartDic[@"likeNum"]];
                return cell;
                
            }
        }
    
    } else {
        if (self.collectArray.count == 0) {
            collectDic = nil;
            DIYCollectDic = [self.DIYCollectArray objectAtIndex:indexPath.row];
        } else {
            if (indexPath.section == 0) {
                collectDic = [self.collectArray objectAtIndex:indexPath.row];
    //            cartDic = [self.DIYCartArray objectAtIndex:indexPath.row];
            }else{
                DIYCollectDic = [self.DIYCollectArray objectAtIndex:indexPath.row];
    //            DIYCartDic = [self.DIYCartArray objectAtIndex:indexPath.row];
            }
        }
        
        MyCartPageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cartCell" forIndexPath:indexPath];
        cell.tickImage.hidden = YES;
        cell.layer.cornerRadius = 2.0;
        cell.clipsToBounds = YES;
        if (self.collectArray.count == 0) {
            cell.cartImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",personInfo.IP,DIYCollectDic[@"image"]]]]];
            cell.cartNameLabel.text = DIYCollectDic[@"name"];
            cell.cartPriceLabel.text = [NSString stringWithFormat:@"￥%@",DIYCollectDic[@"price"]];
            cell.cartLikeCountLabel.text = [NSString stringWithFormat:@"♡ %@",DIYCollectDic[@"likeNum"]];
            return cell;
        } else {

            if (indexPath.section == 0) {
            
            cell.cartImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",personInfo.IP,collectDic[@"image"]]]]];
            cell.cartNameLabel.text = collectDic[@"name"];
            cell.cartPriceLabel.text = [NSString stringWithFormat:@"￥%@",collectDic[@"price"]];
            cell.cartLikeCountLabel.text = [NSString stringWithFormat:@"♡ %@",collectDic[@"likeNum"]];
            return cell;
            } else {
                cell.cartImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",personInfo.IP,DIYCollectDic[@"image"]]]]];
                cell.cartNameLabel.text = DIYCollectDic[@"name"];
                cell.cartPriceLabel.text = [NSString stringWithFormat:@"￥%@",DIYCollectDic[@"price"]];
                cell.cartLikeCountLabel.text = [NSString stringWithFormat:@"♡ %@",DIYCollectDic[@"likeNum"]];
                return cell;
            
            }
        }
        
            
    }

}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MyCartPageCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
     NSString *price = [cell.cartPriceLabel.text substringFromIndex:1];
    if (cell.isSelected == YES) {
        cell.isSelected = NO;
        self.selectCount --;
        self.totalPrice = self.totalPrice - [price floatValue];
        [self.selectTradeNoArray removeObject:self.DIYCartArray[indexPath.item][@"no"]];
        
    } else {
        cell.isSelected = YES;
        self.selectCount ++;
        self.totalPrice = self.totalPrice + [price floatValue];
        [self.selectTradeNoArray addObject:self.DIYCartArray[indexPath.item][@"no"]];
        
    }
//    NSLog(@"cell = %@",cell.cartPriceLabel.text);
//    NSLog(@"selectCount = %d",self.selectCount);
//    NSLog(@"totalPrice = %.2f",self.totalPrice);
    cell.tickImage.hidden = !cell.isSelected;
    if (self.selectCount == 0) {
        self.cartFoot.totalButton.enabled = NO;
    } else {
    
        self.cartFoot.totalButton.enabled = YES;
    }
   
    [self.cartFoot.totalButton setTitle:[NSString stringWithFormat:@"结算(%d)",self.selectCount] forState:UIControlStateNormal];
    
    self.cartFoot.totalPrice.text = [NSString stringWithFormat:@"￥%.2f",self.totalPrice];
//点击item进入图文详情
    
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"The" bundle:nil];
//    if (self.whichPage == 0) {
//        
//        if (self.cartArray.count == 0) {
//            IntroduceController *idc = [sb instantiateViewControllerWithIdentifier:@"ic"];
//            idc.selectDIYno = self.DIYCartArray[indexPath.item][@"no"];
//            
//            [self.navigationController pushViewController:idc animated:YES];
//        } else {
//            if (indexPath.section == 0) {
//                IntroduceController *idc = [sb instantiateViewControllerWithIdentifier:@"ic"];
//                idc.selectDIYno = self.cartArray[indexPath.item][@"no"];
//                
//                [self.navigationController pushViewController:idc animated:YES];
//            } else {
//                IntroduceController *idc = [sb instantiateViewControllerWithIdentifier:@"ic"];
//                idc.selectDIYno = self.DIYCartArray[indexPath.item][@"no"];
//                
//                [self.navigationController pushViewController:idc animated:YES];
//            }
//        }
//       
//        
//        
//    } else {
//        if (self.collectArray.count == 0) {
//            IntroduceController *idc = [sb instantiateViewControllerWithIdentifier:@"ic"];
//            idc.selectDIYno = self.DIYCollectArray[indexPath.item][@"no"];
//            
//            [self.navigationController pushViewController:idc animated:YES];
//        } else {
//        
//            if (indexPath.section == 0) {
//                IntroduceController *idc = [sb instantiateViewControllerWithIdentifier:@"ic"];
//                idc.selectDIYno = self.collectArray[indexPath.item][@"no"];
//                
//                [self.navigationController pushViewController:idc animated:YES];
//            } else {
//                IntroduceController *idc = [sb instantiateViewControllerWithIdentifier:@"ic"];
//                idc.selectDIYno = self.DIYCollectArray[indexPath.item][@"no"];
//                
//                [self.navigationController pushViewController:idc animated:YES];
//            }
//        }
//    }

    
    

}

- (void)viewWillAppear:(BOOL)animated {

    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    //显示导航栏
    self.navigationController.navigationBarHidden = NO;
    
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
    
    
    if (self.whichPage == 0) {
        self.title = @"我的购物车";
        [self addFootView];
    } else {
        self.title = @"喜欢的礼物";
        
        
        
    }
    
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.leftBarButtonItem.title = @"< 返回";
    
    self.tabBarController.tabBar.hidden = YES;
    
    if (self.whichPage == 0) {
        PersonalInfo *personInfo = [PersonalInfo share];
        
        NSMutableURLRequest *request = [InterviewPHPMethod interviewPHP:@"ShoppingCar.php" and:[NSString stringWithFormat:@"id=%@",personInfo.UserID]];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:@"网络加载失败"];
                });
                return ;
            } else {
            NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            

            NSMutableDictionary *dic1 = [dic objectForKey:@"info"];

            self.cartArray = [dic1 valueForKey:@"comm"];
            self.DIYCartArray = [dic1 valueForKey:@"DIY"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.cartCollectionView reloadData];
            });
            }
        }];
        [task resume];
    
    } else {
    
        PersonalInfo *personInfo = [PersonalInfo share];
        
        NSMutableURLRequest *request = [InterviewPHPMethod interviewPHP:@"querySaveTradeInfo.php" and:[NSString stringWithFormat:@"id=%@",personInfo.UserID]];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD showError:@"网络加载失败"];
                });
                return ;
            } else {
            NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            NSMutableDictionary *dic1 = dic[@"info"];
            self.collectArray = dic1[@"comm"];
            self.DIYCollectArray = dic1[@"DIY"];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.cartCollectionView reloadData];
            });
            }
        }];
        [task resume];
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    //显示导航栏
    self.navigationController.navigationBarHidden = NO;
    
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
    
    
    if (self.whichPage == 0) {
        self.title = @"我的购物车";
    } else {
        self.title = @"喜欢的礼物";
        
    }
    
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.leftBarButtonItem.title = @"< 返回";
    
    self.tabBarController.tabBar.hidden = YES;
    
    
    //接受服务器里的数据
    

}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        
        HeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        if (self.whichPage == 0) {
            if (self.cartArray.count == 0) {
                if (self.DIYCartArray.count == 0) {
                    
                    headerView.headLabel.text = nil;
                }else {
                    
                    headerView.headLabel.text = @"--DIY订单--";
                }
            } else {
                if (indexPath.section == 0) {
                    if (self.cartArray.count == 0) {
                        
                        headerView.headLabel.text = nil;
                    }else {
       
                        headerView.headLabel.text = @"--淘宝订单--";
                    }
                }else {
                    if (self.DIYCartArray.count == 0) {

                        headerView.headLabel.text = nil;
                    }else {
         
                        headerView.headLabel.text = @"--DIY订单--";
                    }
                }
            }
        } else {
            if (self.collectArray.count == 0) {
                if (self.DIYCollectArray.count == 0) {
                    
                    headerView.headLabel.text = nil;
                }else {
                    
                    headerView.headLabel.text = @"--DIY礼物--";
                }
            } else {
                if (indexPath.section == 0) {
                    if (self.collectArray.count == 0) {
                        
                        headerView.headLabel.text = nil;
                    }else {
                        
                        headerView.headLabel.text = @"--淘宝礼物--";
                    }
                }else {
                    if (self.DIYCollectArray.count == 0) {
                        
                        headerView.headLabel.text = nil;
                    }else {
                        
                        headerView.headLabel.text = @"--DIY礼物--";
                    }
                }
            }
        
        }
 
        reusableview = headerView;
        
    }
    return reusableview;

}

//设置item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(142, 200);
}

//设置行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//设置每个section与周边的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
    
}
@end
