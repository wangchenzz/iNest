//
//  TheController.m
//  LeeNote
//
//  Created by administrator on 15/10/13.
//  Copyright © 2015年 administrator. All rights reserved.
//
#import "IntroduceController.h"
#import "TheController.h"
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
@interface TheController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>



@property (nonatomic, strong) NSMutableDictionary *getRspndDic;

@property (nonatomic)NSArray *leftAry;

@property (nonatomic, strong) NSMutableArray *personalLikedGift;

@end

@implementation TheController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.getRspndDic = [NSMutableDictionary new];
    self.personalLikedGift = [NSMutableArray new];
   
   // __block NSString *ab  = @"dasdas";
    
   
    
   // [[NSSktTOne shareskt]uploadImage:@"abc" filename:@"12.jpg" mimeType:@"image/jpg" data:data parmas:nil];
    

   
    //创建left button...
    
    [self creatLeftBarbutton];
    

    

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
    
    [self.view addSubview:self.Mainscroolview];
    
    [_Mainscroolview setContentOffset:CGPointMake(SCRREN_WIDTH*SCOLE_VALUE, 0)];
    
    
    //将cell间的线条消去;
    _AddTableView.separatorStyle = NO;
    _MainTableview.separatorStyle = NO;

    //调用取消多余分割线的函数
 //   [self setExtraCellLineHidden:self.tabBarItem];
    
    
    NSSktTOne *skt1 = [NSSktTOne shareskt];
        [skt1 getRequeset:[skt1 requestforPhpfile:@"queryDIYOrderDate.php"] :^(NSData *dat, NSError *er, NSDictionary *dic) {
            self.getRspndDic = [NSJSONSerialization JSONObjectWithData:dat options:NSJSONReadingMutableContainers error:nil];
    
    
            dispatch_async(dispatch_get_main_queue(), ^{
                [_MainTableview reloadData];
    
    
            });
        }];

    

    

}

- (void)headLoading {
    

    NSSktTOne *skt1 = [NSSktTOne shareskt];
    
    [skt1 getRequeset:[skt1 requestforPhpfile:@"queryDIYOrderDate.php"] :^(NSData *dat, NSError *er, NSDictionary *dic) {
        self.getRspndDic = [NSJSONSerialization JSONObjectWithData:dat options:NSJSONReadingMutableContainers error:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_MainTableview reloadData];
            [self.MainTableview.header endRefreshing];
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
                
                [_MainTableview reloadData];
               [self.MainTableview.footer endRefreshing];
            
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
                [_MainTableview reloadData];
                [self.MainTableview.header endRefreshing];
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
//    [skt1 getRequeset:[skt1 requestforPhpfile:@"queryDIYOrderDate.php"] :^(NSData *dat, NSError *er, NSDictionary *dic) {
//        self.getRspndDic = [NSJSONSerialization JSONObjectWithData:dat options:NSJSONReadingMutableContainers error:nil];
//        
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [_MainTableview reloadData];
//
//            
//        });
//    }];
    
    
    self.personalLikedGift = [NSMutableArray new];
    
    [skt1 requeset:[skt1 requestForObject:[NSString stringWithFormat:@"id=%@",[PersonalInfo share].UserID] somePhpFile:@"querySave.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
        for (NSDictionary *dic in [ary objectForKey:@"info"]) {
            [self.personalLikedGift addObject:[dic objectForKey:@"no"]];
        }
    }];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(selectlike:) name:@"ilikeit" object:nil];
    
    //开始上拉下拉刷新
    self.MainTableview.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headLoading)];
    
    self.MainTableview.header.automaticallyChangeAlpha = YES;
    
    
    self.MainTableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footLoading)];
    
    
    
}

-(void)selectlike:(NSNotification*)notific{
    
    NSSktTOne*skt1 = [NSSktTOne shareskt];
    
    NSString *objecStr = [NSString stringWithFormat:@"no=%@&id=%@",[notific object],[PersonalInfo share].UserID];
    
    //添加或者删除喜好的东西到表中
    [skt1 requeset:[skt1 requestForObject:objecStr somePhpFile:@"queryDIYTradeUserSave.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
        
        
        
        
    }];
}


#pragma mark--改
-(void)creatLeftBarbutton{
    
    UIButton *butin = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 24, 24)];
    
    [butin setBackgroundImage:[[UIImage imageNamed:@"firstleft"]imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    [butin addTarget:self action:@selector(leftbutton:) forControlEvents:UIControlEventTouchUpInside];
    
  //  UIBarButtonItem *leftbarbutton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"firstleft"] style:UIBarButtonItemStylePlain target:self action:@selector(leftbutton:)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:butin];
    
    //[self.navigationItem setLeftBarButtonItem:leftbarbutton];
}


#pragma mark--改
-(void)leftbutton:(UIButton*)sender{
    if (_Mainscroolview.contentOffset.x == SCRREN_WIDTH*SCOLE_VALUE) {
        
    
    [UIView animateWithDuration:0.5 animations:^{
         _Mainscroolview.contentOffset = CGPointMake(0, 0) ;
    }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
            _Mainscroolview.contentOffset = CGPointMake(SCRREN_WIDTH*SCOLE_VALUE, 0) ;
        }];
    }
}

