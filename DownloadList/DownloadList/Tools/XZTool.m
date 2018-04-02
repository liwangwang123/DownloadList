//
//  XZTool.m
//  XiaoZhu
//
//  Created by 孙亚锋 on 16/7/19.
//  Copyright © 2016年 孙亚锋. All rights reserved.
//


#import "XZTool.h"
#import <AVFoundation/AVFoundation.h>

#define dateFormatter @"yyyy-MM-dd HH:mm"

@implementation XZTool

/**
 *计算UILabel的高度(带有行间距的情况)
 */

+ (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode =NSLineBreakByCharWrapping;
    paraStyle.alignment =NSTextAlignmentLeft;
    paraStyle.lineSpacing = 2;// 字体的行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent =0.0;//首行缩进
    paraStyle.paragraphSpacingBefore =0.0;
    paraStyle.headIndent = 0;//整体缩进(首行除外)
    paraStyle.tailIndent = 0;
    NSDictionary *dic =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle,NSKernAttributeName:@1.5f };
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
    
    
}

+ (CGFloat)heightForString:(NSString *)string font:(CGFloat)font size:(CGSize)size
{
    NSDictionary *dic = @{NSFontAttributeName : BQFitFont(font)};
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.height;
}

+ (CGFloat)widthForString:(NSString *)string font:(CGFloat)font size:(CGSize)size
{
    NSDictionary *dic = @{NSFontAttributeName : BQFitFont(font)};
    CGRect rect = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    return rect.size.width;
}

// 中文转拼音
+ (NSString *)transformToPinYin:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    return [pinyin uppercaseString];
}

// 判断字符串是否为空或者空格键
+ (BOOL)isBlankString:(NSString *)string
{
    if (string == nil) {
        return YES;
    }
    
    if (string == NULL) {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    }
    
    return NO;
}

// 隐藏navigationBar下面的线
+(void)isHiddenNavigationBarBottomLineWithNavigationBar:(UINavigationBar *)navigationBar isHidden:(BOOL)isHidden{
    // NavigationBar底部的黑线是一个UIImageView上的UIImageView
    if ([navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list = navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
}

#pragma mark - 时间处理
+ (NSString *)created_at_string:(NSString *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateNewStr = date;
    
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 传入的date
    NSDate *myDate = [formatter dateFromString:dateNewStr];
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 获取差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *cmps = [calendar components:unit fromDate:myDate toDate:now options:0];
    
    // 获取年月日
    NSDateComponents *creatDateCmps = [calendar components:unit fromDate:myDate];
    NSDateComponents *nowCmps = [calendar components:unit fromDate:now];
    
    if (creatDateCmps.year == nowCmps.year) {
        if ([self isSevenDay:myDate]) {
            /*
            NSDateFormatter *resultFormatter = [[NSDateFormatter alloc]init];
            if (dateNewStr.length > 10) {
                [resultFormatter setDateFormat:@"昨天 HH:mm"];
            } else {
                [resultFormatter setDateFormat:@"昨天"];
            }
            
            NSString *myDate2 = [resultFormatter stringFromDate:myDate];
            return myDate2;
             */
            NSString *day = [NSString stringWithFormat:@"%@天前",[self getDaysWithFromDate:myDate]];
            return day;
        } else if ([self isToday:myDate]) {
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前",(long)cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%ld分钟前",(long)cmps.minute];
            } else {
                return @"刚刚";
            }
            
        } else {
            // 今年的其他日子
            NSDateFormatter *resultFormatter = [[NSDateFormatter alloc]init];
            if (dateNewStr.length > 10) {
                [resultFormatter setDateFormat:dateFormatter];
            } else {
                [resultFormatter setDateFormat:dateFormatter];
            }
            
            NSString *myDate3 = [resultFormatter stringFromDate:myDate];
            return myDate3;
        }
    } else {
        
        NSDateFormatter *resultFormatter = [[NSDateFormatter alloc]init];
        if (dateNewStr.length > 10) {
            [resultFormatter setDateFormat:dateFormatter];
        } else {
            [resultFormatter setDateFormat:dateFormatter];
        }
        NSString *myDate3 = [resultFormatter stringFromDate:myDate];
        return myDate3;
        
    }
}
+(NSString *)yesterdayTime

