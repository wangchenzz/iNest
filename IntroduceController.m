//
//  IntroduceController.m
//  LeeNote
//
//  Created by administrator on 15/10/15.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import "IntroduceController.h"
#import "IntroduceCell.h"
#import "CommentCell.h"
#import "BuyView.h"
#import "PhotoandTextCell.h"
#import "SaleViewController.h"
#import "MBProgressHUD+MJ.h"
#import "UIImageView+WebCache.h"
#import "LoginPage.h"
#import "PersonalInfo.h"
#import "HcCustomKeyboard.h"
#import "LYTableViewCell.h"

@interface IntroduceController ()<HcCustomKeyboardDelegate>
@property (nonatomic,retain) NSMutableArray *commentsary;

@property (nonatomic,strong) HcCustomKeyboard *textinput;

@property (nonatomic) NSData *iamgedata;

@property (nonatomic,assign) BOOL isPhotoandText;

@property (nonatomic,retain) NSMutableArray *toloadinfo;

@property (nonatomic,retain)  NSArray *otherImageAry;

@property (nonatomic,assign) BOOL isFirst;

@end

@implementation IntroduceController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.isFirst = YES;
    
    self.isPhotoandText = YES;
    
    //历史遗留代码;
    
    [MBProgressHUD showMessage:@"loading..."];
    
    NSString*urlstr = [NSString stringWithFormat:@"no=%@",self.selectDIYno];
    
    NSSktTOne *skt1 = [NSSktTOne shareskt];
    [ skt1 requeset:[skt1 requestForObject:urlstr somePhpFile:@"queryDIYTradeNotoInfo.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
        
        self.toloadinfo = [[ary mutableCopy]objectForKey:@"info"];
        NSString *otherImage =[[self.toloadinfo firstObject]objectForKey:@"otherImage"];
        self.otherImageAry = [otherImage componentsSeparatedByString:@"??"];
        self.iamgedata = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSSktTOne shareskt].ipstr,[[self.toloadinfo firstObject]objectForKey:@"image"]]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableview setNeedsLayout];
            
            [self.tableview layoutIfNeeded];

            
            [self.tableview reloadData];
            
            [MBProgressHUD hideHUD];
            
            
        });
        
}];
    
    [skt1 requeset:[skt1 requestForObject:urlstr somePhpFile:@"queryDIYComment.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
        self.commentsary = [ary objectForKey:@"info"];
        
        //
    }];
    
    
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    self.tabBarController.tabBar.hidden = YES;
    //设置标题字体大小和颜色
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:18],
       
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.navigationItem.leftBarButtonItem.title = @"< 返回";

    [self addBotView];
    
    self.title = @"礼物详情";
    
    [self pinglunqu];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    [[self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] setNeedsLayout];

}

//添加下方按钮
-(void)addBotView{

    BuyView*buyview = [[[NSBundle mainBundle]loadNibNamed:@"BuyView" owner:nil options:nil]firstObject];
    
    [buyview setFrame:CGRectMake(0, 530, 320, 38)];
    
    buyview.likebutton.layer.cornerRadius = 12.5;
    
    buyview.likebutton.layer.borderWidth = 0.7;
    
    buyview.likebutton.layer.borderColor = [UIColor redColor].CGColor;
    
    buyview.likebutton.clipsToBounds = YES;
    
 
    buyview.buybutton.layer.cornerRadius = 12.5;
    
    [buyview.buybutton addTarget:self action:@selector(buyit:) forControlEvents:UIControlEventTouchUpInside];
    
    [buyview.likebutton addTarget:self action:@selector(isLike:) forControlEvents:UIControlEventTouchUpInside];
    
    if (!_isLie) {
        [buyview.likebutton setTitle:@"♥︎喜欢" forState:UIControlStateNormal];
        
    }else{
        [buyview.likebutton setTitle:@"♡喜欢" forState:UIControlStateNormal];
        
    }

    [buyview setBackgroundColor:[UIColor clearColor]];
    
    UIButton *commentbutton = [[UIButton alloc]initWithFrame:CGRectMake(270, 460, 38, 38)];
    
    commentbutton.layer.cornerRadius = 19;
    
    [commentbutton setBackgroundColor:[UIColor clearColor]];
    
    [commentbutton setImage:[UIImage imageNamed:@"pinglun"] forState:UIControlStateNormal];
    
    [commentbutton setTag:20];
    
    commentbutton.hidden = YES;
    
    [commentbutton addTarget:self action:@selector(startcomment:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:commentbutton];
    
    [self.view addSubview:buyview];
 
}

//点击购买按钮
-(void)buyit:(UIButton*)sender{
    
    
    PersonalInfo *personalInfo = [PersonalInfo share];
    
    //这里是选中了第几行
    if (personalInfo.UserID.length != 0){
        

    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"The" bundle:nil];
    
    SaleViewController *svc = [sb instantiateViewControllerWithIdentifier:@"saleview"];
    
    [self.navigationController pushViewController:svc animated:YES];
    
    svc.selectDIYno = self.selectDIYno;

    }else{
        [MBProgressHUD showError:@"未登录,无法购买!"];
    
    }
}


