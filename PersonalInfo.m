//
//  PersonalInfo.m
//  Personal
//
//  Created by 薛立恒 on 15/10/26.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "PersonalInfo.h"
#define ip @"http://114.215.126.243/Lee/MyApache-PHP/"

@implementation PersonalInfo

static PersonalInfo *personInfo;


+ (PersonalInfo *)share {
    if (personInfo == nil) {
        personInfo = [[PersonalInfo alloc]init];
        personInfo.UserID = [NSString string];
        personInfo.ImageData = [NSData data];
        personInfo.UserName = [NSString string];
        personInfo.integralCount = [NSString string];
        personInfo.refreshDate = [NSDate date];
        personInfo.DIYtradeTypeNo = [NSString string];
        personInfo.ticketArray = [NSMutableArray new];
        
        personInfo.IP = ip;
        
    }

    return personInfo;
}

+ (void)clear {
    personInfo.UserID = nil;
    personInfo.ImageData = nil;
    personInfo.UserName = nil;
    personInfo.integralCount = nil;
    personInfo.refreshDate = nil;
    personInfo.DIYtradeTypeNo = nil;
    [personInfo.ticketArray removeAllObjects];
}
@end
