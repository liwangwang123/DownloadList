//
//  StoreViewController.m
//  FaceStore
//
//  Created by lemo on 2018/1/24.
//  Copyright © 2018年 wangli. All rights reserved.
//

#import "BQStoreViewController.h"
#import "BQRecommendTableViewCell.h"
//#import "BQFaceDetailsViewController.h"
//#import "BQMyFaceViewController.h"
//#import "OSS_Manager.h"
//轮播图
//#import <SDCycleScrollView.h>

//推荐表情model
#import "BQRecommendModel.h"
//轮播model
//#import "BQBannerModel.h"

#define cellIdentifier @"BQRecommendTableViewCell"
#define scrollViewHeight 200


/**<zipFilePath: 下载路径*/
typedef void(^DownloadBlock)(NSString *zipFilePath,NSInteger modelindex,NSError *error);
typedef void(^DownloadProgress)(CGFloat progress, NSInteger idnex, NSIndexPath * tableViiewCellIndex);/**< 下载进度*/

@interface BQStoreViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSInteger _pageNumber;
}

@property (nonatomic, strong) NSMutableArray *dataArray; /**< 数据源 */
@property (nonatomic, strong) NSMutableArray *bannerArray; /**< 轮播图数据源 */
@property (nonatomic, strong) NSOperationQueue *operationQueue;//下载队列
@property (nonatomic, strong) NSMutableArray *downloadDataSource;//下载model数组
@property (nonatomic, strong) NSMutableArray * cellIndexArray;
@property (nonatomic, copy)   DownloadBlock downloadBlock;

@end

@implementation BQStoreViewController

- (void)viewWillAppear:(BOOL)animated {
//    _pageNumber = 0;
//    [self addDataSourcePageNumber:_pageNumber];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pageNumber = 0;
//    [self addBannerData];
    
    
    //title
    [self addTitleLabelFont:[UIFont systemFontOfSize:20] text:@"表情商城"];
    //leftItem
    [self addLeftButtonWithTitle:@"关闭"];
    //rightItem
    [self addRightButtonWithImage:[UIImage imageNamed:@"shezhi"] withSize:CGSizeMake(16, 16)];
    
    [self.view addSubview:self.tableView];
    
    [self addDataSourcePageNumber:_pageNumber];
}

- (void)leftButtonAction:(UIButton *)sender {
    if (self.navigationController.topViewController == self)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
    NSLog(@"点击关闭");
}
//
- (void)rightButtonAction:(UIButton *)sender {
//    BQMyFaceViewController *myFace = [[BQMyFaceViewController alloc] init];
//    [self.navigationController pushViewController:myFace animated:NO];
    NSLog(@"进入设置界面");
}

//轮播图数据
//- (void)addBannerData {
//    BQWS(weakSelf);
//    NSDictionary *params = @{@"showType":@"1"};
//    [[BQHTTPManager defaultManager] requesturl:BannerList params:params showHUD:NO successBlock:^(id returnData) {
//        NSDictionary *result = returnData;
//        NSNumber *code = result[@"code"];
//        if ([code isEqual:@12000]) {
//            NSArray *resultArray = returnData[@"result"];
//            for (NSDictionary *modelDic in resultArray) {
//                BQBannerModel *model = [[BQBannerModel alloc] initWithDic:modelDic];
//                [self.bannerArray addObject:model];
//            }
//
//            [weakSelf addScrollView];
//        }
//        [weakSelf.tableView reloadData];
//    } failureBlock:^(NSError *error) {
//        NSLog(@"error:%@", error);
//    }];
//}

//界面数据
- (void)addDataSourcePageNumber:(NSInteger)pageNumber {
    if (pageNumber == 0) {
        [self.dataArray removeAllObjects];
    }
    //分页获取数据
    NSString *page = [NSString stringWithFormat:@"%ld", pageNumber];
    BQWS(weakSelf);
    NSDictionary *params = @{@"page":page, @"size":@"10", @"userId":BQFaceStoreUid};
    [[BQHTTPManager defaultManager] requesturl:RecommendFace params:params showHUD:NO successBlock:^(id returnData) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        NSDictionary *result = returnData;
        NSNumber *code = result[@"code"];
        if ([code isEqual:@12000]) {
            NSArray *resultArray = returnData[@"result"];
            if (resultArray.count > 0) {
                weakSelf.tableView.hidden = NO;
//                weakSelf.remindersView.hidden = YES;
                for (NSDictionary *modelDic in resultArray) {
                    BQRecommendModel *model = [[BQRecommendModel alloc] initWithDic:modelDic];
                    [self.dataArray addObject:model];
                }
            }
            if (self.dataArray.count < (pageNumber +1) *10) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                
            }
        } else {
            weakSelf.tableView.hidden = YES;
//            weakSelf.remindersView.hidden = NO;
        }
            
        [weakSelf.tableView reloadData];
    } failureBlock:^(NSError *error) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        NSLog(@"error:%@", error);
        weakSelf.tableView.hidden = YES;
