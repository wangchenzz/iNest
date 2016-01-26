//
//  WXGContainerViewController.m
//  SlideMenu
//
//  Created by Nicholas Chow on 15/7/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGContainerViewController.h"
#import "WXGMenuViewController.h"
#import "WXGDetailViewController.h"
#import "WXGMenuItem.h"
#import "PersonalInfo.h"
#import "NSSktTOne.h"
#import "IntroduceController.h"
#import "UPSaleFirstController.h"
#import "LoginPage.h"
#import "INetworking.h"


@interface WXGContainerViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *menuContainerView;

@property (nonatomic, weak) WXGMenuViewController *menuViewController;
@property (nonatomic, weak) WXGDetailViewController *detailViewController;

@property (nonatomic, getter=isShowMenu) BOOL showMenu;

@end

@implementation WXGContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
    
   // self.title = @"DIY";
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nowlogin:) name:@"nowlogin" object:nil];
    
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    //修改返回键颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // 注册菜单点击事件，第一次选中时不做动画
    self.menuViewController.menuDidClick = ^(WXGMenuItem *item, BOOL first , NSInteger selectRow) {
        
        self.detailViewController.item = item;
        
        [self hideOrShowMenu:NO animated:!first];
        
        if (selectRow == 0) {
            
            //时间排序;
            
            [PersonalInfo share].DIYtradeTypeNo = nil;

         //   NSSktTOne *skt1 = [NSSktTOne shareskt];


            


//            NSSktTOne *skt1 = [NSSktTOne shareskt];
//
//            
//            [skt1 getRequeset:[skt1 requestforPhpfile:@"queryDIYOrderDate.php"] :^(NSData *dat, NSError *er, NSDictionary *dic) {
//                self.detailViewController.getRspndDic = [NSJSONSerialization JSONObjectWithData:dat options:NSJSONReadingMutableContainers error:nil];
//                
//                
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [self.detailViewController.tableview reloadData];
//                    
//                    
//                });
//            }];
            [[INetworking shareNet]orderDateDIYTradeInfp:^(id DT) {
                self.detailViewController.getRspndDic = [NSMutableDictionary dictionaryWithDictionary:DT];
            
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.detailViewController.tableview reloadData];
                });
            
            }];
     }
                           
        
        
        if (0<selectRow&&selectRow<4) {
            
            NSArray *ary = @[@"1201",@"1202",@"1203",@"1204"];
            
            NSString*selectno = [ary objectAtIndex:selectRow];
            
            NSString*urlstr = [NSString stringWithFormat:@"typenumber=%@",selectno];
            PersonalInfo *personInfo = [PersonalInfo share];
            personInfo.DIYtradeTypeNo = selectno;
            
            
            
            NSSktTOne *skt1 = [NSSktTOne shareskt];
            [ skt1 requeset:[skt1 requestForObject:urlstr somePhpFile:@"queryDIYTradeTypeToinfo.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
                
                self.detailViewController.getRspndDic = [NSJSONSerialization JSONObjectWithData:dat options:NSJSONReadingMutableContainers error:nil];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.detailViewController.tableview reloadData];
                });
                
            }];
        }else if (selectRow == 4)
        {
            NSSktTOne *skt1 = [NSSktTOne shareskt];
            [skt1 getRequeset:[skt1 requestforPhpfile:@"queryDIYOrderliked.php"] :^(NSData *dat, NSError *er, NSDictionary *dic) {
                self.detailViewController.getRspndDic = [NSJSONSerialization JSONObjectWithData:dat options:NSJSONReadingMutableContainers error:nil];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.detailViewController.tableview reloadData];
                });
                
                
            }];
            
            
            
        }
        
        
    };
    
    //注册上架事件
    
    self.detailViewController.upSale = ^(){
        
        PersonalInfo *personalInfo = [PersonalInfo share];
        
        
        if (personalInfo.UserID.length != 0){
            
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"The" bundle:nil];
            
            UPSaleFirstController *usc = [sb instantiateViewControllerWithIdentifier:@"first"];
            
            [self.navigationController pushViewController:usc animated:YES];
            
            
        }else{
            
            UIAlertController *uc =[UIAlertController alertControllerWithTitle:@"警告!" message:@"你没有登录!" preferredStyle: UIAlertControllerStyleAlert];
            
            UIAlertAction *ac = [UIAlertAction actionWithTitle:@"跳转登录界面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                //此处 应该要跳转到登录界面
                UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
                
                LoginPage *lp = [sb instantiateViewControllerWithIdentifier:@"loginPage"];
                
                
                [self.navigationController pushViewController:lp animated:YES];
                
          //      NSLog(@"xiexie");
                
            }];
            
            UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            [uc addAction:ac1];
            
            [uc addAction:ac];
            [self presentViewController:uc animated:YES completion:nil];
            
            
            
        }
    
    };
   
    
    //注册查看详情界面事件
    
    self.detailViewController.teMeLo = ^(NSString *selectDiyNo ,IntroduceController *controller){

        
    controller.selectDIYno = selectDiyNo;

    [self.navigationController pushViewController:controller animated:YES];
    
    
    };
    // 注册顶部hamburger按钮点击事件
    self.detailViewController.hamburgerDidClick = ^() {
        [self hideOrShowMenu:!self.isShowMenu animated:YES];
    };
    
    self.menuContainerView.layer.anchorPoint = CGPointMake(1, 0.5);
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
}

// 控制菜单视图显示与隐藏
- (void)hideOrShowMenu:(BOOL)hideOrShow animated:(BOOL)animated {
    [self.scrollView setContentOffset:hideOrShow ? CGPointZero : CGPointMake(self.menuContainerView.bounds.size.width, 0) animated:animated];
    self.showMenu = hideOrShow;
}

// 监听视图滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scale = scrollView.contentOffset.x / CGRectGetWidth(self.menuContainerView.bounds);
    
    // 顶部hamburger按钮滚动效果
    [self.detailViewController rotateHamburgerWithScale:scale];
    
    // 菜单视图翻页效果
    self.menuContainerView.layer.transform = [self transformWithScale:scale];
    self.menuContainerView.alpha = 1 - scale;
    
    scrollView.pagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - CGRectGetWidth(scrollView.frame));
}

// 菜单视图的翻页效果
- (CATransform3D)transformWithScale:(CGFloat)scale {
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1 / 1000.0;
    CGFloat angle = -M_PI_2 * scale;
    CATransform3D rotation = CATransform3DRotate(transform, angle, 0, 1, 0);
    CATransform3D translation = CATransform3DMakeTranslation(CGRectGetWidth(self.menuContainerView.bounds) *0.5, 0, 0);
    return CATransform3DConcat(rotation, translation);
}

// 获取两个子控制器
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MenuViewControllerSegue"]) {
        self.menuViewController = (WXGMenuViewController *)[segue.destinationViewController topViewController];
    } else if ([segue.identifier isEqualToString:@"DetailViewControllerSegue"]) {
        self.detailViewController = (WXGDetailViewController *)[segue.destinationViewController topViewController];
    }
}

// 更改状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBar.hidden = YES;

}


-(void)nowlogin:(NSNotification*)notifc{
    UIAlertController *uc =[UIAlertController alertControllerWithTitle:@"提醒!" message:@"你没有登录!" preferredStyle: UIAlertControllerStyleAlert];
    
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

@end
