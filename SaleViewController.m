//
//  SaleViewController.m
//  LeeNote
//
//  Created by administrator on 15/10/24.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import "SaleViewController.h"
#import "AddPriceCell.h"
#import "AddressCell.h"
#import "ShopInfoCell.h"
#import "SaleValueCell.h"
#import "WriteNoteCell.h"
#import "footerview.h"
#import "PersonalInfo.h"
#import "ZCTradeView.h"
#import "NSSktTOne.h"
#import "MyCartPage.h"
#import "UIImageView+WebCache.h"
#import "PersonInfo.h"
#import "MBProgressHUD+MJ.h"
#import "InterviewPHPMethod.h"
#import "MyTicketPage.h"

#import "savevoicecontroller.h"

@interface SaleViewController ()

@property (nonatomic,strong)CALayer *layer;

@property (nonatomic,strong) UIBezierPath *path;


@property (nonatomic,retain) NSMutableArray *toloadinfo;

@property (nonatomic,copy) NSString *isCartIn;

@property (nonatomic, retain) NSString *ticketNum;


@property (nonatomic,copy) NSString *tiketValue;

@end

static NSString*name = @"name";
static NSString*phonenumber = @"ponenumer";
static NSString*addresss = @"address";
static NSString*salevalue = @"salevalue";


@implementation SaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   // [MBProgressHUD showMessage:nil];
    
    NSString*urlstr = [NSString stringWithFormat:@"no=%@",self.selectDIYno];
    
    self.tiketValue = @"0";
    self.ticketNum = @"0";
    
    self.toloadinfo = [NSMutableArray new];
    
    NSSktTOne *skt1 = [NSSktTOne shareskt];
    [ skt1 requeset:[skt1 requestForObject:urlstr somePhpFile:@"queryDIYTradeNotoInfo.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
      
        self.toloadinfo = [ary objectForKey:@"info"];
        
        //[MBProgressHUD hideHUD];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableview reloadData];
        });
        
        
        
    }];
    
    self.valuedictionary = [NSMutableDictionary new];

    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    [self giveitobject];
    
    [self giveitfootview];
    
    [self addBuyCarButton];
    
    self.title = @"购买";
 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(chuanzhi:) name:@"dizhi" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gouwuquanchuanzhi:) name:@"gouwuquanchuanzhi" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zhifujianpanxiayi:) name:@"zhifujianpan" object:nil];
    
}
//支付界面完成之后做的动作
- (void)zhifujianpanxiayi:(NSNotification *)notification {
    PersonalInfo *personInfo = [PersonalInfo share];
    //    [MBProgressHUD showMessage:@"处理中..."];
    
    NSMutableURLRequest *request = [InterviewPHPMethod interviewPHP:@"buy.php" and:[NSString stringWithFormat:@"id=%@&no=%@&receiver=%@&address=%@&contract=%@&coupon=%@&num=%@",personInfo.UserID,self.selectDIYno,[self.valuedictionary objectForKey:name],[self.valuedictionary objectForKey:addresss],[self.valuedictionary objectForKey:phonenumber],self.ticketNum,self.valuedictionary[salevalue]]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
     //   NSLog(@"%@",dic);
        self.tiketValue = @"0";
        self.ticketNum = @"0";
        dic = nil;
    }];
    [task resume];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
    [MBProgressHUD showSuccess:@"支付成功"];
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"提示" message:@"点击确定添加语音祝福" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
     //   NSLog(@"添加语音信息");
        savevoicecontroller *svc = [[savevoicecontroller alloc]initWithNibName:@"savevoicecontroller" bundle:nil];
        [self.navigationController pushViewController:svc animated:YES];
        
    }];
    UIAlertAction *returnAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [ac addAction:returnAction];
    
    [ac addAction:sureAction];
    
    [self presentViewController:ac animated:YES completion:nil];
//    });
    
}



