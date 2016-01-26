//
//  SearchLWViewController.h
//  Liwushuo
//
//  Created by administrator on 15/10/16.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD+MJ.h"
@interface SearchLWViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate,UISearchResultsUpdating>
- (IBAction)fanhui:(id)sender;

@property(nonatomic)NSArray*DataArray;
@property (weak, nonatomic) IBOutlet UINavigationBar *bar;

@property (weak, nonatomic) IBOutlet UICollectionView *collection;


//@property NSUInteger pageIndex;

@end
