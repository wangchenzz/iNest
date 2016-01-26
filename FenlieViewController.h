//
//  FenlieViewController.h
//  Liwushuo
//
//  Created by administrator on 15/10/20.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FenleiGLViewController.h"
#import "FenlieLWViewController.h"
#import "MBProgressHUD+MJ.h"

@interface FenlieViewController : UIViewController

@property(strong,nonatomic)UIPageViewController*pageViewController;

- (IBAction)go:(id)sender;


@end
