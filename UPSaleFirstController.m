//
//  UPSaleFirstController.m
//  LeeNote
//
//  Created by administrator on 15/10/15.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import "UPSaleFirstController.h"
#import "UpSaleCell.h"
#import "UpSaleController.h"
#import "ChoseController.h"
#import "WriteViewController.h"
#import "NSSktTOne.h"
#import "PersonalInfo.h"
#import "ASProgressPopUpView.h"

#import "WriteYourIntroduceController.h"


@interface UPSaleFirstController ()<ASProgressPopUpViewDataSource>

@property (nonatomic) NSArray *cellNameArry;
@property (nonatomic) NSMutableArray *cellvalueary;

@property (nonatomic) NSArray *toLoadingImage;

@property (nonatomic) NSMutableArray *uploadImageDate;

@property (nonatomic) float progressvalue;

@property (strong,nonatomic) ASProgressPopUpView *loadprogress;

@end

@implementation UPSaleFirstController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadd:) name:@"chosevalue" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reseve:) name:@"photoandtext" object:nil];
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    self.tabBarController.tabBar.hidden = YES;
    
    self.title = @"我要上架";
    
    UIBarButtonItem *upsalebutton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(upsale:)];
    
    self.navigationItem.rightBarButtonItem = upsalebutton;
    
    self.cellNameArry = [NSArray arrayWithObjects:@"商品名字:",@"商品数量:",@"商品种类:",@"商品价格:",@"添加描述:",@"是否支持定制:",@"图文详细",nil];
    
    //一个可以读取读取的数组;
    self.cellvalueary = [NSMutableArray arrayWithObjects:@"未填",@"未填",@"未填",@"未填",@"未填",@"未填",@"未填",nil];
    
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"取消";
    
    self.navigationItem.backBarButtonItem = returnButtonItem;
    
}
//待完成  完成按钮
-(void)upsale:(UIBarButtonItem*)sender{
    
    if ([self.cellvalueary containsObject:@"未填"]) {
    
        UIAlertController *uc =[UIAlertController alertControllerWithTitle:@"警告!" message:@"没有完整填写."preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *ac = [UIAlertAction actionWithTitle:@"返回继续填写" style:UIAlertActionStyleCancel handler:nil];
        
        [uc addAction:ac];
        
        [self presentViewController:uc animated:YES completion:nil];

    }else{
        //这里是上架的地方;
        NSSktTOne *skt1 = [NSSktTOne shareskt];

        _uploadImageDate = [NSMutableArray new];
        
        for (ALAsset *as in self.toLoadingImage) {
            [_uploadImageDate addObject:UIImagePNGRepresentation([UIImage imageWithCGImage:as.defaultRepresentation.fullScreenImage])];
        }
        
        NSMutableArray *morePhotoPath = [NSMutableArray new];
        
        NSString *headPhotoPath = [NSString string];
        
        for (int i = 0 ; i < self.toLoadingImage.count; i++) {
           
            
            NSString*namestr = [NSString stringWithFormat:@"%@_%d_%u.jpg",[PersonalInfo share].UserID,i,arc4random()];
            
            [skt1 uploadImage:@"abc" filename:namestr mimeType:@"image/jpg" data:[_uploadImageDate objectAtIndex:i] parmas:nil block:^{
                self.progressvalue += (1.0/i);
                
            }];
            if (i==0) {
                headPhotoPath = [NSString stringWithFormat:@"/upload/DIYTrade/%@",namestr];
            }else{
                NSString *intosstr = [NSString stringWithFormat:@"/upload/DIYTrade/%@",namestr];
                [morePhotoPath addObject:intosstr];
            }
        }
        
        NSString *moreImageStr = [morePhotoPath componentsJoinedByString:@"??"];
        
        NSDictionary *typedic = @{@"饰品挂件":@"1201",@"手工纺织品":@"1202",@"手工装饰":@"1203",@"其他":@"1204"};
//        
        NSString *typeno = [typedic objectForKey:[self.cellvalueary objectAtIndex:2]];
        
        //1.名字,2.图片地址,3.价格,4.简介,5.时间,6.商品数量,7.类型编号,8.多图杀鸡;
        
        NSString *objecstr = [NSString stringWithFormat:@"name=%@&image=%@&price=%@&brief=%@&date=%@&num=%@&typeno=%@&otherImage=%@&author=%@",[self.cellvalueary objectAtIndex:0],headPhotoPath,[self.cellvalueary objectAtIndex:3],[self.cellvalueary objectAtIndex:4],[NSDate date],[self.cellvalueary objectAtIndex:1],typeno,moreImageStr,[PersonalInfo share].UserID];
        
        NSMutableURLRequest *request = [skt1 requestForObject:objecstr somePhpFile:@"AddNew.php"];
        
         [skt1 requeset:request :^(NSData *dat, NSError *er, NSDictionary *ary) {
             
             
         }];
        
        [self uploadAllDateProgress];
        
        
        
        
    }
}

-(void)uploadAllDateProgress{
    
    UIView *views1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    
  // [views1 setBackgroundColor:[UIColor colorWithRed:49/255.0 green:132/255.0 blue:252/255.0 alpha:0.8]];
    [views1 setBackgroundColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.6]];


    self.loadprogress = [[ASProgressPopUpView alloc]initWithFrame:CGRectMake(30,280, 250, 50)];
    
    self.loadprogress.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:16];
    self.loadprogress.popUpViewAnimatedColors = @[[UIColor redColor], [UIColor orangeColor], [UIColor colorWithRed:255/255.0 green:59/255.0 blue:70/255.0 alpha:1]];
    self.loadprogress.dataSource = self;
    
    [views1 addSubview:_loadprogress];
    
    
    [self.view addSubview:views1];
    
    [_loadprogress showPopUpViewAnimated:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:0.2f target:self selector:@selector(runpro) userInfo:nil repeats:YES];
    
}