#pragma mark--大改
-(UIScrollView*)Mainscroolview{
    
    UIImageView *backroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCRREN_WIDTH, SCRREN_HEIGHT)];
    
    backroundImage.image = [UIImage imageNamed:@"xinkong.jpg"];
    
    
    backroundImage.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.view addSubview:backroundImage];
    _Mainscroolview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCRREN_WIDTH, SCRREN_HEIGHT)];
    
    _Mainscroolview.contentSize = CGSizeMake(SCRREN_WIDTH*(1+SCOLE_VALUE), SCRREN_HEIGHT);
    _Mainscroolview.pagingEnabled = YES;
    
    _Mainscroolview.bounces = NO;
    
    _Mainscroolview.delegate = self;
    

    
    //此处设置左侧添加视图;
    _Addview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCRREN_WIDTH, SCRREN_HEIGHT-64)];
   
    [_Addview setBackgroundColor:[UIColor clearColor]];
    
    [_Mainscroolview addSubview:_Addview];
    
    [_Mainscroolview setBackgroundColor:[UIColor clearColor]];
    
    _AddTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCRREN_WIDTH*SCOLE_VALUE, SCRREN_HEIGHT-64) style:UITableViewStyleGrouped];
    
    _AddTableView.backgroundColor = [UIColor clearColor];
    
    
    //////////
    
    [_AddTableView setDelegate:self];
    [_AddTableView setDataSource:self];
    
    [_Addview addSubview:_AddTableView];
    
    //此处添加主界面
    
    _Mainview = [[UIView alloc]initWithFrame:CGRectMake(SCRREN_WIDTH*SCOLE_VALUE, 0, SCRREN_WIDTH, SCRREN_HEIGHT-64)];

    
    //创建主界面上的tableview
    _MainTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCRREN_WIDTH, SCRREN_HEIGHT-64-49) style:UITableViewStylePlain];
    

    
    [_MainTableview setDelegate:self];
    [_MainTableview setDataSource:self];
    
    [_Mainview addSubview:_MainTableview];
    [_Mainscroolview addSubview:_Mainview];
    
    return _Mainscroolview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    if (tableView == _MainTableview) {
        
        NSArray *ay = [self.getRspndDic objectForKey:@"info"];
        return ay.count;
        
    }else{
        
        return 5;
    }
    

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    
    return 1;
    
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView == _MainTableview) {
        
        
        DIYCell *cell = [_MainTableview dequeueReusableCellWithIdentifier:@"diycell"];
        
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

        
    }else{
        
        UITableViewCell *cell = [_AddTableView dequeueReusableCellWithIdentifier:@"addcell"];
        
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"addcell"];
            [cell setBackgroundColor:[UIColor clearColor]];
        }
        cell.textLabel.text = [self.leftAry objectAtIndex:indexPath.row];
        [cell.textLabel setTextColor:[UIColor colorWithWhite:1 alpha:1]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       // cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
        [cell.imageView setTintColor:[UIColor colorWithWhite:0.9 alpha:0.8]];
        cell.imageView.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.row+1]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        return cell;
    }

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (tableView == _MainTableview) {
        
        return 140;
        
    }else{
        
        return 44;
    }

}


