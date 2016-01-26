//
//  WaitSearchViewController.h
//  Liwushuo
//
//  Created by why on 15/10/31.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodViewController.h"
#import "SearchViewController.h"

@interface WaitSearchViewController : UIViewController


@property(nonatomic,retain)UIPageViewController*pageViewController;

- (IBAction)lw:(id)sender;
- (IBAction)gl:(id)sender;

@end
