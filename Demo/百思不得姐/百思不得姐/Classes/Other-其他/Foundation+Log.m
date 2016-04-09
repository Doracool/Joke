//
//  Foundation+Log.m
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/8.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *string = [NSMutableString string];
    //开头有个{
    [string appendString:@"{\n"];
    
    //遍历所有键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [string appendFormat:@"\t%@",key];
        [string appendString:@" : "];
        [string appendFormat:@"%@,\n",obj];
    }];
    //结尾有个}
    [string appendString:@"}"];
    
    //查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        [string deleteCharactersInRange:range];
    }
    return string;
}
@end

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *string = [NSMutableString string];
    
    //开头有个[
    [string appendString:@"[\n"];
    
    //遍历所有的元素
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [string appendFormat:@"\%@,\n",obj];
    }];
    
    //结尾有个]
    [string appendString:@"]"];
    
    //查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound) {
        [string deleteCharactersInRange:range];
    }
    return string;
}

@end