//跳转到我要上架页面;
- (IBAction)UpSale:(UIButton *)sender {

    PersonalInfo *personalInfo = [PersonalInfo share];
    
    
    if (personalInfo.UserID.length != 0){
    
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"The" bundle:nil];
        
        UPSaleFirstController *usc = [sb instantiateViewControllerWithIdentifier:@"first"];
        
        [self.navigationController pushViewController:usc animated:YES];

    
    }else{
        
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

//喜欢按钮的事件;

-(void)xihuan:(UITapGestureRecognizer*)sender{
    PersonalInfo *personalInfo = [PersonalInfo share];

    
    
    //这里是选中了第几行
    if (personalInfo.UserID.length != 0){
        
        //这里得到点击了第几行的按钮
        CGPoint location = [sender locationInView:_MainTableview];
        NSIndexPath *tapnumber = [_MainTableview indexPathForRowAtPoint:location];
        
       
        
        // NSLog(@"点中了第几行%ld",(long)tapnumber.row);
        
#pragma mark --celikshua    //第一步修改数据库;
        NSSktTOne*skt1 = [NSSktTOne shareskt];
        
        NSString *objecStr = [NSString stringWithFormat:@"no=%@&id=%@",[[[self.getRspndDic objectForKey:@"info"]objectAtIndex:tapnumber.row]objectForKey:@"no"],[PersonalInfo share].UserID];
        
        
        DIYCell *cell = [self.MainTableview cellForRowAtIndexPath:tapnumber];

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
                
//                NSSktTOne *skt1 = [NSSktTOne shareskt];
//                [skt1 getRequeset:[skt1 requestforPhpfile:@"queryDIYOrderliked.php"] :^(NSData *dat, NSError *er, NSDictionary *dic) {
//                    self.getRspndDic = [NSMutableDictionary dictionaryWithDictionary:dic];
//                    
//                    
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        
//                        [self performSelector:@selector(load:) withObject:tapnumber afterDelay:0.6];
//                    });
//                }];
                
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

    
    
//    NSIndexPath *selectro = self.tableview.indexPathForSelectedRow;
//    
//    NSLog(@"这里是选中的%ld%ld",selectro.row,selectro.section);
    
}



-(void)load:(NSIndexPath*)ss{
                        [_MainTableview reloadRowsAtIndexPaths:@[ss] withRowAnimation:UITableViewRowAnimationNone];
}


//删除 配合手势不再显示;
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    NSLog(@"我在这里删除");
//    
//    //此处发送删除通知; 以集中;
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"wudi" object:indexPath];
//}


//点击选中的cell后的跳转;

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _MainTableview) {
           UIStoryboard *sb = [UIStoryboard storyboardWithName:@"The" bundle:nil];
    
    IntroduceController *ic = [sb instantiateViewControllerWithIdentifier:@"ic"];
    
    //此处要讲商品编号发送过去 以取得商品的具体信息 拟决定使用属性传值方法;

        NSString *selectDIYNo = [[[self.getRspndDic objectForKey:@"info"]objectAtIndex:indexPath.row]objectForKey:@"no"];
       
        
        if ([self.personalLikedGift containsObject:[[[self.getRspndDic objectForKey:@"info"]objectAtIndex:indexPath.row]objectForKey:@"no"]]) {
            ic.isLie = NO;
        }else{
            
            ic.isLie = YES;
        }
        
        ic.selectDIYno = selectDIYNo;
        
        
    
    [self.navigationController pushViewController:ic animated:YES];
        
    }else{
        
        
        [MBProgressHUD showMessage:@"loading..."];
        
        NSArray *ary = @[@"1201",@"1202",@"1203",@"1204"];
        
        [MBProgressHUD hideHUD];
        
       
        
        [UIView animateWithDuration:0.5 animations:^{
            _Mainscroolview.contentOffset = CGPointMake(SCRREN_WIDTH*SCOLE_VALUE, 0) ;
        }];
        
        if (indexPath.row <4) {
            
        NSString*selectno = [ary objectAtIndex:indexPath.row];
        
        NSString*urlstr = [NSString stringWithFormat:@"typenumber=%@",selectno];
            PersonalInfo *personInfo = [PersonalInfo share];
            personInfo.DIYtradeTypeNo = selectno;

      
        
        NSSktTOne *skt1 = [NSSktTOne shareskt];
       [ skt1 requeset:[skt1 requestForObject:urlstr somePhpFile:@"queryDIYTradeTypeToinfo.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
         
           self.getRspndDic = [NSJSONSerialization JSONObjectWithData:dat options:NSJSONReadingMutableContainers error:nil];
           
           dispatch_async(dispatch_get_main_queue(), ^{
               [_MainTableview reloadData];
           });
           
        }];
        }else{
            NSSktTOne *skt1 = [NSSktTOne shareskt];
            [skt1 getRequeset:[skt1 requestforPhpfile:@"queryDIYOrderliked.php"] :^(NSData *dat, NSError *er, NSDictionary *dic) {
                self.getRspndDic = [NSJSONSerialization JSONObjectWithData:dat options:NSJSONReadingMutableContainers error:nil];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_MainTableview reloadData];
                });


            }];
        
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == _Mainscroolview) {
        
    
    _Addview.alpha = (CGFloat)(SCOLE_VALUE*SCRREN_WIDTH-scrollView.contentOffset.x)/(CGFloat)(SCOLE_VALUE*SCRREN_WIDTH);
    
        _Addview.transform = CGAffineTransformMakeScale(.8+.2*_Addview.alpha, .8+.2*_Addview.alpha);
    _Mainview.transform = CGAffineTransformMakeScale(1-.2*_Addview.alpha, 1-.2*_Addview.alpha);
}
}





@end