-(void)runpro{
    static float num = 0;
    
    if (num < 0.95) {
        
    num += 0.03;

    }
    
    [self.loadprogress setProgress:num animated:YES];

    //self.progressvalue = self.progressvalue + 0.05;
    
    if (self.progressvalue >= 1&&num >= 0.95) {
        
        [self.loadprogress setProgress:1 animated:YES];
        
        [self performSelector:@selector(nextCont) withObject:nil afterDelay:1.2f];
        
    }
}

-(void)nextCont{
    
    [self.navigationController popViewControllerAnimated:YES];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.cellNameArry.count;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UpSaleCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"upcell" forIndexPath:indexPath];
    
    cell.namelabel.text = [self.cellNameArry objectAtIndex:indexPath.row];
    
    cell.valuelabel.text = [self.cellvalueary objectAtIndex:indexPath.row];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44;

}


//在这里是点击跳转页面;
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==2||indexPath.row ==5) {
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"The" bundle:nil];
        
        ChoseController *cc = [sb instantiateViewControllerWithIdentifier:@"chose"];
    
        cc.CoreIndexPath = indexPath;
        
        UpSaleCell *cell = [self.tableview cellForRowAtIndexPath:indexPath];
    
        cc.whatChose = cell.valuelabel.text;
        
        [self.navigationController pushViewController:cc animated:YES];
    
    }else if (indexPath.row ==0||indexPath.row ==1||indexPath.row ==3){
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"The" bundle:nil];
        
        WriteViewController *cc = [sb instantiateViewControllerWithIdentifier:@"write"];
        
        cc.writecoreindexpath = indexPath;
    
        if    ( ![[self.cellvalueary objectAtIndex:indexPath.row]isEqualToString:@"未填"]){
        
            cc.filestring = [self.cellvalueary objectAtIndex:indexPath.row];
        
        }
        
           [self.navigationController pushViewController:cc animated:YES];
        
    }else if (indexPath.row == 6){
 
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"The" bundle:nil];
        
        UpSaleController *usc = [sb instantiateViewControllerWithIdentifier:@"us"];
        
        [self.navigationController pushViewController:usc animated:YES];
    
    }else if (indexPath.row == 4){
    
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"The" bundle:nil];
        WriteYourIntroduceController *wic = [sb instantiateViewControllerWithIdentifier:@"wtiteintroduce"];
        
        if    ( ![[self.cellvalueary objectAtIndex:indexPath.row]isEqualToString:@"未填"]){
            
            wic.EditString = [self.cellvalueary objectAtIndex:indexPath.row];
            
        }
        [self.navigationController pushViewController:wic animated:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = NO;
    

    
    for (int i =0; i <7; i++) {
    
        NSIndexPath *inde = [NSIndexPath indexPathForRow:i inSection:0];
    
        [self.tableview deselectRowAtIndexPath:inde animated:YES];
    
    }

}




-(void)reseve:(NSNotification*)notifc{
 
    NSArray*imageary = [notifc object];
    
    //字典中的文字和图片当如何保存.存疑;
    
    [self.cellvalueary replaceObjectAtIndex:6 withObject:[NSString stringWithFormat:@"已添加%ld张图",imageary.count]];
    
    self.toLoadingImage = [NSArray arrayWithArray:imageary];
    
    
    [self.tableview reloadData];
    
}

-(void)reloadd:(NSNotification*)notifc{
    
    NSArray *ary = [notifc object];
    
    NSNumber *a = [ary objectAtIndex:1];
    
    NSInteger b = a.integerValue ;
    
    [self.cellvalueary replaceObjectAtIndex:b withObject:[ary objectAtIndex:0]];
    
    [self.tableview reloadData];

}

-(void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 0;

}

- (NSString *)progressView:(ASProgressPopUpView *)progressView stringForProgress:(float)progress
{
    NSString *s;
    if (progress < 0.2) {
        s = @"开始加载咯~";
    } else if (progress > 0.4 && progress < 0.6) {
        s = @"礼记 在为您服务!";
    } else if (progress > 0.75 && progress < 1.0) {
        s = @"不要急,快了";
    } else if (progress >= 1.0) {
        s = @"已完成,即将跳转~";
    }
    return s;
}

- (BOOL)progressViewShouldPreCalculatePopUpViewSize:(ASProgressPopUpView *)progressView;
{
    return NO;
}


-(void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];

}

@end
