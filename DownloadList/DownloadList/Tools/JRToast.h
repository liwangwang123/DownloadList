//
//  JRToast.h
//  MobileReader
//

#import <UIKit/UIKit.h>

#define DEFAULT_DISPLAY_DURATION 3.0f

@interface JRToast : UIView {
    NSString *_text;
    UIButton *_contentView;
    CGFloat _duration;
}

+ (void)showWithText:(NSString *)text;
+ (void)showWithText:(NSString *)text duration:(CGFloat)duration;

+ (void)showWithText:(NSString *)text topOffset:(CGFloat)topOffset;
+ (void)showWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration;

+ (void)showWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset;
+ (void)showWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration;
+(UIImage*)createImageWithColor:(UIColor*)color;
@end
