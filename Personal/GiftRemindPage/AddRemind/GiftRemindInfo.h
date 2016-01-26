//
//  GiftRemindInfo.h
//  Personal
//
//  Created by 薛立恒 on 15/10/15.
//  Copyright © 2015年 xueliheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiftRemindInfo : NSObject
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *timeStr;
@property (nonatomic, copy) NSString *repeatStr;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, assign) BOOL isSave;
@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic, assign) BOOL isUpdate;
@property (nonatomic, copy) NSIndexPath *remindIndexPath;

+ (GiftRemindInfo *)share;
@end
