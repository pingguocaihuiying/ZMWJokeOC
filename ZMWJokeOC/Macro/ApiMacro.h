//
//  ApiMacro.h
//  ZMWJokeOC
//
//  Created by speedx on 16/9/18.
//  Copyright © 2016年 speedx. All rights reserved.
//

#ifndef ApiMacro_h
#define ApiMacro_h

#if DEBUG
///debug模式下-----------------Begin--------------------------
#define kBaseRequestKey         @"b13defd332c76c3abf2895f7796e2a45"
#else
///release模式下---------------End--------------------------
#define kBaseRequestKey         @"b13defd332c76c3abf2895f7796e2a45"
#endif

#endif /* ApiMacro_h */
