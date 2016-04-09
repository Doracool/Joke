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
@interface TTRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 左边的类别数据 **/
@property (nonatomic, strong) NSArray *categories;
/** 左边的类别表格 **/
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@end

@implementation TTRecommendViewController
static NSString * const TTCategoryId = @"category";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐关注";
    
    //注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TTRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:TTCategoryId];
    
    //设置背景色
    self.view.backgroundColor = TTGlobalBg;
    
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TTRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:TTCategoryId];
    
    cell.category = self.categories[indexPath.row];
    
    return cell;
}

@end
