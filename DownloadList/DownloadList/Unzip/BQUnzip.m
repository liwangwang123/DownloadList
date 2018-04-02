//
//  Unzip.m
//  FaceStore
//
//  Created by lemo on 2018/1/30.
//  Copyright © 2018年 wangli. All rights reserved.
//

#import "BQUnzip.h"

@implementation BQUnzip
    // 解压
-  (void)releaseZipFilesWithUnzipFileAtPath:(NSString *)zipPath Destination:(NSString *)unzipPath{
    NSError *error;
    if ([SSZipArchive unzipFileAtPath:zipPath toDestination:unzipPath overwrite:NO password:nil error:&error delegate:self]) {
       // NSLog(@"success");
        NSLog(@"unzipPath = %@",unzipPath);
    }else {
        NSLog(@"%@",error);
    }
}
#pragma mark - SSZipArchiveDelegate
- (void)zipArchiveWillUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo {
   // NSLog(@"将要解压:%@", path);
}
- (void)zipArchiveDidUnzipArchiveAtPath:(NSString *)path zipInfo:(unz_global_info)zipInfo unzippedPath:(NSString *)unzippedPath {
    //NSLog(@"解压完成！%@", path);
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:path error:&error];
    if (error) {
        NSLog(@"删除文件失败:%@", error);
    } else {
        NSLog(@"删除文件成功");
    }
}


@end
