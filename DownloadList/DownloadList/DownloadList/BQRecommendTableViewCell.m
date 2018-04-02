//
//  RecommendTableViewCell.m
//  FaceStore
//
//  Created by lemo on 2018/1/24.
//  Copyright © 2018年 wangli. All rights reserved.
//

#import "BQRecommendTableViewCell.h"
#import "BQRecommendModel.h"

@implementation BQRecommendTableViewCell

- (void)setModel:(BQRecommendModel *)model {
    _model = model;
    switch ([model.isDelete intValue]) {
        case 0: {//已下载
            self.progressView.hidden = YES;
            self.downloadButton.hidden = NO;
            self.downloadButton.layer.borderWidth = 1;
            self.downloadButton.layer.borderColor = [UIColor colorWithHexString:@"#bbb9b9"].CGColor;
            [self.downloadButton setTitleColor:[UIColor colorWithHexString:@"#bbb9b9"] forState:UIControlStateNormal];
            [self.downloadButton setTitle:@"已下载" forState:UIControlStateNormal];
            self.downloadButton.enabled = NO;
        }
            break;
        case 1: {//未下载
            self.downloadButton.layer.borderColor = [UIColor colorWithHexString:@"#3fa112"].CGColor;
            [self.downloadButton setTitleColor:[UIColor colorWithHexString:@"#3fa112"] forState:UIControlStateNormal];
            self.downloadButton.enabled = YES;
            self.downloadButton.layer.borderWidth = 1;
            [self.downloadButton setTitle:@"下载" forState:UIControlStateNormal];
            self.downloadButton.hidden = NO;
            self.progressView.hidden = YES;
        }
            break;
        case 2: {//正在下载
            self.downloadButton.hidden = YES; 
            self.progressView.hidden = NO;
            self.progressView.progress = model.progress;
        }
            break;
            
        default:
            break;
    }    
    self.nameLabel.text = model.name;
    self.explainLabel.text = model.shortIntro;
    
    [self.headerView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"default_120_120"]];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    self.downloadButton.layer.cornerRadius = 5;
    self.downloadButton.layer.masksToBounds = YES;
    self.progressView.layer.cornerRadius = 4.5;
    self.progressView.layer.masksToBounds = YES;
    CGRect frame = self.downloadButton.frame;
    frame.size = CGSizeMake(70, 70);
    self.downloadButton.frame = frame;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}



@end
