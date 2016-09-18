//
//  RequestBaseManager.h
//  Vodka
//
//  Created by zhangmingwei on 16/7/8.
//  Copyright © 2016年 Beijing Beast Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <netinet/in.h>
#import "UtilMacro.h"
#import "AFNetworking.h"
#import "ApiMacro.h"

/// 服务器API版本号
#define kCurrent_Api_Version                  @"/v2.4"
/// 网络接口API Domain
#define kCookies_Domain                       @".speedx.com"
/// sessionId 过期 --- 需要重新登录
#define kSession_Id_Expired                  1002
/// 没有网络连接的错误码
#define kNetwork_Invalid_Code                -3010
#define kHttp_Error_Code                     -3020
#define kSocial_Login_Failed                 -3030

#define kResponse_Code_Key                   @"code"
#define kResponse_Message_Key                @"message"
#define kResponse_Result_Key                 @"result"


typedef void (^NetworkInvalidBlock) (BOOL networkValid, NSString* message);
typedef void (^RequestResponseBlock) (BOOL successed, NSInteger code, NSString* responseString);

@interface RequestBaseManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager*     sessionManager;

instance_interface(RequestBaseManager, defaultManager)

/**
 *  @brief  创建网络请求的 Cookies, 该方法需要在用户登录成功以后，发起任何一个网络请求之前调用.
 */
- (void)createRequestCookie;

/**
 *  @brief  清除本地Cookie, 该方法需要在退出登录时调用，使新登录的用户使用自己对应的Cookie
 */
- (void)clearRequestCookie;

/**
 *  @brief 设置请求头, 当切换系统区域以后，该方法需要重新调用，重新设置请求头
 */
- (void)createRequestHeader;

/**
 *  @brief  判断当前是否存在网络连接
 *
 *  @return YES:已经接入网络，NO:未连接网络
 */
+ (BOOL)isNetworkValid;

/**
 *  @brief  获取设备型号（仅 iPhone）
 *
 *  @return 设备型号
 */
+ (NSString *)getiPhoneModel;

/**
 *  @brief  get请求方法，父类方法（在AFNetworking的请求的基础上添加网络判断）
 *
 *  @param  URLString         URLString
 *  @param  parameters        请求参数
 *  @param  networkValidBlock 网络状态block
 *  @param  success           请求成功的block
 *  @param  failure           请求失败的block
 */
+ (void)GET:(NSString *)URLString parameters:(id)parameters networkStatusBlock:(NetworkInvalidBlock)networkValidBlock success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  @brief  POST请求方法，父类方法（在AFNetworking的请求的基础上添加网络判断）
 *
 *  @param  URLString         URLString
 *  @param  parameters        请求参数
 *  @param  networkValidBlock 网络状态block
 *  @param  success           请求成功的block
 *  @param  failure           请求失败的block
 */
+ (void)POST:(NSString *)URLString parameters:(id)parameters networkStatusBlock:(NetworkInvalidBlock)networkValidBlock success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 *  @brief  生成网络请求
 *
 *  @param  urlString url
 *  @param  params    参数
 *  @param  response  block
 */
+ (void)createRequest:(NSString*)urlString params:(NSDictionary*)params response:(RequestResponseBlock)response;

@end
