//
//  UserDefaultMacro.h
//  ZMWJokeOC
//
//  Created by speedx on 16/9/28.
//  Copyright © 2016年 speedx. All rights reserved.
//

#ifndef UserDefaultMacro_h
#define UserDefaultMacro_h

#define kCollectionIds          @"kCollectionIds"           // 收藏id列表

#pragma mark - 语言相关

// Locale String [Upper Case]
// 英文-香港    EN_HK
// 中文-香港    ZH_HK
// 英文-中国    EN_CN
// 英文-台湾    EN_TW
// 英文-澳门    EN_MO
#define LOCALE_STRING_UPPER_CASE     [(NSString *)[[NSLocale currentLocale] localeIdentifier] uppercaseString]

//
// zh           中文
// zh-Hant      繁体中文
// zh-Hans      简体中文
// zh-HK        繁体中文(香港)
#define I18N_CURRENT_LANGUAGE_STRING (([[NSLocale preferredLanguages] objectAtIndex:0]) == nil ? @"" : ([[NSLocale preferredLanguages] objectAtIndex:0]))

// 语言是否是中文。中文：YES 其他语言：NO
#define IS_CHINESE_LANGUAGE          ([([[NSLocale preferredLanguages] objectAtIndex:0]) == nil ? @"" : ([[NSLocale preferredLanguages] objectAtIndex:0]) hasPrefix:@"zh"])

//
// 该宏用户判断是否处于国际化模式下，即非中文模式；
// 该宏的判断逻辑可以使用语言来判是否需要进行国际化，包括单位转换等；
// 在非中国的海外地区
//
#define I18N_IN_AREA_ABROAD_MODE \
(!([LOCALE_STRING_UPPER_CASE hasSuffix:@"CN"] ||    \
[LOCALE_STRING_UPPER_CASE hasSuffix:@"HK"] ||   \
[LOCALE_STRING_UPPER_CASE hasSuffix:@"TW"] ||   \
[LOCALE_STRING_UPPER_CASE hasSuffix:@"MO"]))

//非中国大陆或者香港的话是用苹果地图。。。。
#define I18N_IN_AREA_APPLE_MODE \
(!([LOCALE_STRING_UPPER_CASE hasSuffix:@"CN"] ||    \
[LOCALE_STRING_UPPER_CASE hasSuffix:@"HK"]))


#endif /* UserDefaultMacro_h */
