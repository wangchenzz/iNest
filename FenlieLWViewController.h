//
//  FenlieLWViewController.h
//  Liwushuo
//
//  Created by administrator on 15/10/20.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+MJ.h"
@interface FenlieLWViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@end
