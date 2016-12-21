//
//  ApiMacro.h
//  ZMWJokeOC
//
//  Created by speedx on 16/9/18.
//  Copyright © 2016年 speedx. All rights reserved.
//

#ifndef ApiMacro_h
#define ApiMacro_h
// =============================不区分debug和release的部分 begin=============================
//融云公众号服务 ---------- begin ----------

#define PUBLIC_SERVICE_FEEDBACK_ZH               @"speedx"
#define PUBLIC_SERVICE_FEEDBACK_EN               @"speedx_Feedback"

#define PUBLIC_SERVICE_SPEEDX_HELPER_ZH          @"speedx_services"
#define PUBLIC_SERVICE_SPEEDX_HELPER_EN          @"speedx_service"

#define RONG_CLOUD_PUBLIC_SERVICE_FEEDBACK       (([I18N_CURRENT_LANGUAGE_STRING hasPrefix:@"zh"]) ? PUBLIC_SERVICE_FEEDBACK_ZH : PUBLIC_SERVICE_FEEDBACK_EN)

#define RONG_CLOUD_PUBLIC_SERVICE_SPEEDX_HELPER  (([I18N_CURRENT_LANGUAGE_STRING hasPrefix:@"zh"]) ? PUBLIC_SERVICE_SPEEDX_HELPER_ZH : PUBLIC_SERVICE_SPEEDX_HELPER_EN)

//融云公众号服务 ---------- end ----------
// =============================不区分debug和release的部分 end=============================

#if DEBUG
// debug模式下-----------------Begin--------------------------
#define kBaseRequestKey         @"b13defd332c76c3abf2895f7796e2a45"

// 融云的key debug
#define kRongCloudKey           @"qf3d5gbjqffih"
// debug模式下-----------------End--------------------------

#else
// release模式下---------------Begin--------------------------
#define kBaseRequestKey         @"b13defd332c76c3abf2895f7796e2a45"

// release模式下---------------End--------------------------
#endif

#endif /* ApiMacro_h */

