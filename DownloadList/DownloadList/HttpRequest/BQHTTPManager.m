    //
    //  HTTPManager.m
    //  FaceStore
    //
    //  Created by lemo on 2018/1/24.
    //  Copyright © 2018年 wangli. All rights reserved.
    //
#import "BQHTTPManager.h"
//#import "MBProgressHUD+Add.h"
#import "JRToast.h"
#import "NSString+Valid.h"

static BQHTTPManager *manager = nil;

@implementation BQHTTPManager
-(id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+(BQHTTPManager *)defaultManager{
    if (manager == nil) {
        manager = [[BQHTTPManager alloc]init];
    }
    return manager;
}

/***/

/* --------------------------------------***/
- (void)requesturl:(NSString *)url params:(id)params showHUD:(BOOL)showHUD successBlock:(RequestSuccessBlock)successBlock failureBlock:(RequestFailureBlock)failureBlock{
    if (showHUD==YES) {
        [SVProgressHUD show];
//
//        SVProgressHUD.defaultMaskType =SVProgressHUDMaskTypeClear;
    }
    NSString *urlstring =[NSString stringWithFormat:@"%@%@",server_ip,url];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager.requestSerializer setValue:@"gVTXMOWz" forHTTPHeaderField:@"APP-KEY"];//@"APP-KEY"
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/plain",@"text/javascript", nil];
    manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    // 设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 5.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    BQWS(weakSelf);
    [manager POST:urlstring parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
            //        NSLog(@"responseObject---%@",responseObject);
        if (successBlock) {
            if (responseObject) {
//                NSInteger code = [responseObject[@"code"] integerValue];
//                [self succeedWithCode:code];
            }
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        
            //        Log(@"error~~~~%@",error);
        if (failureBlock) {
            [weakSelf errorWithCode:error.code];
            failureBlock(error);
        }
    }];
    
}
- (void)applicationrequesturl:(NSString *)url params:(id)params showHUD:(BOOL)showHUD successBlock:(RequestSuccessBlock)successBlock failureBlock:(RequestFailureBlock)failureBlock{
    NSString *urlstring =[NSString stringWithFormat:@"%@%@",server_ip,url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer =  [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"gVTXMOWz" forHTTPHeaderField:@"APP-KEY"];
    //@"APP-KEY"

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",@"text/plain", nil];
    manager.requestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;

    BQWS(weakSelf);
    //  manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:urlstring parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        //        NSLog(@"responseObject---%@",responseObject);
        if (successBlock) {
            if (responseObject) {
                NSInteger code = [responseObject[@"code"] integerValue];
                if (code == 31000) {
                    
                    return;
                }
            }
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        
        //        Log(@"error~~~~%@",error);
        if (failureBlock) {
            [weakSelf errorWithCode:error.code];
            failureBlock(error);
        }
    }];
    
}

-(void)succeedWithCode:(NSInteger)code{
    switch (code) {
        case 12000:
            [JRToast showWithText:@"请求成功" duration:1.0f];
            break;
        case 13000:
            [JRToast showWithText:@"请求失败" duration:1.0f];
            break;
        case 14000:
            [JRToast showWithText:@"appkey为空" duration:1.0f];
            break;
        case 14100:
            [JRToast showWithText:@"appkey无效" duration:1.0f];
            break;
            
        default:
            break;
    }
    
    
    if (code == -1011) { //
        
        [JRToast showWithText:@"网络连接错误" duration:1.0f];
    }else if (code == -1001){ //网络请求超时
        [JRToast showWithText:@"网络连接错误" duration:1.0f];
    }else if (code == -1004){//无法连接到服务器
        [JRToast showWithText:@"网络连接错误" duration:1.0f];
    }else if (code == 3840){
        [[NSNotificationCenter defaultCenter]postNotificationName:@"gologin" object:nil];
    }else if (code == 31000){ // 封号
        
    }else {
        [JRToast showWithText:@"网络未知错误" duration:1.0f];
    }
}

