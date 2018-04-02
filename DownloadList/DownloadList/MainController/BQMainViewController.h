//
//  MainViewController.h
//  ReferenceMessage
//
//  Created by 王力 on 16/9/12.
//  Copyright © 2016年 王力. All rights reserved.
//

#import <UIKit/UIKit.h>
//数据提醒view
//#import "BQNoDataRemindersView.h"
//#import "BQExtendSizeButton.h"

@interface BQMainViewController : UIViewController

//@property (nonatomic, strong) BQNoDataRemindersView *remindersView;

- (void)addLeftBarButtonItemWithImage:(UIImage *)image;//设置leftBarbuttonItem图片
- (void)addLeftBarButtonItemWithText:(NSString *)text;//设置leftBarbuttonItem文字

- (void)addRightBarButtonItemWithImage:(UIImage *)image;//设置rightBarbuttonItem图片
- (void)addRightBarButtonItemWithText:(NSString *)text;//设置rightBarbuttonItem文字

- (void)leftBarbuttonItemAction:(UIBarButtonItem *)item;//设置leftBarbuttonItem触发方法
- (void)rightBarbuttonItemAction:(UIBarButtonItem *)item;//设置rightBarbuttonItem触发方法

- (void)setLeftBarbuttonItemColorWithColor:(UIColor *)color;//设置leftBarButtonItem的颜色
- (void)setRightBarbuttonItemColorWithColor:(UIColor *)color;//设置rightBarButtonItem的颜色
- (void)setNavigationItemTitleColorWithColor:(UIColor *)color;//设置title颜色
- (void)addTitleLabelFont:(UIFont *)font text:(NSString *)text;//设置规定大小的title
- (void)navigationBarAttributeChanges;

/*--自定义按钮,自定义文字大小和图片大小--*/
- (void)addLeftButtonWithTitle:(NSString *)title; //添加左导航栏item文字
- (void)addleftButtonWithImage:(UIImage *)image withSize:(CGSize)size;

- (void)addLeftBarButtonItemWithText:(NSString *)text font:(UIFont *)font;//设置leftBarbuttonItem文字和大小
- (void)leftButtonAction:(UIButton *)sender;//左导航栏item事件
- (void)backAction:(UIButton *)sender;
- (void)addRightButtonWithTitle:(NSString *)title; //添加右导航栏item文字
- (void)addRightBarButtonItemWithText:(NSString *)text font:(UIFont *)font;//设置leftBarbuttonItem文字和大小
- (void)addleftButtonWithImage:(UIImage *)image Title:(NSString *)title font:(UIFont *)font  withSize:(CGSize)size;

- (void)addRightButtonWithImage:(UIImage *)image withSize:(CGSize)size;//添加右导航栏item图片
//- (BQExtendSizeButton *)addButtonWithImage:(UIImage *)image size:(CGSize)size;//设置图片大小
- (void)rightButtonAction:(UIButton *)sender;//有导航栏时间
@end