{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
    
    [components setDay:([components day]-1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    
    [dateday setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [dateday stringFromDate:beginningOfWeek];
    
}


+ (NSString *)created_at:(double)date
{
    NSDate *dateNew = [[NSDate alloc]initWithTimeIntervalSince1970:date / 1000];
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //    if (dateNew.length > 10) {
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    } else {
    //        [formatter setDateFormat:@"yyyy-MM-dd"];
    //    }
    NSString *dateNewStr = [formatter stringFromDate:dateNew];
    
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 传入的date
    NSDate *myDate = [formatter dateFromString:dateNewStr];
    // 当前时间
    NSDate *now = [NSDate date];
    
    // 创建日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 获取差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *cmps = [calendar components:unit fromDate:myDate toDate:now options:0];
    
    // 获取年月日
    NSDateComponents *creatDateCmps = [calendar components:unit fromDate:myDate];
    NSDateComponents *nowCmps = [calendar components:unit fromDate:now];
    
    if (creatDateCmps.year == nowCmps.year){
        if ([self isSevenDay:myDate]) {
/*
            NSDateFormatter *resultFormatter = [[NSDateFormatter alloc]init];
            if (dateNewStr.length > 10) {
                [resultFormatter setDateFormat:@"昨天 HH:mm"];
            } else {
                [resultFormatter setDateFormat:@"昨天"];
            }
            
            NSString *myDate2 = [resultFormatter stringFromDate:myDate];
            return myDate2;
 */
            NSString *day = [NSString stringWithFormat:@"%@天前",[self getDaysWithFromDate:myDate]];
            return day;
        } else if ([self isToday:myDate]) {
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前",(long)cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%ld分钟前",(long)cmps.minute];
            } else {
                return @"刚刚";
            }
            
        } else {
            // 今年的其他日子
            NSDateFormatter *resultFormatter = [[NSDateFormatter alloc]init];
            if (dateNewStr.length > 10) {
                [resultFormatter setDateFormat:dateFormatter];
            } else {
                [resultFormatter setDateFormat:dateFormatter];
            }
            
            NSString *myDate3 = [resultFormatter stringFromDate:myDate];
            return myDate3;
        }
    } else {
        
        NSDateFormatter *resultFormatter = [[NSDateFormatter alloc]init];
      //  if (dateNewStr.length > 10) {
       //   [resultFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
       // } else {
            [resultFormatter setDateFormat:dateFormatter];
        //}
        NSString *myDate3 = [resultFormatter stringFromDate:myDate];
        return myDate3;
        
    }
}

+ (BOOL)isSevenDay:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate = [NSDate date];
    NSString *dateStr = [formatter stringFromDate:date];
    NSString *nowStr = [formatter stringFromDate:nowDate];
    
    date = [formatter dateFromString:dateStr];
    nowDate = [formatter dateFromString:nowStr];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *com = [calendar components:unit fromDate:date toDate:nowDate options:0];
    return com.year == 0 && com.month == 0 && 1 <= com.day && com.day <= 7;
}
+ (NSString *)getDaysWithFromDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *nowDate = [NSDate date];
    NSString *dateStr = [formatter stringFromDate:date];
    NSString *nowStr = [formatter stringFromDate:nowDate];
    
    date = [formatter dateFromString:dateStr];
    nowDate = [formatter dateFromString:nowStr];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *com = [calendar components:unit fromDate:date toDate:nowDate options:0];
    NSString *day = [NSString stringWithFormat:@"%ld",(long)com.day];
    return day;
}
+ (BOOL)isYestoday:(NSDate *)date
{
    // 日历对象，方便比较日期差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *fmr = [[NSDateFormatter alloc] init];
    fmr.dateFormat = @"yyyy-MM-dd";
    NSDate *now = [NSDate date];
    NSString *datestr = [fmr stringFromDate:date];
    NSString *nowstr = [fmr stringFromDate:now];
    
    date = [fmr dateFromString:datestr];
    now = [fmr dateFromString:nowstr];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    
    NSDateComponents *cmp = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmp.year == 0 && cmp.month == 0 && cmp.day == 1;
}

+ (BOOL)isToday:(NSDate *)date
{
    NSDateFormatter *fmr = [[NSDateFormatter alloc] init];
    fmr.dateFormat = @"yyyy-MM-dd";
    NSDate *now = [NSDate date];
    NSString *datestr = [fmr stringFromDate:date];
    NSString *nowstr = [fmr stringFromDate:now];
    return [datestr isEqualToString:nowstr];
}


