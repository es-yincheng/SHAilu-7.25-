//
//  YCPhotoBrowser.m
//  YCPhotosPiker
//
//  Created by yc on 16/5/26.
//  Copyright © 2016年 yc. All rights reserved.
//

#import "YCPhotoBrowser.h"
#import "YCPhotoAblumList.h"
#import "YCPhotoTool.h"
#import "YCPhotoBrowserCell.h"
#import "YCThumbnailViewController.h"

@interface YCPhotoBrowser ()
{
    NSMutableArray<YCPhotoAblumList *> *_arrayDataSources;
    YCPhotoTool *photoTool;
}
@end

@implementation YCPhotoBrowser

- (void)viewDidLoad {
    [super viewDidLoad];
    
    photoTool = [[YCPhotoTool alloc] init];
    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    self.title = @"照片";
    
    _arrayDataSources = [[NSMutableArray alloc] init];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self initNavBtn];
    [self loadAblums];

}

- (void)initNavBtn
{
    //导航栏颜色
    [self.navigationController.navigationBar setBackgroundImage:[self drawImageWithSize:CGSizeMake(ScreenWith, 64) color:RGBCOLOR(216, 86, 77)] forBarMetrics:UIBarMetricsDefault];
    //左右按钮、文本颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //title 颜色
    NSDictionary * dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(navRightBtn_Click)];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.hidesBackButton = YES;
}

- (void)navRightBtn_Click
{
    if (self.CancelBlock) {
        self.CancelBlock();
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadAblums
{
    [_arrayDataSources addObjectsFromArray:[photoTool getPhotoAblumList]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _arrayDataSources.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YCPhotoBrowserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YCPhotoBrowserCell"];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YCPhotoBrowserCell" owner:self options:nil] lastObject];
    }
    
    YCPhotoAblumList *ablumList= _arrayDataSources[indexPath.row];
    
    [photoTool requestImageForAsset:ablumList.headImageAsset size:CGSizeMake(44, 44) resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage *image) {
        cell.headImageView.image = image;
    }];
    cell.labTitle.text = ablumList.title;
    cell.labCount.text = [NSString stringWithFormat:@"(%ld)", ablumList.count];
    cell.headImageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.headImageView.clipsToBounds = YES;

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YCPhotoAblumList *ablum = _arrayDataSources[indexPath.row];
    
    YCThumbnailViewController *tvc = [[YCThumbnailViewController alloc] init];
    tvc.title = ablum.title;
    tvc.maxSelectCount = self.maxSelectCount;
    tvc.assetCollection = ablum.assetCollection;
    tvc.arraySelectPhotos = self.arraySelectPhotos.mutableCopy;
    tvc.sender = self;
    tvc.DoneBlock = self.DoneBlock;
    tvc.CancelBlock = self.CancelBlock;
    [self.navigationController pushViewController:tvc animated:YES];
}

@end
