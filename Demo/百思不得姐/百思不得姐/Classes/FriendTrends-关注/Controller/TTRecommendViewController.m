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
@interface TTRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 左边的类别数据 **/
@property (nonatomic, strong) NSArray *categories;
/** 右边的类别数据 **/
@property (nonatomic, strong) NSArray *users;
/** 左边的类别表格 **/
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右边的类别表格 **/
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@end

@implementation TTRecommendViewController
static NSString * const TTCategoryId = @"category";
static NSString * const TTUserId = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupTableView];
    
    //显示指示器
    [SVProgressHUD showWithStatus:@"正在加载"];
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //隐藏指示器
        [SVProgressHUD dismiss];
        
        //服务器返回JSON数据
        self.categories = [TTRecommendCategory objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新表格
        [self.categoryTableView reloadData];
        
        //默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败!"];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }else
    {
        return self.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {
        TTRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:TTCategoryId];
        
        cell.category = self.categories[indexPath.row];
        
        return cell;
    }else{
        TTRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:TTUserId];
        cell.user = self.users[indexPath.row];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TTRecommendCategory *c = self.categories[indexPath.row];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //发送请求给服务器 加载右侧数据
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(c.id);
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            self.users = [TTRecommendUser objectArrayWithKeyValuesArray:responseObject[@"list"]];
            //刷新右边的表格
            [self.userTableView reloadData];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            TTLog(@"%@",error);
        }];
    });
}
@end