//        weakSelf.remindersView.hidden = NO;
    }];
}

//添加轮播图
- (void)addScrollView {
//    NSMutableArray *banberUrls = [NSMutableArray array];
//    for (BQBannerModel *model in self.bannerArray) {
//        [banberUrls addObject:model.imgUrl];
//    }
//
//    //headerView
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BQScreenWidth, BQScreenWidth * 0.53 + 41)];
//    headerView.backgroundColor = [UIColor whiteColor];
//
//    BQWS(weakSelf);
//    //轮播图 宽高比是1: 0.53
//    SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, BQScreenWidth, BQScreenWidth * 0.53) delegate:self placeholderImage:[UIImage imageNamed:@"default _750_400"]];
//    scrollView.pageDotColor = [UIColor colorWithWhite:0 alpha:0.3];
//    scrollView.imageURLStringsGroup = banberUrls;
//    scrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
//    scrollView.clickItemOperationBlock = ^(NSInteger currentIndex) {
//        BQFaceDetailsViewController *faceDetails = [[BQFaceDetailsViewController alloc] init];
//        BQBannerModel *bannerModel = self.bannerArray[currentIndex];
//
////        跳转到详情界面的时候,如果不先设置详情界面的title(在详情界面网络请求,拿到title的值)就会出现,title从leftBurButton的位置,移动title的位置,现在有两个解决方案:1, 提前拿到title的值,2, 跳转的时候,不使用动画
////        NSString *faceId = bannerModel.faceId;
////        NSDictionary *params = @{@"faceId":faceId, @"userId":BQFaceStoreUid};
////        [[BQHTTPManager defaultManager]requesturl:DatailPage params:params showHUD:YES successBlock:^(id returnData) {
////            NSDictionary *result = returnData;
////            NSNumber *code = result[@"code"];
////            if ([code isEqual:@12000]) {
////                NSDictionary *resultDic = returnData[@"result"];
////                bannerModel.name = resultDic[@"name"];
////            }
////        } failureBlock:^(NSError *error) {
////
////        }];
//        faceDetails.bannerModel = bannerModel;
//        [weakSelf.navigationController pushViewController:faceDetails animated:NO];
//
//    };
    
    //title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, BQScreenWidth * 0.53, BQScreenWidth - 20, 41)];
    titleLabel.text = @"推荐表情";
    titleLabel.font = [UIFont systemFontOfSize:16];
//    [headerView addSubview:titleLabel];
//    [headerView addSubview:scrollView];
    
    //line
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(18, BQScreenWidth * 0.53 + 40, BQScreenWidth - 18, 0.2)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#dcdcdc"];
//    [headerView addSubview:lineView];
    
//    self.tableView.tableHeaderView = headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BQRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    if (self.dataArray.count > indexPath.row) {
        cell.model = self.dataArray[indexPath.row];
    }
   
    NSLog(@"isDelete:%@, %@", cell.model.isDelete, indexPath);
    cell.downloadButton.tag = indexPath.row;
    [cell.downloadButton addTarget:self action:@selector(downloadAction:) forControlEvents:UIControlEventTouchUpInside];
    //移除点击效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 78;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    BQFaceDetailsViewController *faceDetails = [[BQFaceDetailsViewController alloc] init];
//    BQRecommendModel *model1 = self.dataArray[indexPath.row];
//    BQWS(weakSelf);
//    faceDetails.loadSuccessBlock = ^(BOOL isSuccess){
//        if (isSuccess) {
//            model1.isDelete =0;
//            [weakSelf.dataArray  replaceObjectAtIndex:indexPath.row withObject:model1];
//            [weakSelf.tableView reloadData];
//        }
//    };
//
//    BQBannerModel *model2 = [[BQBannerModel alloc] init];
//    model2.faceId = model1.ID;
//    model2.isDelete = model1.isDelete;
//    model2.name = model1.name;
//    faceDetails.bannerModel = model2;
//    [self.navigationController pushViewController:faceDetails animated:YES];
}

