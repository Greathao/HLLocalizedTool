//
//  HLLocalizedTool.h
//  国际化
//
//  Created by liuhao on 2018/5/8.
//  Copyright © 2018年 Beijing Mr Hi Network Technology Company Limited. All rights reserved.
//

#import <Foundation/Foundation.h>

///手动切换语言后通知
extern NSString * const HLLOCALIZEDTOOL_SWITCH_NOTIFICATION;


//包含语言包走语言包 不包含走 默认base语言
#define HLlocalStr(key)     [HLLocalizedTool LocalizedString:key]
/**
 *  自定义bundelName
 */
static NSString *const localizableBundleName = @"localizable";

/**
 * 注意： 用此工具需要自己创建bundle文件  localizableBundleName 和bundle资源一一对应 必须含有Base.lproj(默认)
 */

@interface HLLocalizedTool : NSObject

/**
 *  获取当前程序适配语言列表
 */
+(NSArray*)localizableBundle;


/**
 * 国际化方法
 */
+ (NSString *)LocalizedString:(NSString *)translation_key;

/**
 * 获取当前语言编码  
 */
+ (NSString *)currentLanguage;

/**
 *  主动设置切换语言
 */
+ (void)setUserLanguage:(NSString *)userLanguage;



@end
