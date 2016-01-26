//
//  ViewController.h
//  Liwushuo
//
//  Created by administrator on 15/10/15.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodViewController.h"


@interface ViewController : UIViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property(strong,nonatomic)UIPageViewController*pageViewController;

@property(nonatomic,retain)NSArray*imageArray;

@end
