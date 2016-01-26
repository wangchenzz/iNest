//
//  FenlieLWViewController.m
//  Liwushuo
//
//  Created by administrator on 15/10/20.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "FenlieLWViewController.h"
#import "FenleiLWCollectionViewCell.h"
#import "CollectionReusableView.h"
#import "FLViewController.h"

@interface FenlieLWViewController ()

@property(nonatomic,retain)NSArray*tupian;

@property(nonatomic,retain)NSArray*name;

@property(nonatomic,retain)NSArray*array;
@property(nonatomic,retain)NSDictionary*dic;



@end

@implementation FenlieLWViewController






- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    self.array=[NSArray new];
    self.dic=[NSDictionary new];

    
    
    NSString*path=[[NSBundle mainBundle]pathForResource:@"fenlietupian" ofType:@"plist"];
    
  self.tupian=[NSArray arrayWithContentsOfFile:path];
    

    NSString*path2=[[NSBundle mainBundle]pathForResource:@"name" ofType:@"plist"];
    
    self.name=[NSArray arrayWithContentsOfFile:path2];
    

    
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 4;
    
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if(section==0){
        return 15;
    
    }if (section==1) {
        return 7;
    }if (section==2) {
        return 8;
    }
    
    else{
        return 6;
    
    }

}



-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    FenleiLWCollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    
    NSArray*array=[NSArray new];
    
    array=self.tupian[indexPath.section];
    
    cell.image.image=[UIImage imageNamed:[array objectAtIndex:indexPath.row]];
    NSArray*array1=[NSArray new];
    array1=self.name[indexPath.section];
    
    
    cell.label.text=[array1 objectAtIndex:indexPath.row];
    
    
    return cell;
    
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    CGSize size=CGSizeMake(0, 25);
//    self.view.frame.size.width
    return size;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{

    
    CGSize size=CGSizeMake(0, 25);
    
    return size;
    
    

}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
   
    
      NSArray*array=@[@"品类",@"对象",@"专题",@"风格"];
 
        CollectionReusableView*view=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
        
    view.label.text=[array objectAtIndex:indexPath.section];
    
    
    return view;
 
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  
    
   // NSLog(@"%ld",indexPath.row);
    
    UIStoryboard*sb=[UIStoryboard storyboardWithName:@"Choiceness" bundle:nil];
    
    FLViewController*FL=[sb instantiateViewControllerWithIdentifier:@"abc"];
  
    FL.cout=indexPath.row;
    

    [FL setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    [self presentModalViewController:FL animated:YES];
    
    
    
}



- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
    
    
}



@end
