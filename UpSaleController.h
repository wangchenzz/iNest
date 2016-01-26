//
//  UpSaleController.h
//  LeeNote
//
//  Created by administrator on 15/10/14.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYQAssetPickerController.h"
@interface UpSaleController : UIViewController<ZYQAssetPickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;



@end
