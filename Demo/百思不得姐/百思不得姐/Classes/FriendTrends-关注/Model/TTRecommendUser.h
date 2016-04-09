//
//  TTRecommendUser.h
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/9.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTRecommendUser : NSObject
//头像
@property (nonatomic, copy) NSString *header;
//新粉丝
@property (nonatomic, assign) NSInteger fans_count;
//昵称
@property (nonatomic, copy) NSString *screen_name;
@end
