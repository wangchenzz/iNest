//
//  MyIntegralPage.h
//  Personal
//
//  Created by xlh on 15/10/31.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyIntegralPage : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *myIntegralCollectionView;
- (IBAction)integralRule:(UIButton *)sender;


@end
