//
//  TTTabBarController.m
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/7.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import "TTTabBarController.h"
#import "TTEssenceViewController.h"
#import "TTNewViewController.h"
#import "TTFriendTrendsViewController.h"
#import "TTMeViewController.h"
#import "TTTabBar.h"
#import "TTNavigationController.h"
@interface TTTabBarController ()

@end

@implementation TTTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UINavigationBar appearance];
    
    //通过appearance统一设置UITabBarItem的文字属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    //添加子控制器
    [self setupChildVc:[[TTEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];

    [self setupChildVc:[[TTNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setupChildVc:[[TTFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    [self setupChildVc:[[TTMeViewController alloc] init] title:@"我" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    //更换tabbar
//    self.tabBar = [[TTTabBar alloc] init];
    [self setValue:[[TTTabBar alloc] init] forKeyPath:@"tabBar"];
}

- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)Image selectedImage:(NSString *)selectedImage{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:Image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    //添加一个导航控制器
    TTNavigationController *nav = [[TTNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
