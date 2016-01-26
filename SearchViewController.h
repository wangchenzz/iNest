//
//  SearchViewController.h
//  Liwushuo
//
//  Created by administrator on 15/10/14.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SearchLWViewController.h"

#import "FoodViewController.h"
#import "MBProgressHUD+MJ.h"
@interface SearchViewController : UIViewController<UISearchControllerDelegate,UISearchResultsUpdating,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>


@property(strong,nonatomic)UIPageViewController*pageViewController;

@property(nonatomic,retain)NSArray*imageArray;

@property (nonatomic, strong) NSMutableArray *visableArray;

@property (nonatomic, strong) NSMutableArray *filterArray;

@property (nonatomic, strong) NSMutableArray *dataSourceArray;






@end