- (void)gouwuquanchuanzhi:(NSNotification *)notification {
    NSIndexPath *index = [NSIndexPath indexPathForRow:2 inSection:1];
    WriteNoteCell *cell = [self.tableview cellForRowAtIndexPath:index];
    self.ticketNum = notification.object;
    
    cell.ticketAddition.text = [NSString stringWithFormat:@"DIY商品%@元购物券",notification.object];
//    [self.tableview reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
    dispatch_async(dispatch_get_main_queue(), ^{
//        if (self.valuedictionary[salevalue] < [notification object]) {
//            [self.valuedictionary setObject:@"0" forKey:salevalue];
//        }
        
        NSInteger price = [self.valuedictionary[salevalue] floatValue] * [[[self.toloadinfo firstObject]objectForKey:@"price"] floatValue];
        
        if (price < [[notification object]integerValue]) {
            
            self.tiketValue = [[self.toloadinfo firstObject]objectForKey:@"price"];
            
        }else{
        
            self.tiketValue = [notification object];
        }
        
    [self.tableview reloadData];
    });
}


- (void)chuanzhi:(NSNotification *)notification {
    NSDictionary *ary = [notification.userInfo mutableCopy];
    
    NSArray *dic = [ary objectForKey:@"array"];
    
    [self.valuedictionary setObject:dic[0] forKey:name];
    [self.valuedictionary setObject:dic[1] forKey:addresss];
    
    [self.valuedictionary setObject:dic[2] forKey:phonenumber];
    
    [self.tableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}

-(void)addBuyCarButton{

    UIButton *brt = [[UIButton alloc]initWithFrame:CGRectMake(265, 470, 40, 40)];
    
    [brt setBackgroundColor:[UIColor redColor]];
    
    brt.layer.cornerRadius = 20;
    
    brt.clipsToBounds = YES;

    [brt addTarget:self action:@selector(toAnotherPage:) forControlEvents:UIControlEventTouchUpInside];
    
    [brt setImage:[UIImage imageNamed:@"buycar"] forState:UIControlStateNormal];

    [brt setTag:110];
    
    [self.view addSubview:brt];

}

-(void)toAnotherPage:(UIButton *)sender{
  //这是购物车图标, 点击跳转页面
   
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
    
     MyCartPage *cp = [sb instantiateViewControllerWithIdentifier:@"myCartPage"];
    
    [self.navigationController pushViewController:cp animated:YES];
    
}

-(void)startAnimation
{
    _layer = [CALayer layer];
    _layer.contents = (__bridge id)[UIImage imageNamed:@"smallcar"].CGImage;
    _layer.contentsGravity = kCAGravityResizeAspectFill;
    _layer.bounds = CGRectMake(0, 0, 20, 20);
    [_layer setCornerRadius:CGRectGetHeight([_layer bounds]) / 2];
    _layer.masksToBounds = YES;
    _layer.position =CGPointMake(50, 150);
    [self.view.layer addSublayer:_layer];
    
    [self groupAnimation];
}
-(void)groupAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = _path.CGPath;
    animation.rotationMode = kCAAnimationRotateAuto;
    CABasicAnimation *expandAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    expandAnimation.duration = 0.5f;
    expandAnimation.fromValue = [NSNumber numberWithFloat:1];
    expandAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    expandAnimation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    CABasicAnimation *narrowAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    narrowAnimation.beginTime = 0.5;
    narrowAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    narrowAnimation.duration = 1.5f;
    narrowAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    narrowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *groups = [CAAnimationGroup animation];
    groups.animations = @[animation,expandAnimation,narrowAnimation];
    groups.duration = 1.0f;
    groups.removedOnCompletion=NO;
    groups.fillMode=kCAFillModeForwards;
    groups.delegate = self;
    [_layer addAnimation:groups forKey:@"group"];
    
    [self performSelector:@selector(removeFromLayer:) withObject:_layer afterDelay:1.0f];
    
}
- (void)removeFromLayer:(CALayer *)layerAnimation{
    [layerAnimation removeFromSuperlayer];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //    [anim def];
    if (anim == [_layer animationForKey:@"group"]) {
        CATransition *animation = [CATransition animation];
        animation.duration = 0.25f;
        
        CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        shakeAnimation.duration = 0.25f;
        shakeAnimation.fromValue = [NSNumber numberWithFloat:-5];
        shakeAnimation.toValue = [NSNumber numberWithFloat:5];
        shakeAnimation.autoreverses = YES;
        
        UIButton *addcarbuton = (UIButton*)[self.view viewWithTag:110];
        
        
        [addcarbuton.layer addAnimation:shakeAnimation forKey:nil];
    }
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
    
        return 4;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
    
        return 81;
    }else if (indexPath.row == 0){
    
        return 74;
    }else{
    
        return 44;
    }

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        AddressCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"saleviewaddress" forIndexPath:indexPath];
        cell.namelabel.text = [NSString stringWithFormat:@"收货人:%@",[self.valuedictionary objectForKey:name]];
        cell.numberlabel.text = [self.valuedictionary objectForKey:phonenumber];
        cell.addresslabel.text = [self.valuedictionary objectForKey:addresss];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }else if (indexPath.row == 0){
        ShopInfoCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"saleviewshopinfo" forIndexPath:indexPath];
        cell.salevalue.text = [NSString stringWithFormat:@"x%@",[self.valuedictionary objectForKey:salevalue]];
        
      [cell.saleimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSSktTOne shareskt].ipstr,[[self.toloadinfo firstObject]objectForKey:@"image"]]]];
        
        cell.salename.text = [[self.toloadinfo firstObject]objectForKey:@"name"];
        
        NSString *saleprice = [[self.toloadinfo firstObject]objectForKey:@"price"];
        
        cell.saleprice.text = [NSString stringWithFormat:@"￥%.2f",[saleprice floatValue]];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
        
    }else if (indexPath.row == 1){
        SaleValueCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"saleviewsalevalue" forIndexPath:indexPath];
        cell.valuelabel.text = [self.valuedictionary objectForKey:salevalue];
        
        [cell.addbutton addTarget:self action:@selector(addbutton:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.downbutton addTarget:self action:@selector(downbutton:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
        
    }else if (indexPath.row == 2){
        
        WriteNoteCell*cell = [self.tableview dequeueReusableCellWithIdentifier:@"saleviewwritenote" forIndexPath:indexPath];
        
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
        
    }else{
        
        // if (indexPath.row == 3)
        AddPriceCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"saleviewaddprice" forIndexPath:indexPath];
        
        NSString *str = [self.valuedictionary objectForKey:salevalue];
        
        cell.addvaluelabel.text = [NSString stringWithFormat:@"共%@件商品",str];
        
        float addprice = [str floatValue] * [[[self.toloadinfo firstObject]objectForKey:@"price"] floatValue] - self.tiketValue.floatValue;
        
        cell.addpricelabel.text = [NSString stringWithFormat:@"￥%.2f",addprice];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
    }
}

