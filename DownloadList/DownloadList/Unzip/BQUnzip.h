//
//  Unzip.h
//  FaceStore
//
//  Created by lemo on 2018/1/30.
//  Copyright © 2018年 wangli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SSZipArchive.h>
//#import "BQFaceDetailsModel.h"
@interface BQUnzip : NSObject <SSZipArchiveDelegate>

//解压
- (void)releaseZipFilesWithUnzipFileAtPath:(NSString *)zipPath Destination:(NSString *)unzipPath;
//存本地数据
- (void)getZipDatawithID:(NSString *)faceid withFileName:(NSString *)fileName andInfo:(NSDictionary *)info;
@end