/**<下载表情包--获取表情包下载链接*/
- (void)downloadAction:(UIButton *)sender {
    BQWS(weakSelf);
    NSLog(@"tag:%ld", (long)sender.tag);
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    BQRecommendModel *model = self.dataArray[indexPath.row];
    [self.downloadDataSource addObject:model];
    NSDictionary *parame = @{@"key":model.resource};
    [self initdownloadProgress:0 withIndex:self.downloadDataSource.count - 1];
    [[BQHTTPManager defaultManager] requestGETurl:GetSignurl params:parame showHUD:NO successBlock:^(id returnData) {
        NSLog(@"returnData:%@", returnData);
        NSDictionary *resultDic = returnData[@"result"];
        NSString *url = resultDic[@"url"];
        [weakSelf downloadUrl:url withFileName:model.resource withIndex:weakSelf.downloadDataSource.count - 1 tableViewCellIndex:indexPath];
        NSLog(@"url:%@", url);
    } failureBlock:^(NSError *error) {
        [SVProgressHUD dismiss];
        NSLog(@"error:%@", error);
    }];
}
- (void)initdownloadProgress:(CGFloat)downloadProgress withIndex:(NSInteger)index {
    BQWS(weakSelf);
    BQRecommendModel *model1 = [weakSelf.downloadDataSource objectAtIndex:index];
    [model1 setProgress:downloadProgress];
    if (model1.progress == 1.0) {//下载完成
        if (![model1.isDelete isEqual:@0]) {
            model1.isDelete = @0;
        }
    } else {//正在下载
        if (![model1.isDelete isEqual:@2]) {
            model1.isDelete = @2;
        }
    }
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [weakSelf.tableView reloadData];
    }];
}
/**<根据表情包下载链接下载表情包并解压*/
- (void)downloadUrl:(NSString *)urlString withFileName:(NSString *)fileName withIndex:(NSInteger)index tableViewCellIndex:(NSIndexPath *)cellIndex {
    BQWS(weakSelf);
    [self downloadWithUrlString:urlString withFileName:fileName withComplaction:^(NSString *zipFilePath,NSInteger index, NSError *error) {
        if (!error) {
                //下载完成, 解压文件,把zip包删除
            BQUnzip *zip = [[BQUnzip alloc] init];
            [zip releaseZipFilesWithUnzipFileAtPath:zipFilePath Destination:[zipFilePath substringToIndex:zipFilePath.length - 4]];
            NSArray *zipArr = [fileName componentsSeparatedByString:@"/"];
            NSString * str = [zipArr lastObject];
            NSString *file = [str substringToIndex:str.length - 4];
            BQRecommendModel *model =self.dataArray[index];
            [self getZipDatawithInfo:model  withFileName:file];
        } else {
            NSLog(@"下载错误:%@", error);
        }
    } downloadProgress:^(CGFloat progress, NSInteger idnex, NSIndexPath *tableViiewCellIndex) {
        NSLog(@"progress:%f", progress);
        BQRecommendModel *model1 = [weakSelf.downloadDataSource objectAtIndex:index];
        [model1 setProgress:progress];
        if (model1.progress == 1.0) {//下载完成
            if (![(NSNumber *)model1.isDelete isEqual:@0]) {
                model1.isDelete = @0;
            }
        } else {//正在下载
            if (![(NSNumber *)model1.isDelete isEqual:@2]) {
                model1.isDelete = @2;
            }
        }
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [weakSelf.tableView reloadData];
        }];
    } withIndex:index tableViewCellIndex:cellIndex];
}
- (void)getZipDatawithInfo:(BQRecommendModel *)info withFileName:(NSString *)fileName
{
    NSDictionary *parame = @{@"faceId":info.ID};
    [[BQHTTPManager defaultManager] requestGETurl:DetailGet params:parame showHUD:NO successBlock:^(id returnData) {
        NSInteger code = [returnData[@"code"] integerValue];
        if (code == 12000) {
            NSDictionary *result = returnData[@"result"];
            NSArray *dicArr = result[@"faceDetails"];
            NSMutableDictionary *emojiDic = [NSMutableDictionary dictionary];
            emojiDic[@"cover"] = info.cover;
            emojiDic[@"iconPath"] = [NSString stringWithFormat: @"/%@/icon.png",fileName];
            emojiDic[@"coverPath"] = [NSString stringWithFormat: @"/%@/cover.png",fileName];
            emojiDic[@"intro"] = info.shortIntro;
            emojiDic[@"name"] = info.name;
            emojiDic[@"fileName"] = [NSString stringWithFormat: @"/%@",fileName];
            emojiDic[@"id"] = info.ID;
            emojiDic[@"resource"] = info.resource;
            NSMutableArray *detailsArr = [NSMutableArray array];
            for (int i =0; i <dicArr.count; i++) {
                NSDictionary *resultDic = dicArr[i];
                NSMutableDictionary *modedic = [NSMutableDictionary dictionary];
                modedic[@"id"] = resultDic[@"id"];
                modedic[@"keyword"] =resultDic[@"keyword"];
                modedic[@"fullpath"] = i +1 > 9?[NSString stringWithFormat:@"/%@/%d",fileName,i+1] :[NSString stringWithFormat:@"/%@/0%d",fileName,i+1];
                [detailsArr addObject:modedic];
            }
            emojiDic[@"details"] =detailsArr;
//            [BQFaceEmojiManage saveEmojiWithPath:emojiDic];
        }
    } failureBlock:^(NSError *error) {
        
    }];
}
/**<表情包下载过程*/
-(void)downloadWithUrlString:(NSString*)urlString withFileName:(NSString*)fileName withComplaction:(DownloadBlock)newBlock downloadProgress:(DownloadProgress)downloadProgressBlock withIndex:(NSInteger)index tableViewCellIndex:(NSIndexPath *)cellIndex {
    [self.cellIndexArray addObject:cellIndex];
    BQWS(weakSelf);
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSString *filePath1 = [[fileName componentsSeparatedByString:@"/"] lastObject];
        NSString *filaPath = [[NSString alloc] initWithFormat:@"%@/%@", AllEmoji_PAHT(BQFaceStoreUid), filePath1];
        NSLog(@"currentThread:%@", [NSThread currentThread]);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        NSURLSessionDownloadTask *download = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            downloadProgressBlock((downloadProgress.completedUnitCount * 1.0 / downloadProgress.totalUnitCount), index, cellIndex);
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                //NSString *name = [NSString stringWithFormat:@"/%@.zip", fileName];
                //如果需要直接下载到文件，需要指明目标文件地址
            NSLog(@"%@", filaPath);
            return [NSURL fileURLWithPath:filaPath];
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            newBlock(filaPath, cellIndex.row,error);
                //newBlock(nil, error);
            if (!error) {
                [weakSelf downLoadSuccess:index];
            }
        }];
        [download resume];
    }];
    [self.operationQueue addOperation:operation];
}

