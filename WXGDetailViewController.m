//
//  WXGDetailViewController.m
//  SlideMenu
//
//  Created by Nicholas Chow on 15/7/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGDetailViewController.h"
#import "WXGMenuItem.h"
#import "IntroduceController.h"
#import "DIYCell.h"
#import "UpSaleController.h"
#import "UPSaleFirstController.h"
#import "NSSktTOne.h"
#import "PersonalInfo.h"
#import "LoginPage.h"
#import "MBProgressHUD+MJ.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

#define SCRREN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCRREN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCOLE_VALUE .5

@interface WXGDetailViewController ()<UITableViewDelegate,UITableViewDataSource,IntroduceControllerDelagete>


@property (nonatomic, weak) UIImageView *hamburger;



@property (nonatomic)NSArray *leftAry;

@property (nonatomic, strong) NSMutableArray *personalLikedGift;




@end

@implementation WXGDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // UIBarButtonItem的initWithCustomView:方法会对内部控件有特殊约束
    // 直接将hamburger添加上去会无法实现滚动效果
    // 解决办法：将hamburger包装在一个view里面
    UIView *wrapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hamburgerClick)];
    [wrapView addGestureRecognizer:tap];
    
    UIImageView *hamburger = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Hamburger"]];
    self.hamburger = hamburger;
    
    [wrapView addSubview:hamburger];
    
    self.getRspndDic = [NSMutableDictionary new];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:wrapView];
    ////////////////////////////////////_______________________________////////////////////////
    self.getRspndDic = [NSMutableDictionary new];
    self.personalLikedGift = [NSMutableArray new];
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
    
    self.title = @"DIY";
    
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    //修改返回键颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    self.leftAry = @[@"饰品挂件",@"手工纺织品",@"手工装饰",@"其他",@"人气排行"];
    
    [self creatTableview];
    
 //   [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectlike:) name:@"ilikeit" object:nil];
    
}

// 顶部hamburger按钮点击事件
- (void)hamburgerClick {
    if (self.hamburgerDidClick) {
        self.hamburgerDidClick();
    }
}

// 顶部hamburger按钮滚动效果
- (void)rotateHamburgerWithScale:(CGFloat)scale {
    CGFloat angle = M_PI_2 * (1 - scale);
    self.hamburger.transform = CGAffineTransformMakeRotation(angle);
}

- (IBAction)upasle:(UIBarButtonItem *)sender {
    
    
    self.upSale();

    
}

- (void)setItem:(WXGMenuItem *)item {
    _item = item;
    CGFloat r = [item.colors[0] doubleValue];
    CGFloat g = [item.colors[1] doubleValue];
    CGFloat b = [item.colors[2] doubleValue];
    self.view.backgroundColor = [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1];
}