-(void)addbutton:(UIButton*)sender{
    
    NSString *vluestr =  [self.valuedictionary objectForKey:salevalue];
    
    NSString *new = [NSString stringWithFormat:@"%ld",[vluestr integerValue]+1];
    
    [self.valuedictionary setObject:new forKey:salevalue];
    
    [self.tableview reloadData];
    
}

-(void)downbutton:(UIButton*)sender{
    NSString *vluestr =  [self.valuedictionary objectForKey:salevalue];
    
    if (vluestr.integerValue == 1) {
        
        return;
        
    }
    
    NSString *new = [NSString stringWithFormat:@"%ld",[vluestr integerValue]-1];
    
    [self.valuedictionary setObject:new forKey:salevalue];

    [self.tableview reloadData];
    
}


-(void)giveitobject{
    
    [self.valuedictionary setObject:@"" forKey:name];
    
    [self.valuedictionary setObject:@"" forKey:phonenumber];
    
    [self.valuedictionary setObject:@"" forKey:addresss];
    
    [self.valuedictionary setObject:@"1" forKey:salevalue];
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
        returnButtonItem.title = @"取消";
        
    self.navigationItem.backBarButtonItem = returnButtonItem;
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"The" bundle:nil];
        
    PersonInfo *pi = [sb instantiateViewControllerWithIdentifier:@"pi"];
        
        pi.dic = self.valuedictionary;
    
    [self.navigationController pushViewController:pi animated:YES];

    } else if (indexPath.section == 1 && indexPath.row == 2) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
        
        MyTicketPage *mtp = [sb instantiateViewControllerWithIdentifier:@"myTicketPage"];
        
        mtp.whichPage = 1;
        
        [self.navigationController pushViewController:mtp animated:YES];
    
    }
    
}

