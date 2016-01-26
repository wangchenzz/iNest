//
//  LWCollotionViewController.m
//  Liwushuo
//
//  Created by administrator on 15/10/29.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "LWCollotionViewController.h"
#import "LWCollotionCollectionViewCell.h"
#import "SPXQViewController.h"
#import "NSSktTOne.h"

@interface LWCollotionViewController ()

@property(nonatomic)NSDictionary*dic;
@property(nonatomic)NSArray*array;


@end

@implementation LWCollotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.dic=[NSDictionary new];
    self.array=[NSArray new];
    
    [self.bar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navc.title=@"商品";
    
    
    
    
    [self.view setBackgroundColor:[UIColor colorWithRed:234/255.0 green:78/255.0 blue:83/255.0 alpha:1 ]];
    



}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
        return self.DataArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
     LWCollotionCollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSDictionary*dic=[self.DataArray objectAtIndex:indexPath.row];
    
    
    NSURL*url=[NSURL URLWithString:[NSString stringWithFormat:@"http://114.215.126.243/Lee/MyApache-PHP%@",[dic objectForKey:@"image"]]];
    
               
    
    NSData*data=[NSData dataWithContentsOfURL:url];
  
    cell.image.image=[UIImage imageWithData:data];
    


    
    cell.name.text=[dic objectForKey:@"name"];
    
    cell.price.text=[dic objectForKey:@"price"];
    
    cell.like.text=[dic objectForKey:@"likenum"];
    
    
    
    return cell;
    
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SPXQViewController*spxq=[self.storyboard instantiateViewControllerWithIdentifier:@"SPXQ"];
    
    NSDictionary*dic=[self.DataArray objectAtIndex:indexPath.row];

    spxq.BH=[[dic objectForKey:@"no"] integerValue];
    

    
    [spxq setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    [self presentModalViewController:spxq animated:YES];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender {
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}
//设置行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//设置每个section与周边的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
    
}
@end