- (void)headLoading {
    
    
    NSSktTOne *skt1 = [NSSktTOne shareskt];
    
    [PersonalInfo share].DIYtradeTypeNo = nil;
    
    [skt1 getRequeset:[skt1 requestforPhpfile:@"queryDIYOrderDate.php"] :^(NSData *dat, NSError *er, NSDictionary *dic) {
        self.getRspndDic = [NSJSONSerialization JSONObjectWithData:dat options:NSJSONReadingMutableContainers error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableview reloadData];
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
    
    
    PersonalInfo *personInfo = [PersonalInfo share];
    
    
    if (personInfo.DIYtradeTypeNo.length == 0) {
        NSSktTOne *skt1 = [NSSktTOne shareskt];
        
        NSMutableArray *arrrrr = [[self.getRspndDic objectForKey:@"info"]mutableCopy];
        //[self.getRspndDic objectForKey:@"info"];
        
        NSString*selstr =[NSString stringWithFormat:@"time=%@&type=%@&count=%@",personInfo.refreshDate,@"DIYAddedDate",[NSString stringWithFormat:@"desc limit %ld,3",arrrrr.count]];
        
        [skt1 requeset:[skt1 requestForObject:selstr somePhpFile:@"DownLoading.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
            
            NSMutableDictionary *newdic = [NSJSONSerialization JSONObjectWithData:dat options:NSJSONReadingMutableContainers error:nil];
            
            [arrrrr addObjectsFromArray:[newdic objectForKey:@"info"]];
            [self.getRspndDic removeObjectForKey:@"info"];
            [self.getRspndDic setObject:arrrrr forKey:@"info"];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableview reloadData];
                [self.tableview.footer endRefreshing];
                
            });
            //@"desc limit %@,3"
            
        }];
        
        
        
        [skt1 requeset:[skt1 requestForObject:[NSString stringWithFormat:@"id=%@",[PersonalInfo share].UserID] somePhpFile:@"querySave.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
            for (NSDictionary *dic in [ary objectForKey:@"info"]) {
                [self.personalLikedGift addObject:[dic objectForKey:@"no"]];
            }
        }];
    } else {
        
        NSSktTOne *skt1 = [NSSktTOne shareskt];
        
        NSArray *arrrrr = [self.getRspndDic objectForKey:@"info"];
        
        NSString*selstr =[NSString stringWithFormat:@"time=%@&typeno=%@&type=%@&count=%@",personInfo.refreshDate,personInfo.DIYtradeTypeNo,@"DIYAddedDate",[NSString stringWithFormat:@"desc limit %ld,3",arrrrr.count]];
        
        [skt1 requeset:[skt1 requestForObject:selstr somePhpFile:@"UpLoading.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
            [[self.getRspndDic objectForKey:@"info"]addObjectsFromArray:[ary objectForKey:@"info"]];
            //        NSMutableArray *arr = [NSMutableArray new];
            //        arr addObjectsFromArray:<#(nonnull NSArray *)#>
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableview reloadData];
                [self.tableview.header endRefreshing];
            });
            //@"desc limit %@,3"
            
        }];
        
        self.personalLikedGift = [NSMutableArray new];
        
        [skt1 requeset:[skt1 requestForObject:[NSString stringWithFormat:@"id=%@",[PersonalInfo share].UserID] somePhpFile:@"querySave.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
            for (NSDictionary *dic in [ary objectForKey:@"info"]) {
                [self.personalLikedGift addObject:[dic objectForKey:@"no"]];
            }
        }];
        
    }
    
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    NSSktTOne *skt1 = [NSSktTOne shareskt];
 
    self.personalLikedGift = [NSMutableArray new];
    
    [skt1 requeset:[skt1 requestForObject:[NSString stringWithFormat:@"id=%@",[PersonalInfo share].UserID] somePhpFile:@"querySave.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
        
        [self.personalLikedGift removeAllObjects];
        
        for (NSDictionary *dic in [ary objectForKey:@"info"]) {
            [self.personalLikedGift addObject:[dic objectForKey:@"no"]];
        }
    }];
    
    
    //开始上拉下拉刷新
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headLoading)];
    
    self.tableview.header.automaticallyChangeAlpha = YES;
    
    
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footLoading)];
    
    
    
}


#pragma mark  - 弃用的通知传递喜欢按钮点击事件
//-(void)selectlike:(NSNotification*)notific{
//    
//    NSSktTOne*skt1 = [NSSktTOne shareskt];
//    
//    NSString *objecStr = [NSString stringWithFormat:@"no=%@&id=%@",[notific object],[PersonalInfo share].UserID];
//    
//    //添加或者删除喜好的东西到表中
//    [skt1 requeset:[skt1 requestForObject:objecStr somePhpFile:@"queryDIYTradeUserSave.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
//        
//    }];
//    
//    
//
//    NSMutableArray *mutary = [NSMutableArray arrayWithArray:[self.getRspndDic objectForKey:@"info"]];
//    
//    for (NSMutableDictionary *dic in mutary){
//    
//        if ([[dic objectForKey:@"no"] isEqualToString:[notific object]]) {
//                if ([self.personalLikedGift containsObject:[notific object]]) {
//                    NSString *num = [dic objectForKey:@"likeNum"];
//            
//                    NSString *newnum = [NSString stringWithFormat:@"%ld",[num integerValue] - 1];
//            
//            
//                    [dic setObject:newnum forKey:@"likeNum"];
//            
//                }else{
//                    NSString *num = [dic objectForKey:@"likeNum"];
//                    
//                    NSString *newnum = [NSString stringWithFormat:@"%ld",[num integerValue] + 1];
//                    
//                    
//                    [dic setObject:newnum forKey:@"likeNum"];
//                }
//            
//            
//        }
//        
//    
//    
//    }
//    
//    dispatch_async(dispatch_get_main_queue(), ^{
//    
//        [self.tableview reloadData];
//      //  [self performSelector:@selector(load:) withObject:tapnumber afterDelay:0.6];
//    });
//}

