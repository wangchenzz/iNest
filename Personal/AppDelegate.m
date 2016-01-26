//
//  AppDelegate.m
//  Personal
//
//  Created by 薛立恒 on 15/10/13.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "AppDelegate.h"
#import "PersonalInfo.h"
#import <SMS_SDK/SMSSDK.h>
#import "PersonalMainPage.h"
#import "TheController.h"
#import "ViewController.h"
#import "FenlieViewController.h"
#import "WellcomeViewController.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "WXGContainerViewController.h"
#import "NewVersionController.h"



#define APP_KEY @"b9009e260558"
#define APP_SECRET @"9fbd192632f0935c4781fb5897810290"

@interface AppDelegate ()

@property (nonatomic,strong) UITabBarController *tabbarcontroller;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {//[UMSocialData setAppKey:@"5636c41be0f55a34fc0019d4"];
    
    
    
    [UMSocialQQHandler setQQWithAppId:@"1104941406" appKey:@"oIjVaCP4E4NBXMll" url:@"http://www.liwushuo.com"];
    [UMSocialWechatHandler setWXAppId:@"wxad3bd9d8b5321467" appSecret:@"61a35953c3bd68f5474b1213875b1630" url:@"http://www.liwushuo.com"];
    

    PersonalInfo *personInfo = [PersonalInfo share];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if ([[ud objectForKey:@"UserID"] isEqualToString:@"未登录"]) {
        personInfo.UserID = nil;
    } else {
    
        personInfo.UserID = [ud objectForKey:@"UserID"];
    
    }
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UITabBarController *tab = [[UITabBarController alloc]init];
    UIStoryboard *sb1 = [UIStoryboard storyboardWithName:@"DIY2" bundle:nil];
    UIStoryboard *sb2 = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
    UIStoryboard *sb3 = [UIStoryboard storyboardWithName:@"Choiceness" bundle:nil];

    ViewController *vc = [sb3 instantiateInitialViewController];
    
   [[UINavigationBar appearance]setBarTintColor:[UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
//    默认带有一定透明效果，可以使用以下方法去除系统效果

    
    vc.tabBarItem.title = @"礼记";
    
    
    vc.tabBarItem.image = [UIImage imageNamed:@"homeImage"];
    

    FenlieViewController *fvc = [sb3 instantiateViewControllerWithIdentifier:@"123"];

    fvc.tabBarItem.title = @"分类";
    fvc.tabBarItem.image = [UIImage imageNamed:@"classifyImage"];
    
    
    PersonalMainPage *pmp = [sb2 instantiateInitialViewController];
    pmp.tabBarItem.title = @"我";
    
    WXGContainerViewController * tc = [sb1 instantiateInitialViewController];
    tc.tabBarItem.title = @"DIY";
    tc.tabBarItem.image = [UIImage imageNamed:@"DIY"];
    [tab setViewControllers:@[vc,fvc,tc,pmp] animated:YES];
    

    
    
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 49)];
    backView.backgroundColor = [UIColor whiteColor];
    [tab.tabBar insertSubview:backView atIndex:0];
    tab.tabBar.opaque = YES;

    
    tab.tabBar.tintColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1];
    
    UIColor *titleHighlightedColor = [UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleHighlightedColor,NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    
    self.tabbarcontroller = tab;


    NSString *versionKey = @"CFBundleVersion";
    
    NSString*currentVersion = [[NSBundle mainBundle].infoDictionary objectForKey:versionKey];

    NSString*userVersion = [[NSUserDefaults standardUserDefaults]objectForKey:versionKey];
    
    if ([currentVersion isEqualToString:userVersion]) {
        
        self.window.rootViewController = tab;
    }else{
    
        [[NSUserDefaults standardUserDefaults]setObject:currentVersion forKey:versionKey];
        [[NSUserDefaults standardUserDefaults]synchronize];
    
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(firstVisitLeeNote) name:@"beganLeeNote" object:nil];
       
        NewVersionController *nvc = [[NewVersionController alloc]init];
        
        self.window.rootViewController = tab;
    }
    [self.window makeKeyAndVisible];
   
    [SMSSDK registerApp:APP_KEY withSecret:APP_SECRET];
    
    return YES;

}

-(void)firstVisitLeeNote{

    self.window.rootViewController = self.tabbarcontroller;
    
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"beganLeeNote" object:nil];


}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.

    
    
}


 
@end
