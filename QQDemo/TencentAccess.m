//
//  TencentAccess.m
//  QQDemo
//
//  Created by 杨建亚 on 14-7-3.
//  Copyright (c) 2014年 Dwarven. All rights reserved.
//

#import "TencentAccess.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>

#define kAppId @"222222"

@interface TencentAccess()<TencentSessionDelegate>

@end

@implementation TencentAccess{
    TencentOAuth * _tencentOAuth;
    void(^_result)(BOOL, id);
    NSMutableDictionary * _resultDic;
}

+ (TencentAccess *)defaultAccess
{
    static TencentAccess * __access = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __access = [[TencentAccess alloc] init];
    });
    return __access;
}

- (id)init{
    self = [super init];
    if (self) {
        _tencentOAuth = [[TencentOAuth alloc] initWithAppId:kAppId andDelegate:self];
    }
    return self;
}

- (void)login:(void (^)(BOOL, id))result{
//    [self logout]; //qq sdk 2.8.1 有bug,登录前注销一下会导致检测不到qq app的安装
    
    _result = result;
    
//    NSArray * _permissions = [NSArray arrayWithObjects:@"get_user_info", nil];
//    NSArray * _permissions = [NSArray arrayWithObjects:@"get_simple_userinfo", @"add_t", nil];
    NSArray * _permissions = [NSArray arrayWithObjects:@"all", nil];
    [_tencentOAuth authorize:_permissions inSafari:NO];
}

- (void)logout{
    [_tencentOAuth logout:self];
}

- (void)tencentDidLogin{
    NSLog(@"Tencent Login SUCCESS");
    if ([_tencentOAuth accessToken] && 0 != [[_tencentOAuth accessToken] length]) {
//        NSLog(@"%@",[NSString stringWithFormat:@"Tencent AccessToken:%@\nOpenId:%@\nExpirationDate:%@", [_tencentOAuth accessToken], [_tencentOAuth openId], [_tencentOAuth expirationDate]]);
        
//        _resultDic = [[NSMutableDictionary alloc]init];
//        [_resultDic setObject:[_tencentOAuth accessToken] forKey:TENCENT_ACCESS_TOKEN];
//        [_resultDic setObject:[_tencentOAuth openId] forKey:TENCENT_OPEN_ID];
//        [_resultDic setObject:[_tencentOAuth expirationDate] forKey:TENCENT_EXPIRATION_DATE];
//        _result(YES, _resultDic);
        
        
        if ([_tencentOAuth getUserInfo]) {
            NSLog(@"get user info success");
        }
    }else{
        _result(NO,nil);
        NSLog(@"login failed");
    }
}

- (void)getUserInfoResponse:(APIResponse *)response{
    _resultDic = [NSMutableDictionary dictionaryWithDictionary:
                  [NSJSONSerialization JSONObjectWithData:[[response message] dataUsingEncoding:NSUTF8StringEncoding]
                                                  options:kNilOptions error:nil]];
    [_resultDic setObject:[_tencentOAuth accessToken] forKey:TENCENT_ACCESS_TOKEN];
    [_resultDic setObject:[_tencentOAuth openId] forKey:TENCENT_OPEN_ID];
    [_resultDic setObject:[_tencentOAuth expirationDate] forKey:TENCENT_EXPIRATION_DATE];
    _result(YES, _resultDic);
}

- (void)tencentDidNotLogin:(BOOL)cancelled{
    if (cancelled) {
        _result(NO, @"user cancelled");
        NSLog(@"user cancelled");
    }else{
        _result(NO,nil);
        NSLog(@"Login failed");
    }
}

- (void)tencentDidNotNetWork{
    NSLog(@"network error");
}

+ (BOOL)HandleOpenURL:(NSURL *)url{
    return [TencentOAuth HandleOpenURL:url];
}


@end