-(void)creatTableview{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCRREN_WIDTH, SCRREN_HEIGHT-64-49) style:UITableViewStylePlain];
    
    
    
    [self.tableview setDelegate:self];
   
    [self.tableview setDataSource:self];
    
    [self.view addSubview:self.tableview];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
  
        
        NSArray *ay = [self.getRspndDic objectForKey:@"info"];
        return ay.count;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    return 1;
    
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        
        
        DIYCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"diycell"];
        
        if (!cell) {
            cell = [[DIYCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"diycell"];
        }
        
        NSString *imageurlstr = [[NSSktTOne shareskt].ipstr copy];
        
        NSString *imagestr = [imageurlstr stringByAppendingString:[[[self.getRspndDic objectForKey:@"info"]objectAtIndex:indexPath.row]objectForKey:@"image"]];
        
        [cell.imagep sd_setImageWithURL:[NSURL URLWithString:imagestr] placeholderImage:[UIImage imageNamed:@"cg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        cell.jslabel.text = [[[self.getRspndDic objectForKey:@"info"]objectAtIndex:indexPath.row]objectForKey:@"name"];
        
        NSString *str = [[[self.getRspndDic objectForKey:@"info"]objectAtIndex:indexPath.row]objectForKey:@"likeNum"];
        
        cell.blackimage.image = [UIImage imageNamed:@"blackimage"];
        
        
        cell.numlabel.text = str;
        
        if ([self.personalLikedGift containsObject:[[[self.getRspndDic objectForKey:@"info"]objectAtIndex:indexPath.row]objectForKey:@"no"]]) {
            
            
            
            cell.isLikeView.image = [UIImage imageNamed:@"xihuan"];
            
            
            
            
        }else{
            
            cell.isLikeView.image = [UIImage imageNamed:@"dontxihuan"];
            
            
        }
        
        
        //增加手势;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xihuan:)];
        
        tap.numberOfTapsRequired = 1;
        
        tap.numberOfTouchesRequired = 1;
        
        
        
        [cell.sclabel addGestureRecognizer:tap];
        
        
        
        [cell.sclabel setUserInteractionEnabled:YES];
        
        
        //让tablecell点中不再高亮;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
        
    }

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
   
    return 140;
    
       
}

//喜欢按钮的事件;

-(void)xihuan:(UITapGestureRecognizer*)sender{
    
    
    PersonalInfo *personalInfo = [PersonalInfo share];
    
    //这里是选中了第几行
    if (personalInfo.UserID.length != 0){
        
    //这里得到点击了第几行的按钮
        CGPoint location = [sender locationInView:self.tableview];
        
        NSIndexPath *tapnumber = [_tableview indexPathForRowAtPoint:location];
        
    //第一步修改数据库;
        
        NSSktTOne*skt1 = [NSSktTOne shareskt];
        
        NSString *objecStr = [NSString stringWithFormat:@"no=%@&id=%@",[[[self.getRspndDic objectForKey:@"info"]objectAtIndex:tapnumber.row]objectForKey:@"no"],[PersonalInfo share].UserID];
        
        
        DIYCell *cell = [self.tableview cellForRowAtIndexPath:tapnumber];
        
        cell.isLikeView.image = [UIImage imageNamed:@"xihuan"];
        
        CABasicAnimation *amt = [CABasicAnimation animation];
        amt.keyPath = @"transform.scale";
        amt.fromValue = [NSNumber numberWithFloat:0.5];
        amt.toValue = [NSNumber numberWithFloat:1.5];
        
        CAAnimationGroup *groupAnnimation = [CAAnimationGroup animation];
        groupAnnimation.duration = 0.3;
        groupAnnimation.autoreverses = YES;
        groupAnnimation.animations = @[amt];
        groupAnnimation.repeatCount = 1;
        
        [cell.isLikeView.layer addAnimation:groupAnnimation forKey:@"groupAnnimation"];
        
        
        //添加或者删除喜好的东西到表中
        [skt1 requeset:[skt1 requestForObject:objecStr somePhpFile:@"queryDIYTradeUserSave.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
            
            //在目标表中检测数据
            [skt1 requeset:[skt1 requestForObject:[NSString stringWithFormat:@"id=%@",[PersonalInfo share].UserID] somePhpFile:@"querySave.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
                
                [self.personalLikedGift removeAllObjects];
                for (NSDictionary *dic in [ary objectForKey:@"info"]) {
                    
                    [self.personalLikedGift addObject:[dic objectForKey:@"no"]];
                    
                }
                
                if ([self.personalLikedGift containsObject:[[[self.getRspndDic objectForKey:@"info"]objectAtIndex:tapnumber.row]objectForKey:@"no"]]) {
                    NSString *num = [[[self.getRspndDic objectForKey:@"info"]objectAtIndex:tapnumber.row]objectForKey:@"likeNum"];
                    
                    NSString *newnum = [NSString stringWithFormat:@"%ld",[num integerValue] + 1];
                    
                    
                    [[[self.getRspndDic objectForKey:@"info"]objectAtIndex:tapnumber.row]setObject:newnum forKey:@"likeNum"];
                    
                }else{
                    NSString *num = [[[self.getRspndDic objectForKey:@"info"]objectAtIndex:tapnumber.row]objectForKey:@"likeNum"];
                    NSString *newnum = [NSString stringWithFormat:@"%ld",[num integerValue] - 1];
                    [[[self.getRspndDic objectForKey:@"info"]objectAtIndex:tapnumber.row]setObject:newnum forKey:@"likeNum"];
                    
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self performSelector:@selector(load:) withObject:tapnumber afterDelay:0.6];
                });
                
            }];
            
        }];
        
        
        
        
        
        
    }else{
        
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"nowlogin" object:nil];
        
        
    }
    
    
    
    //    NSIndexPath *selectro = self.tableview.indexPathForSelectedRow;
    //    
    //    NSLog(@"这里是选中的%ld%ld",selectro.row,selectro.section);
    
}



