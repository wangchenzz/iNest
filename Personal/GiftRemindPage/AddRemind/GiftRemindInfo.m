//
//  GiftRemindInfo.m
//  Personal
//
//  Created by 薛立恒 on 15/10/15.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import "GiftRemindInfo.h"

@implementation GiftRemindInfo

static GiftRemindInfo *remindInfo;


+ (GiftRemindInfo *)share {
    if (remindInfo == nil) {
        remindInfo = [[GiftRemindInfo alloc]init];
        remindInfo.time = [NSString string];
        remindInfo.timeStr = [NSString string];
        remindInfo.title = [NSString string];
        remindInfo.repeatStr = [NSString string];
        remindInfo.remark = [NSString string];
        remindInfo.isSave = NO;
        remindInfo.isDelete = NO;
        remindInfo.isUpdate = NO;
    }
    
    return remindInfo;
}
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeObject:self.title forKey:@"title"];
//    [aCoder encodeObject:self.timeStr forKey:@"timeStr"];
//    [aCoder encodeObject:self.repeatStr forKey:@"repeatStr"];
//    [aCoder encodeObject:self.remark forKey:@"remark"];
//    [aCoder encodeBool:self.isSave forKey:@"isSave"];
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder {
//    if (self = [super init]) {
//        self.title = [aDecoder decodeObjectForKey:@"title"];
//        self.timeStr = [aDecoder decodeObjectForKey:@"timeStr"];
//        self.repeatStr = [aDecoder decodeObjectForKey:@"repeatStr"];
//        self.remark = [aDecoder decodeObjectForKey:@"remark"];
//        self.isSave = [aDecoder decodeObjectForKey:@"isSave"];
//    }
//    return self;
//}

@end
