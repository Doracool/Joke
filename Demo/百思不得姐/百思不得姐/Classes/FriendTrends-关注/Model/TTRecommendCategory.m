//
//  TTRecommendCategory.m
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/9.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import "TTRecommendCategory.h"
#import <MJExtension.h>

@implementation TTRecommendCategory

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}
- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
