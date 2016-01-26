//
//  UpSaleController.m
//  LeeNote
//
//  Created by administrator on 15/10/14.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import "UpSaleController.h"
#import "UpSaleCell.h"
#import "upLoadPhotoCell.h"
@interface UpSaleController ()

@property(nonatomic) NSMutableArray *imageary;

@property(nonatomic,assign) BOOL isDobleUp;


@end

@implementation UpSaleController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isDobleUp = NO;
    //暂时性代码;
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    self.imageary = [NSMutableArray new];
    
    if (  [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
        picker.maximumNumberOfSelection = 10;
        picker.assetsFilter = [ALAssetsFilter allPhotos];
        picker.showEmptyGroups=NO;
        picker.delegate=self;
        picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
                NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
                return duration >= 5;
            } else {
                return YES;
            }
        }];
        
        [self presentViewController:picker animated:YES completion:NULL];
        
    }
    else{
        
        UIAlertController *uc =[UIAlertController alertControllerWithTitle:@"警告!" message:@"你的相册无法使用!" preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *ac = [UIAlertAction actionWithTitle:@"返回." style:UIAlertActionStyleCancel handler:nil];
        
        [uc addAction:ac];
        
        [self presentViewController:uc animated:YES completion:nil];
        
        //NSMutableDictionary
    }
   
    UIBarButtonItem *brbuton = [[UIBarButtonItem alloc]initWithTitle:@"确认上传" style:UIBarButtonItemStyleDone target:self action:@selector(upLoadAllPhoto:)];
    
    self. navigationItem.rightBarButtonItem = brbuton;
    
}


-(void)upLoadAllPhoto:(UIButton*)sender{

    [[NSNotificationCenter defaultCenter]postNotificationName:@"photoandtext" object:self.imageary];
    
    [self.navigationController popViewControllerAnimated:YES];

}


//设置每个section与周边的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);

}

//点击完成图文编辑:
//-(void)upsale:(UIBarButtonItem*)sender{
//    
//  //  if (self.imageary.count == 0 && self.textView.text.length == 0) {
//     
//        UIAlertController *uc =[UIAlertController alertControllerWithTitle:@"警告!" message:@"所填值不能为空!" preferredStyle: UIAlertControllerStyleAlert];
//        
//        UIAlertAction *ac = [UIAlertAction actionWithTitle:@"返回再填写." style:UIAlertActionStyleCancel handler:nil];
//        
//        [uc addAction:ac];
//        
//        [self presentViewController:uc animated:YES completion:nil];
//        
//    }else{
//    
//    
//  //  NSDictionary *valuesend =  @{@"photo":self.imageary,@"text":self.textView.text};
//    
//    
//    [[NSNotificationCenter defaultCenter]postNotificationName:@"photoandtext" object:valuesend];
//    
//        [self.navigationController popViewControllerAnimated:YES];
//    }
//    
//}
//




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}



//上传图片事件_____________________此处代码有用 应用于添加图片;.






-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{

    if (self.isDobleUp) {
        [self.imageary addObjectsFromArray:assets];
        
    }else{
    self.imageary = [NSMutableArray arrayWithArray:assets];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.collectionview reloadData];
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    }

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return (self.imageary.count+1);

}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    upLoadPhotoCell*cell = [self.collectionview dequeueReusableCellWithReuseIdentifier:@"uploadphotocell" forIndexPath:indexPath];
    

    if (indexPath.row == self.imageary.count) {
        cell.upimage.image = [UIImage imageNamed:@"jiatu"];
        cell.editButton.hidden = YES;
    }else{
        if (self.imageary.count != 0) {
            
        
    
    ALAsset *as = [self.imageary objectAtIndex:indexPath.row];
    
    cell.upimage.image = [UIImage imageWithCGImage:as.defaultRepresentation.fullScreenImage];
            
            
    //NSData *data = UIImagePNGRepresentation(cell.upimage.image);
            
    cell.editButton.hidden = NO;
    
    [cell.editButton addTarget:self action:@selector(editImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [cell.editButton setTag:indexPath.row];
        
        }else{
        
        
        }
    }
    return cell;
    
}

-(void)editImage:(UIButton*)sender{
  
    [self.imageary removeObjectAtIndex:sender.tag];
    
    [self.collectionview reloadData];



}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;

}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(93, 93);

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == self.imageary.count) {
        self.isDobleUp = YES;
        ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
        picker.maximumNumberOfSelection = 10;
        picker.assetsFilter = [ALAssetsFilter allPhotos];
        picker.showEmptyGroups=NO;
        picker.delegate=self;
        picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
                NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
                return duration >= 5;
            } else {
                return YES;
            }
        }];
        
        [self presentViewController:picker animated:YES completion:NULL];

    }else{
    
        return;
    }
}





@end