//时间戳转换为时间
+(NSString *)dateForshijianchuo:(NSString*)timeStampString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate  dateWithTimeIntervalSince1970:[timeStampString doubleValue]/1000];
    NSString *confromTimespStr = [formatter stringFromDate:date];
    //    confromTimespStr =[confromTimespStr substringWithRange:NSMakeRange(0, 10)];
    return confromTimespStr;
}

+ (NSString *)blankStringTransformNoneBlankString:(NSString *)string
{
    if ([XZTool isBlankString:string]) {
        string = @"";
    }
    
    return string;
}
//lab字体大小
+ (NSMutableAttributedString *)fontWithStr:(NSString *)str1 andQianStr:(NSString *)str2 allStr:(NSString *)str3 andFont:(CGFloat)numStr{
    
    long len1 = [str2 length];
    NSString *nameStr = str1;
    NSString *str = str3;
    long len2 = [nameStr length];
    NSMutableAttributedString *str4 = [[NSMutableAttributedString alloc]initWithString:str];
    
    [str4 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:numStr] range:NSMakeRange(len1,len2)];
    
    
    return str4;
}
//lab字体颜色
+ (NSMutableAttributedString *)colorWithStr:(NSString *)str1 andQianStr:(NSString *)str2 allStr:(NSString *)str3 andColor:(NSString *)colorStr{
    long len1 = [str2 length];
    NSString *nameStr = str1;
    NSString *str = str3;
    long len2 = [nameStr length];
    NSMutableAttributedString *str4 = [[NSMutableAttributedString alloc]initWithString:str];
    
    
    [str4 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:colorStr] range:NSMakeRange(len1,len2)];
    
    
    
    return str4;
}
+ (NSString *)getTimeNowF {
    NSDateFormatter * formatter1 = [[NSDateFormatter alloc ] init];
    [formatter1 setDateFormat:@"yyyyMMdd"];
    
    NSDateFormatter * formatter2 = [[NSDateFormatter alloc ] init];
    [formatter2 setDateFormat:@"yyyyMMddhhmmssSSS"];
    
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@",[formatter2 stringFromDate:[NSDate date]]];
    
    return timeNow;
}
+ (NSString *)getTimeNow
{
    NSDateFormatter * formatter1 = [[NSDateFormatter alloc ] init];
    [formatter1 setDateFormat:@"yyyyMMdd"];
    
    NSDateFormatter * formatter2 = [[NSDateFormatter alloc ] init];
    [formatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@",[formatter2 stringFromDate:[NSDate date]]];
    
    return timeNow;
}
+ (NSString *)getDate
{
    NSDateFormatter * formatter1 = [[NSDateFormatter alloc ] init];
    [formatter1 setDateFormat:@"yyyyMMdd"];
    
    NSDateFormatter * formatter2 = [[NSDateFormatter alloc ] init];
    [formatter2 setDateFormat:@"yyyy-MM-dd"];
    
    NSString *timeNow = [[NSString alloc] initWithFormat:@"%@",[formatter2 stringFromDate:[NSDate date]]];
    
    return timeNow;
}
/**
 *  压缩图片尺寸
 *
 *  @param image   图片
 *  @param newSize 大小
 *
 *  @return 真实图片
 */
+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = newSize.width;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [image drawInRect:CGRectMake(0,0,targetWidth, targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext(); UIGraphicsEndImageContext();
    return newImage;
}

// 遍历 字符串中的某个 字符
+ (NSArray *)rangesOfString:(NSString *)searchString inString:(NSString *)str {
    
    NSMutableArray *results = [NSMutableArray array];
    
    NSRange searchRange = NSMakeRange(0, [str length]);
    
    NSRange range;
    
    while ((range = [str rangeOfString:searchString options:0 range:searchRange]).location != NSNotFound) {
        
        [results addObject:[NSValue valueWithRange:range]];
        
        searchRange = NSMakeRange(NSMaxRange(range), [str length] - NSMaxRange(range));
        
    }
    
    return results;
}
// 改变某个字符的大小
+(NSMutableAttributedString *)rangesOfString:(NSString *)string  range:(NSString *)rangeStr{
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:string];
    NSArray *tempArr = [string componentsSeparatedByString:rangeStr];
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:20.0]
     
                          range:NSMakeRange(0, ((NSString *)tempArr[0]).length)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor whiteColor]
     
                          range:NSMakeRange(((NSString *)tempArr[0]).length, ((NSString *)tempArr[1]).length+1)];
    
    
    return AttributedStr;
}