//点击喜欢事件;
-(void)isLike:(UIButton*)sender{
    
    PersonalInfo *personalInfo = [PersonalInfo share];
    
    //这里是选中了第几行
    if (personalInfo.UserID.length != 0){

    
    _isLie = !_isLie;
    
    if (!_isLie) {
        [sender setTitle:@"♥︎喜欢" forState:UIControlStateNormal];
   
    }else{
        [sender setTitle:@"♡喜欢" forState:UIControlStateNormal];
    
    }
#pragma mark -- 弃用的通知方法
    //[[NSNotificationCenter defaultCenter]postNotificationName:@"ilikeit" object:self.selectDIYno];
    
        if ([self.delegate respondsToSelector:@selector(IntroduceControllerDidClickLike:likeNum:)]) {
        
    [self.delegate IntroduceControllerDidClickLike:self likeNum:self.selectDIYno];
        }
        
    }else{
        [MBProgressHUD showError:@"未登录,无法收藏"];
    }
}

- (void)didReceiveMemoryWarning {

    [super didReceiveMemoryWarning];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        
        return 1;
    
    }else{
        if (self.isPhotoandText) {
            
    
        return 1;
        }else{
            return self.commentsary.count;

//            if (self.commentsary.count<10) {
//                return 10;
//            }else{
//                return self.commentsary.count;
//            }
        }
    }

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}



#pragma mark - this place is wrong for tableviewcell
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        IntroduceCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"intrcell" forIndexPath:indexPath];
        
        [cell setBackgroundColor:[UIColor whiteColor]];
        
        
       cell.goodsimage.image = [UIImage imageWithData:self.iamgedata];
        
        
        //[cell.goodsimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSSktTOne shareskt].ipstr,[[self.toloadinfo firstObject]objectForKey:@"image"]]]];
        
        [cell.introducelabel setBackgroundColor:[UIColor whiteColor]];

        [cell setLabelNsstirng:[[self.toloadinfo firstObject]objectForKey:@"brief"]];
        
        //
        
        cell.namelable.text = [[self.toloadinfo firstObject] objectForKey:@"name"];
        
        NSString *pricestr = [[self.toloadinfo firstObject]objectForKey:@"price"];
        
        cell.pricelabel.text = [NSString stringWithFormat:@"￥%.2f",[pricestr floatValue]];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    
    }else{
        if (!self.isPhotoandText) {
            LYTableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"commcell"];
            
            if(!cell){
                
                cell = [[LYTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"commcell"];
                
            }
            
            [cell setBackgroundColor:[UIColor whiteColor]];
            
            
            
            [cell.image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSSktTOne shareskt].ipstr,[[self.commentsary objectAtIndex:indexPath.row]objectForKey:@"userimage"]]]];
            
            //            cell.headimage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSSktTOne shareskt].ipstr,[[self.commentsary objectAtIndex:indexPath.row]objectForKey:@"userimage"]]]]];
            
            cell.date.text = [[[self.commentsary objectAtIndex:indexPath.row]objectForKey:@"commenttime"] substringWithRange:NSMakeRange(5, 11)];
            
            cell.name.text = [[self.commentsary objectAtIndex:indexPath.row]objectForKey:@"usernickname"];
            
            cell.pinglun.text = [[self.commentsary objectAtIndex:indexPath.row]objectForKey:@"comment"];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        
        }else
        {
            
            PhotoandTextCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"pho"];
            
            if (!cell) {
                
                cell = [[PhotoandTextCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pho"];
            
            }
            
            for (int i = 0 ; i < self.otherImageAry.count; i++) {
                
            
            UIImageView*firstimage = [[UIImageView alloc]initWithFrame:CGRectMake(5, (2+200)*i, 310, 200)];
                
            [firstimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[NSSktTOne shareskt].ipstr,[self.otherImageAry objectAtIndex:i]]]];
                
            [cell.contentView addSubview:firstimage];
            
            }
            return cell;
        }
    }
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
        return (303 + [IntroduceCell heigtwithlabelNSString:[[self.toloadinfo firstObject]objectForKey:@"brief"] andWideth:304]+10);
    

    }else{
        if (self.isPhotoandText) {
            return (self.otherImageAry.count - 1) * 202 +200;
        }else{
        return 100;
        }
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
    
        return 0;
        
    }else{
    
        return 38;
    }

}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

  //  return 30;
