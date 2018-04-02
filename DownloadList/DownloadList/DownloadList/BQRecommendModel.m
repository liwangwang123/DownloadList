//
//  recommendModel.m
//  FaceStore
//
//  Created by lemo on 2018/1/24.
//  Copyright © 2018年 wangli. All rights reserved.
//

#import "BQRecommendModel.h"
#import <objc/runtime.h>
@implementation BQRecommendModel

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}
#pragma mark 获取一个类的属性列表
- (NSArray *)filterPropertys
{
    NSMutableArray* props = [NSMutableArray array];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for(int i = 0; i < count; i++){
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        [props addObject:propertyName];
        //        NSLog(@"name:%s",property_getName(property));
        //        NSLog(@"attributes:%s",property_getAttributes(property));
    }
    free(properties);
    return props;
}
#pragma mark 模型中的字符串类型的属性转化为字典
- (NSDictionary*)modelStringPropertiesToDictionary
{
    NSArray* properties = [self filterPropertys];
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    [properties enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString* key = (NSString*)obj;
        id value = [self valueForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            NSString* va =  (NSString*)value;
            if (va.length > 0) {
                [dic setObject:value forKey:key];
            }
        }
        if ([value isKindOfClass:[NSArray class]]) {
            NSArray* va =  (NSArray*)value;
            if (va.count > 0) {
                [dic setObject:value forKey:key];
            }
        }
        if ([value isKindOfClass:[NSNumber class]]) {
            [dic setObject:value forKey:key];
        }
        if ([key isEqualToString:@"ID"]) {
            [dic setObject:value forKey:@"id"];
        }
    }];
    return dic;
}
@end