-(void)load:(NSIndexPath*)ss{
    [self.tableview reloadRowsAtIndexPaths:@[ss] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"The" bundle:nil];
    
    IntroduceController *ic = [sb instantiateViewControllerWithIdentifier:@"ic"];
    
    //此处要讲商品编号发送过去 以取得商品的具体信息 拟决定使用属性传值方法;
    
    NSString *selectDIYNo = [[[self.getRspndDic objectForKey:@"info"]objectAtIndex:indexPath.row]objectForKey:@"no"];
    
    ic.delegate = self;
    
    
    if ([self.personalLikedGift containsObject:[[[self.getRspndDic objectForKey:@"info"]objectAtIndex:indexPath.row]objectForKey:@"no"]]) {
        ic.isLie = NO;
    }else{
        
        ic.isLie = YES;
    }
    
    //调用注册的属性;
    
    self.teMeLo(selectDIYNo,ic);
        
}


#pragma mark-IntroduceControllerdelegate 的实现


-(void)IntroduceControllerDidClickLike:(IntroduceController *)controller likeNum:(NSString *)DIYNo{

    NSSktTOne*skt1 = [NSSktTOne shareskt];
    
    NSString *objecStr = [NSString stringWithFormat:@"no=%@&id=%@",DIYNo,[PersonalInfo share].UserID];
    
    //添加或者删除喜好的东西到表中
    [skt1 requeset:[skt1 requestForObject:objecStr somePhpFile:@"queryDIYTradeUserSave.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
        
    }];
    
    
    
    NSMutableArray *mutary = [NSMutableArray arrayWithArray:[self.getRspndDic objectForKey:@"info"]];
    
    for (NSMutableDictionary *dic in mutary){
        
        if ([[dic objectForKey:@"no"] isEqualToString:DIYNo]) {
            if ([self.personalLikedGift containsObject:DIYNo]) {
                NSString *num = [dic objectForKey:@"likeNum"];
                
                NSString *newnum = [NSString stringWithFormat:@"%ld",[num integerValue] - 1];
                
                
                [dic setObject:newnum forKey:@"likeNum"];
                
            }else{
                NSString *num = [dic objectForKey:@"likeNum"];
                
                NSString *newnum = [NSString stringWithFormat:@"%ld",[num integerValue] + 1];
                
                
                [dic setObject:newnum forKey:@"likeNum"];
            }
            
            
        }
        
        
        
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableview reloadData];
        //  [self performSelector:@selector(load:) withObject:tapnumber afterDelay:0.6];
    });

    


}

@end