//}
//
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 38)];
    
    UIButton* leftbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 160 , 37)];
    
    UIButton* rightbutton = [[UIButton alloc]initWithFrame:CGRectMake(160, 0, 160, 37)];
    
    [leftbutton setTag:11];
    
    [rightbutton setTag:12];

    [leftbutton setTitle:@"图文介绍" forState:UIControlStateNormal];
    
    [rightbutton setTitle:[NSString stringWithFormat:@"评论(%lu)",(unsigned long)self.commentsary.count] forState:UIControlStateNormal];
    
    [leftbutton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [leftbutton setTitleColor:[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:1] forState:UIControlStateNormal];
    [rightbutton setTitleColor:[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:1] forState:UIControlStateNormal];
    [rightbutton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    
    rightbutton.layer.borderWidth = 0.5;
    leftbutton.layer.borderWidth = 0.5;
    rightbutton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    leftbutton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [header setBackgroundColor:[UIColor colorWithWhite:0.94 alpha:1]];
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"leftandright"] highlightedImage:[UIImage imageNamed:@"leftandright"]];
    
    [header addSubview:image];
    
    [image setTag:110];
    
    if (self.isFirst) {
        [image setFrame:CGRectMake(0, 0, 160, 38)];
    }else{
        if (self.isPhotoandText) {
            
            
            [image setFrame:CGRectMake(160, 0, 160, 38)];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:1 animations:^{
                    [UIView setAnimationDuration:0.5];
                    [image setFrame:CGRectMake(0, 0, 160, 38)];
                }];
            });
         
        } else {
        
            [image setFrame:CGRectMake(0, 0, 160, 38)];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:1 animations:^{
                    [UIView setAnimationDuration:0.5];
                    [image setFrame:CGRectMake(160, 0, 160, 38)];
                }];
            });
            
        }
    }
    
    [leftbutton addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightbutton addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];

    [header addSubview:leftbutton];
    
    [header addSubview:rightbutton];

    return header;
}


-(void)left:(UIButton*)sender{
    self.isFirst = NO;
    
    if (self.isPhotoandText == NO) {
        
    
    
    self.isPhotoandText = YES;
    
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];

  
    UIButton *but = (UIButton*)[self.view viewWithTag:20];
    
    but.hidden = YES;
    }else{
    
        return;
    }
//  [sender setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
//    

//  这里尝试添加视图
    
}
-(void)right:(UIButton*)sender{
    
    self.isFirst = NO;
    
    if (self.isPhotoandText == YES) {
        
    
    
    self.isPhotoandText = NO;
    
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    UIButton *but = (UIButton*)[self.view viewWithTag:20];
    
    but.hidden = NO;

    }else{
        return;
    
    }
}
-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}

