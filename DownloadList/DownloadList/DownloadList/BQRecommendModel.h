//
//  recommendModel.h
//  FaceStore
//
//  Created by lemo on 2018/1/24.
//  Copyright © 2018年 wangli. All rights reserved.

//推荐表情

#import <Foundation/Foundation.h>

@interface BQRecommendModel : NSObject
//0已下载  1 未下载  2 正在下载
@property (nonatomic, strong) NSNumber *isDelete;
/**<下载百分比 ,只有当正在下载的时候,才需要赋值*/
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, copy) NSString *name; /**< 名称 */
@property (nonatomic, copy) NSString *cover;/**< 图片连接 */
@property (nonatomic, copy) NSString *shortIntro;/**< 信息 */
@property (nonatomic, copy) NSString *ID;/**< 表情包id */
@property (nonatomic, copy) NSString *resource; /**< 资源key */

- (instancetype)initWithDic:(NSDictionary *)dic;
- (NSDictionary*)modelStringPropertiesToDictionary;
@end
