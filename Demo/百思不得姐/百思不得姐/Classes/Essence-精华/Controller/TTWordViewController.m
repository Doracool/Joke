//
//  TTWordViewController.m
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/13.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import "TTWordViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "TTTopic.h"
#import "TTTopicCell.h"
@interface TTWordViewController ()
/** 帖子数据 */
@property (nonatomic, strong) NSMutableArray *topics;
/** 当前页码 */
@property (nonatomic, assign) NSInteger page;
/** 当加载下一页数据是需要的这个参数 */
@property (nonatomic, copy) NSString *maxtime;
/** 上一次的请求参数 */
@property (nonatomic, strong) NSDictionary *params;
@end

@implementation TTWordViewController

- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupRefresh];
}
static NSString * const TTTopicCellId = @"topic";
- (void)setupTableView
{
    //设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = TTTitilesViewY + TTTitilesViewY;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    //设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TTTopicCell class]) bundle:nil] forCellReuseIdentifier:TTTopicCellId];
}

#pragma -mark 刷新控件
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    //自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}


- (void)loadNewTopics
{
    //结束上拉
    [self.tableView.mj_footer endRefreshing];
    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    self.params = params;
    
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [TTTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreTopics
{
    //结束下拉
    [self.tableView.mj_header endRefreshing];

    
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    //发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        //字典 转 模型
        NSArray *newTopics = [TTTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束刷新
        [self.tableView.mj_footer endRefreshing];
        
        //恢复页码
        self.page--;
    }];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:TTTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    
    return cell;

}

#pragma -mark 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}
@end