+(CGFloat)heigtwithlabelNSString:(NSString*)string andWideth:(CGFloat )width{
    CGRect rect = [string boundingRectWithSize:(CGSize){width,MAXFLOAT} options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    
    return rect.size.height;

}


-(void)viewWillAppear:(BOOL)animated{
    
    self.isFirst = YES;
    
    [super viewWillAppear:animated];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    self.navigationController.navigationBar.hidden = NO;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];

}



/*______________________________________________________________________________________________________________*/

-(void)pinglunqu{


    self.textinput = [HcCustomKeyboard customKeyboard];
    
    [_textinput textViewShowView:self customKeyboardDelegate:self];
    
    _textinput.mBackView.hidden = YES;
}
//这里是确认评论的地方;
//-(void)insertCommentText:(UIButton *)sender{
//}

//点击开始评论按钮;
-(void)startcomment:(UIButton*)sender{
    
    
    PersonalInfo *personalInfo = [PersonalInfo share];
    
    if (personalInfo.UserID.length != 0){
        
        
        _textinput.mBackView.hidden = NO;
        
        [_textinput.mTextView becomeFirstResponder];
        
        //[_writeview becomeFirstResponder];
	

        
    }else{
        
        
        UIAlertController *uc =[UIAlertController alertControllerWithTitle:@"评论失败!" message:@"你没有登录!" preferredStyle: UIAlertControllerStyleAlert];
        
        UIAlertAction *ac = [UIAlertAction actionWithTitle:@"跳转登录界面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //此处 应该要跳转到登录界面
            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
            
            LoginPage *lp = [sb instantiateViewControllerWithIdentifier:@"loginPage"];
            
            
            [self.navigationController pushViewController:lp animated:YES];
            
            
        }];
        
        UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [uc addAction:ac1];
        
        [uc addAction:ac];
        [self presentViewController:uc animated:YES completion:nil];
        
    }

    
    
    
}

//收到通知键盘要出现了;
//-(void)keyboardWillShow:(NSNotification*)notif{

//}

//键盘将要收起来
//-(void)keyboardWillHide:(NSNotification*)fantatic{

//}
//

//收回键盘;

//-(void)returnbored:(UIButton*)sender{
//    
//  }

-(void)talkBtnClick:(UITextView *)textViewGet{

        PersonalInfo *personalInfo = [PersonalInfo share];
//    
//    if (personalInfo.UserID.length != 0){
//        
        [MBProgressHUD showMessage:nil];
        
        NSSktTOne *skt1 = [NSSktTOne shareskt];
        
        NSString *objectstr = [NSString stringWithFormat:@"no=%@&userid=%@&commenttext=%@&time=%@",self.selectDIYno,personalInfo.UserID,textViewGet.text,[NSDate date]];
        
        [skt1 requeset:[skt1 requestForObject:objectstr somePhpFile:@"insertDIYTradeComment.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
           ZZLog(@"+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++%@",er);
            NSString*urlstr = [NSString stringWithFormat:@"no=%@",self.selectDIYno];
            [skt1 requeset:[skt1 requestForObject:urlstr somePhpFile:@"queryDIYComment.php"] :^(NSData *dat, NSError *er, NSDictionary *ary) {
                self.commentsary = [ary objectForKey:@"info"];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUD];
                    [self.tableview reloadData];
                });
                
            }];
            
        }];
//
//    }else{
//        
//        
//        UIAlertController *uc =[UIAlertController alertControllerWithTitle:@"评论失败!" message:@"你没有登录!" preferredStyle: UIAlertControllerStyleAlert];
//        
//        UIAlertAction *ac = [UIAlertAction actionWithTitle:@"跳转登录界面" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            
//            //此处 应该要跳转到登录界面
//            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"PersonalMainPage" bundle:nil];
//            
//            LoginPage *lp = [sb instantiateViewControllerWithIdentifier:@"loginPage"];
//            
//            
//            [self.navigationController pushViewController:lp animated:YES];
//            
//            
//        }];
//        
//        UIAlertAction *ac1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//        
//        [uc addAction:ac1];
//        
//        [uc addAction:ac];
//        [self presentViewController:uc animated:YES completion:nil];
//        
//    }
    
}



@end
