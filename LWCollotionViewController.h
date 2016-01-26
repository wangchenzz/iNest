//
//  LWCollotionViewController.h
//  Liwushuo
//
//  Created by administrator on 15/10/29.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+MJ.h"
@interface LWCollotionViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate>

@property NSInteger index;

@property(nonatomic,retain)NSArray*DataArray;
@property (weak, nonatomic) IBOutlet UINavigationBar *bar;

@property (weak, nonatomic) IBOutlet UINavigationItem *navc;

- (IBAction)back:(id)sender;

@end
