//
//  CommodityViewController.h
//  Liwushuo
//
//  Created by administrator on 15/10/17.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommodityViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *buttonview;
@property (weak, nonatomic) IBOutlet UINavigationBar *bar;

@property (weak, nonatomic) IBOutlet UIImageView *love;

@property (weak, nonatomic) IBOutlet UIButton *like;

@property (weak, nonatomic) IBOutlet UIButton *fenxiang;
@property(nonatomic)NSString*ID;
- (IBAction)back:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@end
