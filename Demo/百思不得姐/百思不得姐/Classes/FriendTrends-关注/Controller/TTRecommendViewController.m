//
//  TTRecommendViewController.m
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/8.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import "TTRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "TTRecommendCategoryCell.h"
#import <MJExtension.h>
#import "TTRecommendCategory.h"
#import "TTRecommendUserCell.h"
#import "TTRecommendUser.h"
#import <MJRefresh.h>

#define TTSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]
@interface TTRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 左边的类别数据 **/
@property (nonatomic, strong) NSArray *categories;
/** 左边的类别表格 **/
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右边的类别表格 **/
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/** 请求参数 **/
@property (nonatomic, strong) NSMutableDictionary *params;
/** AFN请求管理者 **/
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation TTRecommendViewController
static NSString * const TTCategoryId = @"category";
static NSString * const TTUserId = @"user";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //控件的初始化
    [self setupTableView];
    
    //添加刷新控件
    [self setupRefresh];
    
    //加载左侧的类别数据
    [self loadCategories];
    
}

- (void)loadCategories{
    //显示指示器
    [SVProgressHUD showWithStatus:@"正在加载"];
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //隐藏指示器
        [SVProgressHUD dismiss];
        
        //返回服务器的JSON数据
        self.categories = [TTRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //刷新表格
        [self.categoryTableView reloadData];
        
        //默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        //让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败"];
    }];
}

- (void)setupTableView
{
    //注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TTRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:TTCategoryId];
    //注册
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TTRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:TTUserId];
    
    //设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    //设置标题
    self.title = @"推荐关注";
    
    //设置背景色
    self.view.backgroundColor = TTGlobalBg;
}

/**
 * 添加刷新控件
 */
- (void)setupRefresh
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = YES;
}

#pragma -mark 加载用户数据
- (void)loadNewUsers
{
    TTRecommendCategory *rc = TTSelectedCategory;
    //设置当前页码为1
    rc.currentPage = 1;
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPage);
    self.params = params;
    
    //发送请求给服务器请求右侧数据
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典数组 -> 模型数组
        NSArray *users = [TTRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //清除所有的旧数据
        [rc.users removeAllObjects];
        
        //添加到当前类别对应的用户数组
        [rc.users addObjectsFromArray:users];
        
        //保存总数
        rc.total = [responseObject[@"total"] integerValue];
        
        //不是最后一次请求
        if (self.params != params) return;
        
        //刷新右边表格
        [self.userTableView reloadData];
        
        //结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        //让底部控件结束刷新
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        //提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        //刷新结束
        [self.userTableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreUsers
{
    TTRecommendCategory *category = TTSelectedCategory;
    
    //发送请求给服务器
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //字典数组 -> 模型数组
        NSArray *users = [TTRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
        //不是最后一次请求
        if (self.params != params) return;
        
        //刷新右边的表格
        [self.userTableView reloadData];
        
        //让底部控件结束刷新
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return;
        
        //提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        //让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }];
}

/**
 * 时刻检测footer的状态
 */
- (void)checkFooterState
{
    TTRecommendCategory *rc = TTSelectedCategory;
    
    //每次刷新右边数据时 后控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden = (rc.users.count == 0);
    
    //让底部控件结束刷新
    if (rc.users.count == rc.total) {
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.userTableView.mj_footer endRefreshing];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) return self.categories.count;
    
    //检测footer的状态
    [self checkFooterState];
    
    //右边的用户表格
    return [TTSelectedCategory users].count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        TTRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:TTCategoryId];
        
        cell.category = self.categories[indexPath.row];
        
        return cell;
    }else{
        TTRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:TTUserId];
        cell.user = [TTSelectedCategory users][indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    
    TTRecommendCategory *c = self.categories[indexPath.row];
    if (c.users.count) {
        //显示曾经的数据
        [self.userTableView reloadData];
    }else {
        //赶快刷新表格 目的是 马上显示当前的category的用户数据 不让用户看见上一个category残留的数据
        [self.userTableView reloadData];
        
        //进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    }

}

- (void)dealloc
{
    //停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}
@end
