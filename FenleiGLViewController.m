//
//  FenleiGLViewController.m
//  Liwushuo
//
//  Created by administrator on 15/10/20.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "FenleiGLViewController.h"

#import "LWCollectionViewCell.h"

#import "LWCollectionReusableView.h"

#import "LWCollotionViewController.h"

#import "SPXQViewController.h"

@interface FenleiGLViewController ()



@property(nonatomic,strong)NSMutableArray*Buttons;
@property(nonatomic)BOOL check;

@property(nonatomic,retain)NSArray*aarray;

@property(nonatomic,strong)UIButton*Button;

@property(nonatomic,strong)UIButton*abutton;

@property(nonatomic,retain)NSArray*tupian;

@property(nonatomic,retain)NSArray*name;

@property(nonatomic,retain)NSMutableArray*dataArray;

@property(nonatomic) UIView*contentview;
@property(nonatomic,retain)NSDictionary*dic;
@property(nonatomic,retain)NSArray*array;

@property (nonatomic) UIEdgeInsets buttonInsets;

@end

@implementation FenleiGLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.check=YES;
    
    
    self.dataArray=[NSMutableArray new];
    
    NSString*str=@"http://114.215.126.243/Lee/MyApache-PHP/queryTrade.php";
    
    NSURL*url=[NSURL URLWithString:str];
    
    NSMutableURLRequest*request=[NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod=@"POST";
    
    
    NSURLSession*session=[NSURLSession sharedSession];
    
    NSURLSessionDataTask*task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary*DIC=[[NSDictionary alloc]init];
        DIC=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        
        self.dic=[NSDictionary dictionaryWithDictionary:DIC];
        
        self.array=[self.dic objectForKey:@"info"];
        
        
      //  NSLog(@"^^^^%@",self.array);
        
        dispatch_async(dispatch_get_main_queue() , ^{
            
           
            
        });
        
        
    }];
    
    [task resume];
    
    self.aarray=@[@"个性配饰",@"温暖家居",@"美味厨房",@"美味礼物",@"数码小物",@"创意文具",@"美容护肤",@"精致彩妆",@"户外运动",@"女装",@"男装"];
 
    NSString*path=[[NSBundle mainBundle]pathForResource:@"LW" ofType:@"plist"];
    
    
    self.tupian=[NSArray arrayWithContentsOfFile:path];
    
    NSString*path1=[[NSBundle mainBundle]pathForResource:@"LWname" ofType:@"plist"];
    
    
    self.name=[NSArray arrayWithContentsOfFile:path1];
    
    
    self.Buttons=[NSMutableArray new];
    
    
    self.contentview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 1000)];
    self.contentview.backgroundColor=[UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:0.3];
    

    
    for (int i=0; i<11; i++) {
     
        UIButton*button=[[UIButton alloc]init];
     
        [button setTitle:[NSString stringWithFormat:@"%@",self.aarray[i]] forState:UIControlStateNormal];
        
        button.tag=i;
        
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        
        
        [button.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
         [button setFrame:CGRectMake(0, i*70, 80,40)];
        
        [button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
        

        
        [self.Buttons addObject:button];
        
        
         [self.contentview addSubview:button];
        
        
    }
    

    
    self.scroll.contentSize=CGSizeMake(68, 1000);
    

    [self.scroll addSubview:self.contentview];


    
}

-(void)go:(UIButton*)sender{
    
    NSInteger index=[self.Buttons indexOfObject:sender];

    
    [self.collectionview setContentOffset:CGPointMake(0,index*425)animated:YES];
    

    if (self.Button == nil)
        
    {
        sender.selected = YES;
        self.Button = sender;
    }
    else if (self.Button !=nil && self.Button == sender)
        
    {
        sender.selected = YES;
        
    }
    
    else if (self.Button!= sender && self.Button!=nil)
        
    {
        self.Button.selected = NO;
        sender.selected = YES;
        self.Button = sender;
    }
    
    

    

    
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 11;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    
    if (section==0) {
        return 11;
    }if (section==1) {
        return 11;
    }if (section==2) {
        return 7;
    }if (section==3) {
        return 12;
    }if (section==4) {
        return 6;
    }if (section==5) {
        return 9;
    }if (section==6) {
        return 15;
    }if (section==7) {
        return 9;
    }if (section==8) {
        return 5;
    }if (section==9) {
        return 15;
    }else{
    
        return 9;
    
    }
    
  

}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    
 
    LWCollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    

    NSArray*array=[NSArray new];
    array=[self.tupian objectAtIndex:indexPath.section];
    
        cell.image.image=[UIImage imageNamed:[array objectAtIndex:indexPath.row]];
    NSArray*array1=[NSArray new];
    
    array1=[self.name objectAtIndex:indexPath.section];
    
                          
    cell.label.text=[array1 objectAtIndex:indexPath.row];
 
    [cell.label setFont:[UIFont systemFontOfSize:12.0]];
    
    return cell;
    

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{


    
   NSInteger index=indexPath.section;
    
    UIButton*button=[self.Buttons objectAtIndex:index];


//    NSLog(@"%ld",indexPath.section);
//   
//        if (self.abutton == nil)
//            
//        {
//            button.selected = YES;
//            self.abutton = button;
//        }
//        else if (self.abutton !=nil && self.abutton == button)
//            
//        {
//            button.selected = YES;
//            
//        }
//        
//        else if (self.abutton!= button && self.abutton!=nil)
//            
//        {
//            
//            self.abutton.selected = NO;
//            button.selected = YES;
//            self.abutton = button;
//            
//        }

    
      CGRect RECT=button.frame;

      [self.scroll scrollRectToVisible:RECT animated:YES];
 
   
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGSize size=CGSizeMake(0, 50);
  
    return size;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    CGSize size=CGSizeMake(0, 50);
    
    return size;
    
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSArray*array=@[@"个性配饰",@"温暖家居",@"美味厨房",@"美味礼物",@"数码小物",@"创意文具",@"美容护肤",@"精致彩妆",@"户外运动",@"女装",@"男装"];
    
    LWCollectionReusableView*view=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head" forIndexPath:indexPath];
    
    view.label.text=[array objectAtIndex:indexPath.section];
    

    return view;
    

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSArray*namearray=[self.name objectAtIndex:indexPath.section];
    
    NSString*str=[namearray objectAtIndex:indexPath.row];
    
   // NSLog(@"11111%@",self.array);
    
  //  NSLog(@"当前名字%@",str);
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains [c] %@", str];
    
 
    self.dataArray= [NSMutableArray arrayWithArray:[self.array filteredArrayUsingPredicate:predicate]];
    
    
 //   NSLog(@"传过去%@",self.dataArray);
    
    
    LWCollotionViewController*sv=[self.storyboard instantiateViewControllerWithIdentifier:@"LWC"];
    
    [sv setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
    [sv setValue:self.dataArray forKey:@"DataArray"];
    
    
//    NSLog(@"传过去%@",self.visableArray);
    
//    NSLog(@"当前%ld",indexPath.row);
    
//    sv.index=indexPath.row;
    
    
    [self presentModalViewController:sv animated:YES];
    
    
    
}
    

    

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
