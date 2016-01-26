//
//  SearchLWViewController.m
//  Liwushuo
//
//  Created by administrator on 15/10/16.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "SearchLWViewController.h"
#import "CollectionViewCell.h"
#import "SPXQViewController.h"

@interface SearchLWViewController ()

@property(nonatomic)NSString*no;



@property (nonatomic, strong) NSMutableArray *visableArray;

@property (nonatomic, strong) NSMutableArray *filterArray;
@end

@implementation SearchLWViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
   
    
    [self.bar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
  //  NSLog(@"%@",self.DataArray);
    
    
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
   // NSLog(@"section");
    
 //   NSLog(@"%ld",self.DataArray.count);
    
    return self.DataArray.count;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    //   NSLog(@"number");
    return 1;
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

   CollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
  //  NSLog(@"cell");
    
    NSDictionary*dic=[self.DataArray objectAtIndex:indexPath.row];
    NSURL*url=[NSURL URLWithString:[NSString stringWithFormat:@"http://114.215.126.243/Lee/MyApache-PHP%@",[dic objectForKey:@"image"]]];
    NSData *data=[NSData dataWithContentsOfURL:url];
    
    cell.image.image=[UIImage imageWithData:data];
    
    
    cell.name.text=[dic objectForKey:@"name"];
    cell.price.text=[dic objectForKey:@"price"];
//    cell.image.image=[UIImage imageNamed:@"21"];
    
    //NSLog(@"%@",dic);
    
   
    self.no=[dic objectForKey:@"no"];
    
    
    return cell;

    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SPXQViewController*spxq=[self.storyboard instantiateViewControllerWithIdentifier:@"SPXQ"];
    
    
    spxq.BH=[self.no integerValue];

    [self presentViewController:spxq animated:YES completion:nil];

}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
  
    
}


-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    [searchBar endEditing:YES];
    
    return YES;

}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

//设置每个section与周边的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
    
}

- (IBAction)fanhui:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
