//
//  XZTool.h
//  XiaoZhu
//
//  Created by 孙亚锋 on 16/7/19.
//  Copyright © 2016年 孙亚锋. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "XZTextPart.h"//  插入表情按钮需要的头文件
//#import "XZEmotion.h"
//#import "XZEmotionTool.h"
@interface XZTool : NSObject
/**
 *计算UILabel的高度(带有行间距的情况)
 */
+ (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width;
#pragma mark - 计算字符串
/**
 *  计算文字高度
 *
 *  @param string 目标字符串
 *  @param font   目标字符串大小
 *  @param size   最大尺寸
 *
 *  @return 返回高度
 */
+ (CGFloat)heightForString:(NSString *)string font:(CGFloat)font size:(CGSize)size;



/**
 *  计算文字宽度
 *
 *  @param string 目标字符串
 *  @param font   目标字符串大小
 *  @param size   最大尺寸
 *
 *  @return 返回宽度
 */
+ (CGFloat)widthForString:(NSString *)string font:(CGFloat)font size:(CGSize)size;


// 判断文字是否为空
+ (BOOL)isBlankString:(NSString *)string;


// 中文转拼音
+ (NSString *)transformToPinYin:(NSString *)chinese;


/**
 *  是否隐藏navigationBar底部的黑线
 *
 *  @param navigationBar 目标navigationBar
 *  @param isHidden      yes为隐藏
 */
+ (void)isHiddenNavigationBarBottomLineWithNavigationBar:(UINavigationBar *)navigationBar isHidden:(BOOL)isHidden;


/**
 *  把nil转化为空字符串（@""）
 */
+ (NSString *)blankStringTransformNoneBlankString:(NSString *)string;

/**
 *  lab不同字体大小
 *
 *  @param NSString <#NSString description#>
 *
 *  @return <#return value description#>
 */
+ (NSMutableAttributedString *)fontWithStr:(NSString *)str1 andQianStr:(NSString *)str2 allStr:(NSString *)str3 andFont:(CGFloat)numStr;
/**
 *  lab 不同颜色
 *
 *  @param NSString <#NSString description#>
 *
 *  @return <#return value description#>
 */
+ (NSMutableAttributedString *)colorWithStr:(NSString *)str1 andQianStr:(NSString *)str2 allStr:(NSString *)str3 andColor:(NSString *)colorStr;
#pragma mark - 时间处理
+ (NSString *)yesterdayTime;
+ (NSString *)created_at:(double)date;
+ (NSString *)created_at_string:(NSString *)date;
+(NSString *)dateForshijianchuo:(NSString*)timeStampString;

+ (NSString *)getTimeNow;

+ (NSString *)getDate;

+ (NSString *)getTimeNowF;

+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;



/** 
 遍历 字符串中的某个 字符
*/
+ (NSArray *)rangesOfString:(NSString *)searchString inString:(NSString *)str;


/**
  改变某个字符的大小
 */
+(NSMutableAttributedString *)rangesOfString:(NSString *)string  range:(NSString *)rangeStr;


/**
  通过 视频url 获取 图片第一帧
 */
+(UIImage *)imageWithMediaURL:(NSURL *)url;


/**
 根据日历获取当前 日期和 周几
 */
+ (NSString *)getDayWeek:(int)dayDelay;

/**
 根据天数 获取几周几天 字符串
 */
+(NSString *)getDayWithCurrentDay:(int)currentDay;


/**
 根据指定的时间来计算距离今天多少天
 */
+(NSInteger)getDayWithDateString:(NSString *)DateString;

/**
 *   计算下次月经来的第一天
 */
+(NSString *)getNextFirstJingQiDayWithCurrentJingQiDay:(NSString *)currentJingQiDay  ZhouQi:(NSInteger)zhouQi;
/**
 *  计算下次排卵日  下次月经来的第一天 － 14天
 */
+(NSString *)getNextPaiLuanDayWithLastYueJingTime:(NSString *)YueJingString JingQi:(NSInteger)JingQi;

/**
 *  计算宝宝天数转换成  宝宝已经n岁/n月／n天
 */
//+(NSString *)getBabyDaysWithOldDate:(NSString *)oldDate;

/** 改变最后一次月经时间*/
+(NSString *)changedLastMensesStringWithCustomString:(NSString *)customString;


/**
 * 特殊字符的字符串 比如:表情
 */
+(NSAttributedString *)attributedTextWithText:(NSString *)text font:(UIFont *)font;


/**
  根据月经开始日期 计算月经结束日期

 @param startDateStr 月经开始日期
 @param cycleStr 月经周期
 @return 月经结束日期
 */
+(NSString *)getEndDateStrWithStartDateStr:(NSString *)startDateStr
                                        cycleStr:(NSString *)cycleStr;

/**
 对比传入的时间和当前的时间差

 @param dateStr 传入时间
 @return 时间差
 */
+(NSDateComponents *)compareCurrentTimeWithDateStr:(NSString *)dateStr;

/**
 验证时间戳是否过期

 @param timeStap 时间戳
 @return 验证结果
 */
+ (BOOL)isTokenTimeOutWithTimeStap:(NSString *)timeStap;

/**
 * 服务器返回id字符串 转变为 字字符串  症状
 */
+(NSString *)symStrWithId:(NSString *)strid;


//正则表达式 判断 英文和数字
+ (BOOL) validateABC123:(NSString *)text;

//判断是否含有非法字符 yes 有  no没有
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content;
//增加活跃天数 满3分钟+1
+ (void)loadLevel;

@end
