//
//  IntroduceController.h
//  LeeNote
//
//  Created by administrator on 15/10/15.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSSktTOne.h"

@class IntroduceController;
@protocol IntroduceControllerDelagete <NSObject>

-(void)IntroduceControllerDidClickLike:(IntroduceController*)controller likeNum:(NSString*)DIYNo;


@end

@interface IntroduceController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (weak,nonatomic) id<IntroduceControllerDelagete> delegate;

@property (nonatomic,copy) NSString *selectDIYno;

@property (nonatomic,assign) BOOL isLie;

@end
