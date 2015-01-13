//
//  TencentAccess.h
//  QQDemo
//
//  Created by 杨建亚 on 14-7-3.
//  Copyright (c) 2014年 Dwarven. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TENCENT_ACCESS_TOKEN     @"access_token"
#define TENCENT_OPEN_ID          @"open_id"
#define TENCENT_EXPIRATION_DATE  @"expiration_date"
#define TENCENT_NICKNAME         @"nickname"

@interface TencentAccess : NSObject

+ (TencentAccess *)defaultAccess;

- (void)login:(void(^)(BOOL succeeded, id object))result;

- (void)logout;

+ (BOOL)HandleOpenURL:(NSURL *)url;

@end
