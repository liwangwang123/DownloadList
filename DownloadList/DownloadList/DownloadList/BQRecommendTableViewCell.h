//
//  RecommendTableViewCell.h
//  FaceStore
//
//  Created by lemo on 2018/1/24.
//  Copyright © 2018年 wangli. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BQCustomButton.h"
#import "BQProgressView.h"
//#import "BQExtendSizeButton.h"
@class BQRecommendModel;

typedef enum : NSUInteger {
    DownloadButtonTypeNotDownload,//未下载
    DownloadButtonTypeIsDownloading,//正在下载
    DownloadButtonTypeHaveDownloaded,//已下载
} DownloadButtonType; /**< 按钮类型 */


//推进表情cell
@interface BQRecommendTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (weak, nonatomic) IBOutlet BQProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIImageView *headerView;/**< 图片*/

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;/**< 名称 */

@property (weak, nonatomic) IBOutlet UILabel *explainLabel;/**< 简介 */

@property (nonatomic, strong) BQRecommendModel *model;
@end