// 通过 视频url 获取 图片第一帧

+(UIImage *)imageWithMediaURL:(NSURL *)url {
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    // 初始化媒体文件
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:url options:opts];
    // 根据asset构造一张图
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
    // 设定缩略图的方向
    // 如果不设定，可能会在视频旋转90/180/270°时，获取到的缩略图是被旋转过的，而不是正向的（自己的理解）
    generator.appliesPreferredTrackTransform = YES;
    // 设置图片的最大size(分辨率)
    generator.maximumSize = CGSizeMake(600, 300);
    // 初始化error
    NSError *error = nil;
    // 根据时间，获得第N帧的图片
    // CMTimeMake(a, b)可以理解为获得第a/b秒的frame
    CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(0, 10000) actualTime:NULL error:&error];
    // 构造图片
    UIImage *image = [UIImage imageWithCGImage: img];
    return image;
}

//根据日历获取当前 日期和 周几
+ (NSString *)getDayWeek:(int)dayDelay{
    
    NSString *weekDay;
    NSDate *dateNow;
    //dayDelay代表向后推几天，如果是0则代表是今天，如果是1就代表向后推24小时，如果想向后推12小时，就可以改成dayDelay*12*60*60,让dayDelay＝1
    dateNow = [NSDate dateWithTimeIntervalSinceNow:dayDelay * 24 * 60 * 60];
    
    //设置成中国阳历
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [[NSDateComponents alloc]init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    comps = [calender components:unitFlags fromDate:dateNow];
    
    NSInteger  weekNumber   = [comps weekday];//获取星期对应的长整形字符串
    NSInteger  year   = [comps year];   //获取日期对应的长整形字符串
    NSInteger  month  = [comps month];  //获取年对应的长整形字符串
    NSInteger  day    = [comps day];    //获取月对应的长整形字符串
//    NSInteger  hour   = [comps hour];
//    NSInteger  minute = [comps minute];
//    NSInteger  second = [comps second];
    
    //把日期长整形转成对应的汉字字符串
    NSString *RiQi = [NSString stringWithFormat:@"%@年%@月%@日",@(year),@(month),@(day)];
    
    switch (weekNumber) {
        case 1:
            weekDay = @"周日";
            break;
        case 2:
            weekDay = @"周一";
            break;

        case 3:
            weekDay = @"周二";
            break;

        case 4:
            weekDay = @"周三";
            break;

        case 5:
            weekDay = @"周四";
            break;

        case 6:
            weekDay = @"周五";
            break;

        case 7:
            weekDay = @"周六";
            break;

        default:
            break;
    }
    
    // 拼接 字符串
    weekDay = [RiQi stringByAppendingString:weekDay];
    
    return weekDay;
    
}

/**
 根据天数 获取几周几天 字符串
 */
+(NSString *)getDayWithCurrentDay:(int)currentDay{
    if (currentDay %7 == 0) {
        return  [NSString stringWithFormat:@"%d周",currentDay/7];
    }else{
        return [NSString stringWithFormat:@"%d周%d天",currentDay/7,currentDay%7];
    }

}
/**
 根据指定的时间来计算距离今天多少天
 */
+(NSInteger)getDayWithDateString:(NSString *)DateString{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    NSTimeZone * zone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//转为东八区
    [fmt setTimeZone:zone];
    [fmt setDateStyle:NSDateFormatterMediumStyle];
    [fmt setTimeStyle:NSDateFormatterShortStyle];
    [fmt setDateFormat:@"yyyy-MM-dd "];
    
    NSDate *yuChanQiDate = [fmt dateFromString:DateString];
    
    //转为时间戳
    NSString *yuchanqi =  [NSString stringWithFormat:@"%ld",(long)[yuChanQiDate timeIntervalSince1970]];
  
    
    NSDate *currentDat = [NSDate date];
    //当前时间的时间戳
    NSString *currentShiJianChuo  = [NSString stringWithFormat:@"%ld",(long)[currentDat timeIntervalSince1970]];
    NSString *shijian = nil;
    // 如果 指定的时间 > 当前时间
    if ([yuchanqi longLongValue] >= [currentShiJianChuo longLongValue]) {
        shijian = [NSString stringWithFormat:@"%lld",[yuchanqi longLongValue] - [currentShiJianChuo longLongValue]];
    }else{
       shijian = [NSString stringWithFormat:@"%lld",[currentShiJianChuo longLongValue] - [yuchanqi longLongValue]] ;
    }
   
    //按常理来说 需要 天数＋1
    NSInteger day = [shijian longLongValue]/60/60/24 ;
   // Log(@"day  %ld",day);
    return day;
}
/**
 *   计算下次月经来的第一天
 */
+(NSString *)getNextFirstJingQiDayWithCurrentJingQiDay:(NSString *)currentJingQiDay  ZhouQi:(NSInteger)zhouQi{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    NSTimeZone * zone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//转为东八区
    [fmt setTimeZone:zone];
    [fmt setDateStyle:NSDateFormatterMediumStyle];
    [fmt setTimeStyle:NSDateFormatterShortStyle];
    [fmt setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *JingQiDay = [fmt dateFromString:currentJingQiDay];
    //    NSLog(@"date1 ~~%@",JingQiDay);
    
    //时间戳
    NSString *JQ = [NSString stringWithFormat:@"%ld", (long)[JingQiDay timeIntervalSince1970]];
    //下次经期时间戳
    NSString *NextJq = [NSString stringWithFormat:@"%lld",([JQ longLongValue]/60/60/24 + zhouQi)*60*60*24];
    
    long long timeInterval = [NextJq longLongValue];
    
    NSDate * nextJingQiDay = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    [fmt setDateFormat:@"yyyy年MM月dd日"];
    //    NSLog(@"date2 ~~%@",nextJingQiDay);
    NSString * day = [fmt stringFromDate:nextJingQiDay];
    
    return day;
}
/**
 *  计算下次排卵日   下次月经来的第一天 － 14天
 */
+(NSString *)getNextPaiLuanDayWithLastYueJingTime:(NSString *)YueJingString JingQi:(NSInteger)JingQi{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    NSTimeZone * zone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//转为东八区
    [fmt setTimeZone:zone];
    [fmt setDateStyle:NSDateFormatterMediumStyle];
    [fmt setTimeStyle:NSDateFormatterShortStyle];
    [fmt setDateFormat:@"yyyy年MM月dd日"];
    
    NSDate *YueJingDate = [fmt dateFromString:YueJingString];
    NSString *YueJing = [NSString stringWithFormat:@"%ld",(long)[YueJingDate timeIntervalSince1970]];
    
    NSString *pailuanRi = [NSString stringWithFormat:@"%lld",([YueJing longLongValue]/60/60/24 + JingQi - 14)*60*60*24];
    
    long long timeInterVal = [pailuanRi longLongValue];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timeInterVal];
    
    NSString * paiLuanRiStr = [fmt stringFromDate:date];
//  Log(@"下次排卵日～～～%@",paiLuanRiStr);
    return paiLuanRiStr;
}
/** 改变最后一次月经时间*/
+(NSString *)changedLastMensesStringWithCustomString:(NSString *)customString
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    NSTimeZone * zone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//转为东八区
    [fmt setTimeZone:zone];
    [fmt setDateStyle:NSDateFormatterMediumStyle];
    [fmt setTimeStyle:NSDateFormatterShortStyle];
    [fmt setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *yuChanQiDate = [fmt dateFromString:customString];
    
    NSDate *oldDate = [NSDate dateWithTimeInterval: - 279*60*60*24 sinceDate:yuChanQiDate];
   
    NSString *LastMensesString = [fmt stringFromDate:oldDate];
    NSLog(@"改变最后一次月经时间 %@  %@",customString,LastMensesString);
    return LastMensesString;
}

+ (NSString *)getEndDateStrWithStartDateStr:(NSString *)startDateStr cycleStr:(NSString *)cycleStr
{
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [formatter dateFromString:startDateStr];
    NSDate *endDate = [startDate dateByAddingTimeInterval:60 * 60 * 24 * ([cycleStr intValue] - 1)];
    NSString *endStr = [formatter stringFromDate:endDate];
    return endStr;
}
+ (NSDateComponents *)compareCurrentTimeWithDateStr:(NSString *)dateStr {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *nowDate = [NSDate date];
//    NSString *dateStr = [formatter stringFromDate:date];
    NSString *nowStr = [formatter stringFromDate:nowDate];
    
    NSDate *date = [formatter dateFromString:dateStr];
    
    nowDate = [formatter dateFromString:nowStr];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitMinute;
    NSDateComponents *com = [calendar components:unit fromDate:date toDate:nowDate options:0];
    
    return com;
}
+ (BOOL)isTokenTimeOutWithTimeStap:(NSString *)timeStap {
    NSDateComponents *components = [self compareCurrentTimeWithDateStr:timeStap];
    return components.year == 0 && components.month == 0 && components.day == 0 && components.minute <= 10;
}

/*
+(NSAttributedString *)attributedTextWithText:(NSString *)text font:(UIFont *)font
{
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
    // @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5-_]+";
    // #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    // url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
   // 遍历所有的特殊字符串
    NSMutableArray *parts = [NSMutableArray array];
    [text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        XZTextPart *part = [[XZTextPart alloc] init];
        part.special = YES;
        part.text = *capturedStrings;
        part.emotion = [part.text hasPrefix:@"["] && [part.text hasSuffix:@"]"];
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    // 遍历所有的非特殊字符
    [text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        if ((*capturedRanges).length == 0) return;
        
        XZTextPart *part = [[XZTextPart alloc] init];
        part.text = *capturedStrings;
        part.range = *capturedRanges;
        [parts addObject:part];
    }];
    // 排序
    // 系统是按照从小 -> 大的顺序排列对象
    [parts sortUsingComparator:^NSComparisonResult(XZTextPart *part1, XZTextPart *part2) {
        
        if (part1.range.location > part2.range.location) {
            // part1>part2
            // part1放后面, part2放前面
            return NSOrderedDescending;
        }
        // part1<part2 part1放前面, part2放后面
        return NSOrderedAscending;
    }];
   // 按顺序拼接每一段文字
    for (XZTextPart *part in parts) {
        // 等会需要拼接的子串
        NSAttributedString *substr = nil;
        if (part.isEmotion) { // 表情
            
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            NSString *name = [XZEmotionTool emotionWithChs:part.text].pngPath;
            if (name) { // 能找到对应的图片
                attch.image = [UIImage imageNamed:name];
                attch.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
                substr = [NSAttributedString attributedStringWithAttachment:attch];
            } else { // 表情图片不存在
                substr = [[NSAttributedString alloc] initWithString:part.text];
            }
       }else{ // 非特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.text];
        }
        [attributedText appendAttributedString:substr];
    }
    // 一定要设置字体,保证计算出来的尺寸是正确的
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
    return attributedText;
}
 */
/**
 * 服务器返回id字符串 转变为 字字符串  症状
 */
+(NSString *)symStrWithId:(NSString *)strid{
    NSString *str;
    NSMutableArray *reArr = [NSMutableArray new];
    NSMutableDictionary *dic = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSHomeDirectory()stringByAppendingPathComponent:@"Documents/symptom.plist"]];
    
    NSMutableDictionary *dic1 = [dic objectForKey:@"detailedDic"];