-(void)errorWithCode:(NSInteger)code{
    if (code == -1011) { //
        
                    [JRToast showWithText:@"网络连接错误" duration:1.0f];
    }else if (code == -1001){ //网络请求超时
                                      [JRToast showWithText:@"网络连接错误" duration:1.0f];
    }else if (code == -1004){//无法连接到服务器
                                     [JRToast showWithText:@"网络连接错误" duration:1.0f];
    }else if (code == 3840){
        [[NSNotificationCenter defaultCenter]postNotificationName:@"gologin" object:nil];
    }else if (code == 31000){ // 封号
        
    }else {
                    [JRToast showWithText:@"网络未知错误" duration:1.0f];
    }
}
- (void)requestGETurl:(NSString *)url params:(id)params showHUD:(BOOL)showHUD successBlock:(RequestSuccessBlock)successBlock failureBlock:(RequestFailureBlock)failureBlock{
//    if (showHUD==YES) {
//        [SVProgressHUD show];
//
//        SVProgressHUD.defaultMaskType =SVProgressHUDMaskTypeClear;
//    }

    NSString *urlstring =[NSString stringWithFormat:@"%@%@",server_ip,url];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

//    WS(weakSelf);
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    [manager.requestSerializer setValue:@"gVTXMOWz" forHTTPHeaderField:@"APP-KEY"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html", @"text/plain", nil];
    
    [manager GET:urlstring parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [SVProgressHUD dismiss];
//        if (successBlock) {
//            if (responseObject) {
//                NSInteger code = [responseObject[@"code"] integerValue];
//                if (code == 31000) {
//
//                    return;
//                }
//            }
//        }
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [SVProgressHUD dismiss];
        
//        if (failureBlock) {
//            [weakSelf errorWithCode:error.code];
//        }
        failureBlock(error);
    }];
    
}
- (void)downLoadWithUrlString:(NSString *)urlString
                     filePath:(NSString *)filePath
                progressBlock:(DownloadProgressBlock)progressBlock
              completionBlock:(DownloadCompletionBlock)completionBlock
{
    
        // 1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        // 2.设置请求的URL地址
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    urlString = [NSString returnFormatString:urlString];
    NSURL *url = [NSURL URLWithString:urlString];
        // 3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
        // 4.下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            // 下载进度
        if (progressBlock) {
            if (downloadProgress) {
                progressBlock(downloadProgress);
            }
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            // 下载地址
        BQLog(@"默认下载地址%@",targetPath);
            // 设置下载路径,通过沙盒获取缓存地址,最后返回NSURL对象
        NSString *basefilePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [basefilePath stringByAppendingPathComponent:@"face"];
        NSFileManager *filemanager = [NSFileManager defaultManager];
        if (![filemanager fileExistsAtPath:path]) {
            [filemanager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        }
 
        return [NSURL fileURLWithPath:[path stringByAppendingPathComponent:filePath]]; // 返回的是文件存放在本地沙盒的地址
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            // 下载完成调用的方法
        BQLog(@"%@---%@", response, filePath);
        
        if (completionBlock) {
            if (response) {
                completionBlock(response);
            }
        }
    }];
        // 5.启动下载任务
    [task resume];
}



/**
 监测网络
 */
- (void)AFNetworkStatus{
    
        //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            //这里是监测到网络改变的block
            //在里面可以随便写事件
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                BQLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                BQLog(@"无网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                BQLog(@"蜂窝数据网");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                BQLog(@"WiFi网络");
                
                break;
                
            default:
                break;
        }
        
    }] ;
    
    
    [manager startMonitoring];
}


-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}


/**
 上传头像
 */
-(void)uploadWithUser:(NSString *)userId UrlString:(NSString *)urlString upImg:(UIImage *)upImg{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *parma = @{@"userId":userId};
    
    [manager POST:urlString parameters:parma constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /******** 1.上传已经获取到的img *******/
            // 把图片转换成data
        NSData *data = UIImagePNGRepresentation(upImg);
        
            // 拼接数据到请求题中
        [formData appendPartWithFileData:data name:@"file" fileName:@"123.png" mimeType:@"image/png"];
        /******** 2.通过路径上传沙盒或系统相册里的图片 *****/
            //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"文件地址"] name:@"file" fileName:@"1234.png" mimeType:@"application/octet-stream" error:nil];
        
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        BQLog(@"%lf",1.0 *uploadProgress.completedUnitCount/ uploadProgress.totalUnitCount);
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        BQLog(@"成功： %@",responseObject);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        BQLog(@"失败 %@",error);
    }];
    
}
@end
