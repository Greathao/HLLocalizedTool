//
//  HLLocalizedTool.m
//  国际化
//
//  Created by liuhao on 2018/5/8.
//  Copyright © 2018年 Beijing Mr Hi Network Technology Company Limited. All rights reserved.
//

#import "HLLocalizedTool.h"
///获取当前系统语言
#define CURR_LANGUAGES  ([[NSLocale preferredLanguages] objectAtIndex:0])
///USERDFUT
#define STANDARD_USER_DEFAULT  [NSUserDefaults standardUserDefaults]

 
 NSString *const HLLOCALIZEDTOOL_SWITCH_NOTIFICATION =  @"HLLOCALIZEDTOOL_SWITCH_NOTIFICATION";



@implementation HLLocalizedTool

/**
 *  获取budlePath
 */
+(NSString*)localizableBundlePath{
   return [[NSBundle mainBundle]pathForResource:localizableBundleName ofType:@"bundle"]; // 要列出来的目录
}

/**
 *  获取当前程序适配语言列表
 */
+(NSArray*)localizableBundle{
    NSArray * allObject =  [[[NSFileManager defaultManager] enumeratorAtPath:[self localizableBundlePath]]allObjects];;
    NSMutableArray * localizeNameArr = [NSMutableArray array];
    for (NSString * fileName in allObject) {
        NSLog(@"%@",fileName);
        if ([fileName containsString:@"/"]||![fileName containsString:@"lproj"]) {
        }else{
            NSArray * arr = [fileName componentsSeparatedByString:@".lproj"];
            NSLog(@"%@",arr);
            if (arr[0]) {
                [localizeNameArr addObject:arr[0]];
            }
        }
      
    }
    NSLog(@"%@",localizeNameArr);
    return [localizeNameArr copy];
 }

/**
 *  适配了走适配没适配走base
 */
+(NSString*)LocalizedString:(NSString *)translation_key{
    
   return [self LocalizedString:translation_key value:nil];
    
};
 
+ (NSString *)LocalizedString:(NSString *)translation_key value:(NSString *)value;
{
//    NSLog(@"当前系统语言%@",CURR_LANGUAGES);
//    NSLog(@"项目做了的语言%@",[self localizableBundle]);
   ///获取自定义bundle
    NSBundle * bundl = [NSBundle bundleWithPath:[self localizableBundlePath]];

        for (NSString* str  in [self localizableBundle]) {
        ///此程序适配了系统语言
            if ( [CURR_LANGUAGES  hasPrefix:str]) {
                NSString * locPath  =  [bundl pathForResource:str ofType:@"lproj"];
              NSBundle *  bundle = [NSBundle bundleWithPath:locPath];
             return [bundle localizedStringForKey:translation_key value:value table:nil];
            }
        }
        ///没有适配走英文
        NSString * path = [bundl pathForResource:@"Base"ofType:@"lproj"];
        NSBundle *  bundle = [NSBundle bundleWithPath:path];
        return [bundle localizedStringForKey:translation_key value:value table:nil];
   
 }
    
 

+ (NSString *)currentLanguage
{
    return  [NSLocale preferredLanguages].firstObject;
}


/**
 *  主动设置切换语言
 */
+ (void)setUserLanguage:(NSString *)userLanguage;{
    if (!userLanguage.length) {
        [self resetSystemLanguage];
        return;
    }
    
    [STANDARD_USER_DEFAULT setValue:@[userLanguage] forKey:@"AppleLanguages"];
    [STANDARD_USER_DEFAULT synchronize];
 
   ///切换成功 发送通知
    [[NSNotificationCenter defaultCenter]postNotificationName:HLLOCALIZEDTOOL_SWITCH_NOTIFICATION object:nil];
 
}


/**
 重置系统语言
 */
+ (void)resetSystemLanguage
{
 
    [STANDARD_USER_DEFAULT setValue:@[] forKey:@"AppleLanguages"];
    [STANDARD_USER_DEFAULT synchronize];
}




@end
