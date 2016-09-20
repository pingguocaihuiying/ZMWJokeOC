//
//  RequestBaseManager.m
//  Vodka
//
//  Created by zhangmingwei on 16/7/8.
//  Copyright © 2016年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import "RequestBaseManager.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import "NSString+IOSUtils.h"
#import "UtilMacro.h"
#import "NSArray+CodeFragments.h"
#import "NSDictionary+CodeFragments.h"

#import "UserManager.h"

@interface RequestBaseManager ()
@end

@implementation RequestBaseManager

instance_implementation(RequestBaseManager, defaultManager)

- (id)init {
    if(self = [super init]) {
        self.sessionManager = [AFHTTPSessionManager manager];
        self.sessionManager.securityPolicy.allowInvalidCertificates = YES;
        self.sessionManager.securityPolicy.validatesDomainName = NO;
        [[self.sessionManager requestSerializer] setHTTPShouldHandleCookies:YES];
        
        // 感觉用缓存更好，有待验证！！！
        [[self.sessionManager requestSerializer] setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [self createRequestHeader];
    }
    return self;
}

/**
 *  @brief  创建网络请求的 Cookies, 该方法需要在用户登录成功以后，发起任何一个网络请求之前调用.
 */
- (void)createRequestCookie {
    /*
        当用户的USER_ID 不为空的时候才创建Cookie
        TODO: 登录注册迁移以后 AVUser 将不再使用，此处需要修改
    */
    if([[[UserManager defaultManager]userModel].sessionId isEmptyString]) {
        return;
    }
    NSString* sessionToken  = [[UserManager defaultManager] userModel].sessionId;
    NSString* domain        = kCookies_Domain;
    NSString* path          = @"/";
    if(![sessionToken isEmptyString]){
        NSDictionary* dict = @{NSHTTPCookieName:@"sessionid", NSHTTPCookieValue:sessionToken, NSHTTPCookieDomain:domain, NSHTTPCookiePath:path};
        NSHTTPCookie* cookie = [[NSHTTPCookie alloc] initWithProperties:dict];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }
}

/**
 *  @brief  清除本地Cookie, 该方法需要在退出登录时调用，使新登录的用户使用自己对应的Cookie
 */
- (void)clearRequestCookie {
    //TODO: 登录注册迁移以后 AVUser 将不再使用，此处需要修改
    NSString* sessionToken  = [[NSUserDefaults standardUserDefaults]objectForKey:@"kCurrentUserSessionId"];
    NSString* domain        = kCookies_Domain;
    NSString* path          = @"/";
    if(![sessionToken isEmptyString]){
        NSDictionary* dict = @{NSHTTPCookieName:@"sessionid", NSHTTPCookieValue:sessionToken, NSHTTPCookieDomain:domain, NSHTTPCookiePath:path};
        NSHTTPCookie* cookie = [[NSHTTPCookie alloc] initWithProperties:dict];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}

/**
 *  @brief 设置请求头, 当切换系统区域以后，该方法需要重新调用，重新请求头
 */
- (void)createRequestHeader{
    NSString* userAgent = [NSString stringWithFormat:@"iOS/%f;%@;beast/%@.%@", [[[UIDevice currentDevice] systemVersion] floatValue], [RequestBaseManager getiPhoneModel], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    
    NSString* lang      = (([[NSLocale preferredLanguages] objectAtIndex:0]) == nil ? @"" : ([[NSLocale preferredLanguages] objectAtIndex:0]));
    
    [[self.sessionManager requestSerializer] setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    [[self.sessionManager requestSerializer] setValue:lang forHTTPHeaderField:@"X-Client-Lang"];
}

/**
 *  @brief  get请求方法，父类方法（在AFNetworking的请求的基础上添加网络判断）
 *
 *  @param  URLString         URLString
 *  @param  parameters        请求参数
 *  @param  networkValidBlock 网络状态block
 *  @param  success           请求成功的block
 *  @param  failure           请求失败的block
 */
+ (void)GET:(NSString *)URLString parameters:(id)parameters networkStatusBlock:(NetworkInvalidBlock)networkValidBlock success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    BOOL networkValid = [self isNetworkValid];
    if(!networkValid){
        if(networkValidBlock){
            networkValidBlock(NO, NSLocalizedString(@"当前网络不可用，请检查网络设置",nil));
        }
        return;
    } else {
        [[RequestBaseManager defaultManager].sessionManager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            success(task, responseObject);
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            failure(task, error);
        }];
    }
}

/**
 *  @brief  POST请求方法，父类方法（在AFNetworking的请求的基础上添加网络判断）
 *
 *  @param  URLString         URLString
 *  @param  parameters        请求参数
 *  @param  networkValidBlock 网络状态block
 *  @param  success           请求成功的block
 *  @param  failure           请求失败的block
 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters networkStatusBlock:(NetworkInvalidBlock)networkValidBlock success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    BOOL networkValid = [self isNetworkValid];
    if(!networkValid){
        if(networkValidBlock){
            networkValidBlock(NO, NSLocalizedString(@"当前网络不可用，请检查网络设置", nil));
        }
        return;
    } else {
        [[RequestBaseManager defaultManager].sessionManager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            success(task, responseObject);
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            failure(task, error);
        }];
    }
}

/**
 *  @brief  判断当前是否存在网络连接
 *
 *  @return YES:已经接入网络，NO:未连接网络
 */
+ (BOOL)isNetworkValid
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    defaultRouteReachability = NULL;
    
    if (!didRetrieveFlags){
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

/**
 *  @brief  生成网络请求
 *
 *  @param  urlString url
 *  @param  params    参数
 *  @param  response  block
 */
+ (void)createRequest:(NSString*)urlString params:(NSDictionary*)params response:(RequestResponseBlock)response {
    
    [self POST:urlString parameters:params networkStatusBlock:^(BOOL networkValid, NSString *message) {
        //无网络连接
        response(NO, kNetwork_Invalid_Code, message);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary* dict = (NSDictionary*)responseObject;
        NSInteger code = [kSaft_Get_Number(dict, kResponse_Code_Key) integerValue];
        if(code == 0) {
            if([dict[kResponse_Result_Key] isKindOfClass:[NSArray class]] || [dict[kResponse_Result_Key] isKindOfClass:[NSDictionary class]]){
                response(YES, code, [dict[kResponse_Result_Key] jsonstring]);
            }else{
                response(YES, code, [NSString stringWithFormat:@"%@", kSaft_Get_Number(dict, kResponse_Result_Key)]);
            }
        }else{
            if (code == kSession_Id_Expired) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"kReLoginAction" object:nil];
            }
            response(NO, code, dict[kResponse_Message_Key]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        response(NO, kHttp_Error_Code, NSLocalizedString(@"当前网络不可用，请检查网络设置", nil));
    }];
}

/**
 *  @brief  生成网络请求
 *
 *  @param  urlString url
 *  @param  params    参数
 *  @param  response  block
 */
+ (void)createGetRequest:(NSString*)urlString params:(NSDictionary*)params response:(RequestResponseBlock)response {
   
    [self GET:urlString parameters:params networkStatusBlock:^(BOOL networkValid, NSString *message) {
        //无网络连接
        response(NO, kNetwork_Invalid_Code, message);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary* dict = (NSDictionary*)responseObject;
        NSInteger code = [kSaft_Get_Number(dict, kResponse_Code_Key) integerValue];
        if(code == 0) {
            if([dict[kResponse_Result_Key] isKindOfClass:[NSArray class]] || [dict[kResponse_Result_Key] isKindOfClass:[NSDictionary class]]){
                response(YES, code, [dict[kResponse_Result_Key] jsonstring]);
            }else{
                response(YES, code, [NSString stringWithFormat:@"%@", kSaft_Get_Number(dict, kResponse_Result_Key)]);
            }
        }else{
            if (code == kSession_Id_Expired) {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"kReLoginAction" object:nil];
            }
            response(NO, code, dict[kResponse_Message_Key]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        response(NO, kHttp_Error_Code, NSLocalizedString(@"当前网络不可用，请检查网络设置", nil));
    }];
}

/**
 *  @brief  获取设备型号（仅 iPhone）
 *
 *  @return 设备型号
 */
+ (NSString *)getiPhoneModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    return platform;
}

@end
