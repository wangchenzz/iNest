//
//  MyTaobaoWebViewPage.m
//  Personal
//
//  Created by xlh on 15/11/16.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "MyTaobaoWebViewPage.h"

@interface MyTaobaoWebViewPage ()

@end

@implementation MyTaobaoWebViewPage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    //显示导航栏
    self.navigationController.navigationBarHidden = NO;
    
    
    
    //设置导航栏颜色
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
    
    self.title = @"淘宝的订单";
    
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.leftBarButtonItem.title = @"< 返回";
    
    self.tabBarController.tabBar.hidden = YES;
    // Do any additional setup after loading the view.
    NSString*str=@"https://login.taobao.com/member/login.jhtml?redirectURL=http%3A%2F%2Fbuyertrade.taobao.com%2Ftrade%2Fitemlist%2Flist_bought_items.htm%3Fspm%3Da1z02.1.a2109.d1000368.wnr2AL";
    
    NSURL*url=[NSURL URLWithString:str];
    
    NSURLRequest*request=[NSURLRequest requestWithURL:url];
    
   // NSLog(@"加载页面");
    
    [self.webView loadRequest:request];
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
