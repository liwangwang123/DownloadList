//
//  HTTPManager.h
//  FaceStore
//
//  Created by lemo on 2018/1/24.
//  Copyright © 2018年 wangli. All rights reserved.
//

typedef void(^RequestFinishBlock)(id result);

#import <Foundation/Foundation.h>

/**< 用户id */
//#define theUserId @"1"

// 开发
//#define server_ip @"http://test.xyyapp.com/"
#define server_ip @"http://bq.pingpingapp.com/"

//#define server_ip @"http://test.rrzuzu.com/"

//测试环境服务器地址
//#define server_ip @"http://wx.pingpingapp.com:8080/xiaozhu"

#define TOKEN   [UserDefaults objectForKey:@"selfData"][@"token"]
/**
 *  请求成功回调
@param returnData 回调block
*/
typedef void (^RequestSuccessBlock)(id returnData);
/**
 *  请求失败回调
 *  @param error 回调block
 */
typedef void (^RequestFailureBlock)(NSError *error);

/**
 下载进度

 @param downloadProgress :
 */
typedef void(^DownloadProgressBlock)(NSProgress * downloadProgress);
/**
 下载完成回调

 @param returnData :
 */
typedef void(^DownloadCompletionBlock)(id returnData);

@interface BQHTTPManager : NSObject

@property(nonatomic,copy)RequestFinishBlock block;

+(BQHTTPManager *)defaultManager;

- (void)requesturl:(NSString *)url params:(id)params showHUD:(BOOL)showHUD successBlock:(RequestSuccessBlock)successBlock failureBlock:(RequestFailureBlock)failureBlock;

- (void)requestGETurl:(NSString *)url params:(id)params showHUD:(BOOL)showHUD successBlock:(RequestSuccessBlock)successBlock failureBlock:(RequestFailureBlock)failureBlock;

- (void)applicationrequesturl:(NSString *)url params:(id)params showHUD:(BOOL)showHUD successBlock:(RequestSuccessBlock)successBlock failureBlock:(RequestFailureBlock)failureBlock;

/**
 下载文件

 @param urlString 文件URL
 @param filePath 下载后文件的存储路径
 @param progressBlock 下载进度回调
 @param completionBlock 下载成功回调
 */
- (void)downLoadWithUrlString:(NSString *)urlString
                     filePath:(NSString *)filePath
                progressBlock:(DownloadProgressBlock)progressBlock
              completionBlock:(DownloadCompletionBlock)completionBlock;

/**
 上传头像
 */
//-(void)uploadWithUser:(NSString *)userId UrlString:(NSString *)urlString upImg:(UIImage *)upImg;

/**
 监测网络
 */
- (void)AFNetworkStatus;

//-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

@end
