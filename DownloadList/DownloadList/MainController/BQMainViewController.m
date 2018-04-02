//
//  MainViewController.m
//  ReferenceMessage
//
//  Created by 王力 on 16/9/12.
//  Copyright © 2016年 王力. All rights reserved.
//

#import "BQMainViewController.h"

@interface BQMainViewController ()

@end

@implementation BQMainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //修改状态栏的颜色,前提需要在info文件中设置 -- View controller-based status bar appearance 为 NO

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;//处理UIScrollView或者其子视图,与导航条的高度冲突问题
    [self navigationBarAttributeChanges];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = barButtonItem;
    
    //提醒数据
//    [self.view addSubview:self.remindersView];
//    self.remindersView.hidden = YES;
}

- (void)navigationBarAttributeChanges {
    //
    
            [self setRightBarbuttonItemColorWithColor:[UIColor whiteColor]];
            [self setLeftBarbuttonItemColorWithColor:[UIColor whiteColor]];
        //    [self setNavigationItemTitleColorWithColor:[UIColor whiteColor]];
        //
            self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
        //    [self setNavigationItemTitleColorWithColor:[UIColor whiteColor]];
    
//    self.tabBarController.tabBar.barTintColor = [UIColor darkGrayColor];
    
    
}

- (void)leftBarbuttonItemAction:(UIBarButtonItem *)item {
    NSLog(@"点击:leftBarbuttonItemAction");
}

- (void)addLeftBarButtonItemWithImage:(UIImage *)image {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(leftBarbuttonItemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)addLeftBarButtonItemWithText:(NSString *)text {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStyleDone target:self action:@selector(leftBarbuttonItemAction:)];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)addLeftButtonWithTitle:(NSString *)title {
    [self addLeftBarButtonItemWithText:title font:[UIFont systemFontOfSize:16]];
}
- (void)addLeftBarButtonItemWithText:(NSString *)text font:(UIFont *)font {
    UIButton *leftButton = [self addButtonTitle:text font:font titleColor:[UIColor whiteColor] backgroundColor:[UIColor clearColor]];
    CGFloat width = leftButton.frame.size.width > 44? leftButton.frame.size.width :44;
    leftButton.frame = CGRectMake(0, 0, width, 44);
//    leftButton.WidthSize = 70;
//    leftButton.HeightSize =44;
    [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)leftButtonAction:(UIButton *)sender {
    NSLog(@"leftButtonAction");
}

- (void)addleftButtonWithImage:(UIImage *)image withSize:(CGSize)size {
    UIButton *leftButton = [self addButtonWithImage:image size:size];
    [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)addleftButtonWithImage:(UIImage *)image Title:(NSString *)title font:(UIFont *)font  withSize:(CGSize)size {
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:image forState:UIControlStateNormal];
    addButton.adjustsImageWhenHighlighted =NO;
    addButton.backgroundColor = [UIColor clearColor];
    addButton.frame = CGRectMake(0, 0, size.width, size.height);
    [addButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [addButton setTitle:title forState:UIControlStateNormal];
    [addButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 10)];
    [addButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    addButton.titleLabel.font =font;
    [addButton.titleLabel sizeToFit];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)addRightButtonWithTitle:(NSString *)title {
    [self addRightBarButtonItemWithText:title font:[UIFont systemFontOfSize:16]];
}
- (void)addRightBarButtonItemWithText:(NSString *)text font:(UIFont *)font {
    UIButton *rightButton = [self addButtonTitle:text font:font titleColor:[UIColor whiteColor] backgroundColor:[UIColor clearColor]];
    [rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightButtonAction:(UIButton *)sender {
    NSLog(@"rightButtonAction");
}

- (void)addRightButtonWithImage:(UIImage *)image withSize:(CGSize)size {
    UIButton *leftButton = [self addButtonWithImage:image size:size];
    [leftButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat width = leftButton.frame.size.width > 44? leftButton.frame.size.width :44;
    leftButton.frame = CGRectMake(0, 0, width, 44);
//    leftButton.WidthSize = 70;
//    leftButton.HeightSize =44;
    [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.rightBarButtonItem = leftItem;
}
- (UIButton *)addButtonWithImage:(UIImage *)image size:(CGSize)size {
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setImage:image forState:UIControlStateNormal];
    addButton.backgroundColor = [UIColor clearColor];
    addButton.frame = CGRectMake(0, 0, size.width, size.height);
    return addButton;
}

- (void)rightBarbuttonItemAction:(UIBarButtonItem *)item {
    
}

- (void)addRightBarButtonItemWithImage:(UIImage *)image {
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(rightBarbuttonItemAction:)];
    self.navigationItem.rightBarButtonItem = leftItem;
}

- (void)addRightBarButtonItemWithText:(NSString *)text {
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStyleDone target:self action:@selector(rightBarbuttonItemAction:)];
   
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setLeftBarbuttonItemColorWithColor:(UIColor *)color {
    self.navigationItem.leftBarButtonItem.tintColor = color;
}

- (void)setRightBarbuttonItemColorWithColor:(UIColor *)color {
    self.navigationItem.rightBarButtonItem.tintColor = color;
}

- (void)setNavigationItemTitleColorWithColor:(UIColor *)color {
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:color}];
}

- (void)addTitleLabelFont:(UIFont *)font text:(NSString *)text {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    titleLabel.text = text;
    titleLabel.font = font;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLabel;
}

- (UIButton *)addButtonTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor {
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(0, 0, 60, 44);
    [addButton.titleLabel setTextAlignment:NSTextAlignmentRight];
    [addButton setTitle:title forState:UIControlStateNormal];
    [addButton setTitleColor:titleColor forState:UIControlStateNormal];
    [addButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 15)];
    addButton.backgroundColor = backgroundColor;
    addButton.titleLabel.font = font;
    return addButton;
}

- (UILabel *)addLabelTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor {
    UILabel *addLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    addLabel.text = title;
    addLabel.textColor = titleColor;
    addLabel.backgroundColor = backgroundColor;
    addLabel.userInteractionEnabled = YES;
    addLabel.font = font;
    return addLabel;
}

//- (BQNoDataRemindersView *)remindersView {
//    if (!_remindersView) {
//        _remindersView = [[BQNoDataRemindersView alloc] initWithFrame:CGRectMake(0, 64, BQScreenWidth, BQScreenHeight - 64)];
//    }
//    return _remindersView;
//}

- (void)dealloc {
    NSLog(@"释放:%@", NSStringFromClass([self class]));
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
