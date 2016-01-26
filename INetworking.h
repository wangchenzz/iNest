//
//  INetworking.h
//  iTestAFNetworking
//
//  Created by administrator on 15/11/23.
//  Copyright © 2015年 administrator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface INetworking : NSObject

@property (nonatomic,copy) NSString *ipstr;


//下载失败的block

@property (nonatomic,copy) void(^errorDolowdToDo)();

+(INetworking*)shareNet;

//根据上架时间排列出DIY商品
-(void)orderDateDIYTradeInfp:(void(^)(id DT))todo;




@end