//    NSLog(@"shusju a a  %@",dic1);
    
    NSArray *idsArr = [strid componentsSeparatedByString:@","];
    for (NSString *str1 in idsArr) {
        [reArr addObject:[dic1 objectForKey:str1]];
    }
    str = [reArr componentsJoinedByString:@","];
    
    return str;

}
//正则表达式 判断 英文和数字
+(BOOL) validateABC123:(NSString *)text
{
    NSString *textRegex = @"^[A-Za-z0-9]+$";
    NSPredicate *textTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",textRegex];
    return [textTest evaluateWithObject:text];
}
//判断是否含有非法字符 yes 有  no没有
+ (BOOL)JudgeTheillegalCharacter:(NSString *)content{
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}

+ (void)loadLevel{
    NSTimer *timer;
    timer = [NSTimer scheduledTimerWithTimeInterval:180 target:self selector:@selector(load1:) userInfo:nil repeats:YES];
}
+ (void)load1:(NSTimer *)timer{
    
    [[BQHTTPManager defaultManager]requesturl:@"/level/addBriskDay" params:nil showHUD:NO successBlock:^(id returnData) {

        int code =[returnData[@"code"] intValue];
//        Log(@"数据啊数据 %@",returnData);
        if (code==12000) {

        }else{
            
        }
        
    } failureBlock:^(NSError *error) {
        
    }];
    
    //取消定时器
    [timer invalidate];   // 将定时器从运行循环中移除，
    timer = nil;
}

@end
