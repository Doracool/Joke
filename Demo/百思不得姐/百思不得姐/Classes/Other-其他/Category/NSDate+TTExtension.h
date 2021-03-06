//
//  NSDate+TTExtension.h
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/14.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TTExtension)
/**
 *  比较from和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;

/**
 *  是否为今年
 */
- (BOOL)isThisYear;
/**
 *  是否为今天
 */
- (BOOL)isToday;
/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
@end