/**<表情包下载完成,通知后台*/
- (void)downLoadSuccess:(NSInteger)indexModel {
    BQRecommendModel *model1 = [self.downloadDataSource objectAtIndex:indexModel];
    NSDictionary *parame = @{@"userId":BQFaceStoreUid, @"faceId":model1.ID};
    [[BQHTTPManager defaultManager] requesturl:DownloadFace params:parame showHUD:NO successBlock:^(id returnData) {
        NSNumber *code = returnData[@"code"];
        if ([code isEqual:@12000]) {
            NSLog(@"下载接口成功");
        }
        NSLog(@"returnData:%@", returnData);
    } failureBlock:^(NSError *error) {
        NSLog(@"error:%@", error);
    }];
    
}
- (void)headerRefresh {
    [self addDataSourcePageNumber:0];
    _pageNumber = 0;
}

- (void)footerRefresh {
    _pageNumber += 1;
    [self addDataSourcePageNumber:_pageNumber];
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BQNAVIGATIONBARHEIGHT, BQScreenWidth, BQScreenHeight - BQNAVIGATIONBARHEIGHT)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self headerRefresh];
        }];
        header.lastUpdatedTimeLabel.hidden = YES;
        _tableView.mj_header = header;
        _tableView.mj_footer =  [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
        [_tableView.mj_footer setAutomaticallyChangeAlpha:YES];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.tableFooterView = [self fooderView];
        _tableView.separatorColor = [UIColor colorWithHexString:@"#dcdcdc"];
        [_tableView registerNib:[UINib nibWithNibName:@"BQRecommendTableViewCell" bundle:nil] forCellReuseIdentifier:@"BQRecommendTableViewCell"];
    }
    return _tableView;
}

- (UIView *)fooderView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, BQScreenWidth, BQ_IPHONEX_BOTTOM_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)bannerArray {
    if (!_bannerArray) {
        _bannerArray = [NSMutableArray array];
    }
    return _bannerArray;
}

- (NSOperationQueue *)operationQueue {
    if (!_operationQueue) {
        _operationQueue= [[NSOperationQueue alloc] init];
        _operationQueue.maxConcurrentOperationCount = 4;
    }
    return _operationQueue;
}

- (NSMutableArray *)downloadDataSource {
    if (!_downloadDataSource) {
        _downloadDataSource = [NSMutableArray array];
    }
    return _downloadDataSource;
}

- (NSMutableArray *)cellIndexArray {
    if (!_cellIndexArray) {
        _cellIndexArray = [NSMutableArray array];
    }
    return _cellIndexArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
