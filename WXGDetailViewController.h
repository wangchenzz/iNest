//
//  WXGDetailViewController.h
//  SlideMenu
//
//  Created by Nicholas Chow on 15/7/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXGMenuItem;
@class WXGDetailViewController;
@class IntroduceController;

@interface WXGDetailViewController : UIViewController

@property (nonatomic, strong) WXGMenuItem *item;

@property (nonatomic, strong) NSMutableDictionary *getRspndDic;

@property (nonatomic,strong) UITableView *tableview;

// 注册顶部hamburger按钮点击事件
@property (nonatomic, copy) void(^hamburgerDidClick)();
//注册上架事件

@property (nonatomic,copy) void (^upSale)();

//注册点击跳转事件;
@property (nonatomic,copy) void(^teMeLo)(NSString*selectDiyNo,IntroduceController*controller);

// 顶部hamburger按钮滚动效果
- (void)rotateHamburgerWithScale:(CGFloat)scale;

- (IBAction)upasle:(UIBarButtonItem *)sender;


@end
