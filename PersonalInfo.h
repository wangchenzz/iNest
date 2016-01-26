//
//  PersonalInfo.h
//  Personal
//
//  Created by 薛立恒 on 15/10/26.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalInfo : NSObject

@property (nonatomic, strong) NSString *UserID;

@property (nonatomic, strong) NSData *ImageData;

@property (nonatomic, strong) NSString *UserName;

@property (nonatomic, strong) NSString *integralCount;

@property (nonatomic, strong) NSDate *refreshDate;

@property (nonatomic, strong) NSString *DIYtradeTypeNo;

@property (nonatomic, strong) NSMutableArray *ticketArray;

@property (nonatomic, copy) NSString *IP;

+ (PersonalInfo *)share;
+ (void)clear;
@end