-(void)giveitfootview{
   
    footerview *fv = [[[NSBundle mainBundle]loadNibNamed:@"footerview" owner:nil options:nil]firstObject];
    
    [fv setFrame:CGRectMake(0, self.view.frame.size.height-38, 320, 38)];
    
    [fv.Getbutton addTarget:self action:@selector(buyTrade:) forControlEvents:UIControlEventTouchUpInside];
    
    [fv.anotherbutton addTarget:self action:@selector(addToBuyCar:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:fv];
    
}

-(void)addToBuyCar:(UIButton*)sender{
    //这里点击加入购物车
    NSSktTOne *skt1 = [NSSktTOne shareskt];
  
    NSString*objecstr = [NSString stringWithFormat:@"id=%@&no=%@&date=%@",[PersonalInfo share].UserID,self.selectDIYno,[NSDate date]];
    
    NSMutableURLRequest *mutreq = [skt1 requestForObject:objecstr somePhpFile:@"PDShoppingCar.php"];
    
    [skt1 requeset:mutreq :^(NSData *dat, NSError *er, NSDictionary *ary) {
       
        
        
        self.isCartIn = [ary objectForKey:@"info"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
         
            if ([_isCartIn isEqualToString:@"0"]) {
                
                
                
                NSIndexPath *selectpath = [NSIndexPath indexPathForRow:0 inSection:1];
                
                CGRect selecrect = [self.tableview rectForRowAtIndexPath:selectpath];
                
                CGRect rect = [self.tableview convertRect:selecrect toView:[self.tableview superview]];
                
                rect.origin.y=rect.origin.y+15;
                
                //加入购物车过渡动画
                self.path = [UIBezierPath bezierPath];
                [_path moveToPoint:CGPointMake(15, rect.origin.y+15)];
                [_path addQuadCurveToPoint:CGPointMake(self.view.frame.size.width-35, self.view.frame.size.height-60) controlPoint:CGPointMake(250, rect.origin.y-150)];
                
                [self startAnimation];
                
            }else{
                
                [MBProgressHUD showError:@"已添加入购物车"];
                
            }
            
        });
        
    }];
#pragma mark- 这里添加判断
    
  }


- (void)buyTrade:(UIButton *)sender{
//[self.valuedictionary objectForKey:name],[self.valuedictionary objectForKey:addresss],[self.valuedictionary objectForKey:phonenumber],self.ticketNum]
    NSString*a = [self.valuedictionary objectForKey:name];
    NSString*b = [self.valuedictionary objectForKey:addresss];
    NSString*c = [self.valuedictionary objectForKey:phonenumber];
    
    if (a.length == 0 || b.length == 0 || c.length == 0) {
        [MBProgressHUD showError:@"请填写收货人信息"];
    } else {
    
    
        [[[ZCTradeView  alloc]init]show];
    }
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{

    [textField becomeFirstResponder];
    
    self.tableview.contentOffset = CGPointMake(0, 100);

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    self.tableview.contentOffset = CGPointMake(0, 0);

    return YES;
}

@end

@implementation mytestClass

-(void)imnotWrongblock:(void(^)(bool er))myblock{

    myblock (_isError);

}

@end


