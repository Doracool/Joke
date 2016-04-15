//
//  TTTopic.m
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/14.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import "TTTopic.h"
#import <MJExtension.h>

@implementation TTTopic
{
    CGFloat _cellHeight;
    CGRect _pictureF;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2"
             };
}
- (NSString *)create_time
{
    //日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置时间格式
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    //帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) { //今年
        if (create.isToday) { //今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
            }else if (cmps.minute >= 1){
                return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
            }else{ // 一分钟 > 时间差距
                return @"刚刚";
            }
        }else if (create.isYesterday){// 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        }else{// 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    }else{ //非今年
        return _create_time;
    }
}


- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        //文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * TTTopicCellMargin, MAXFLOAT);
        //计算文字的高度
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        //cell高度
        _cellHeight = TTTopicCellTextY + textH + TTTopicCellMargin;
        
        //根据段子的类型来计算cell的高度
        if (self.type == TTTopicTypePicture) {
            //图片显示出来的宽度
            CGFloat pictureW = maxSize.width;
            //图片显示出来的高度
            CGFloat pictureH = pictureW * self.height / self.width;
            
            if (pictureH >= TTTopicCellPictureMaxH) {
                pictureH = TTTopicCellPictureMaxH;
                self.bigPicture = YES;
            }
            
            //计算图片控件的frame
            CGFloat pictureX = TTTopicCellMargin;
            CGFloat pictureY = TTTopicCellTextY + textH + TTTopicCellMargin;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            _cellHeight += pictureH + TTTopicCellMargin;
        }else if (self.type == TTTopicTypeVoice){
            
        }
        //底部工具条的高度
        _cellHeight += TTTopicCellBottomBarH + TTTopicCellMargin;
    }
    return _cellHeight;
}
@end
