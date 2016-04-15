//
//  TTTopicPictureView.h
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/15.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTTopic;
@interface TTTopicPictureView : UIView

+ (instancetype)pictureView;

/** 帖子数据 */
@property (nonatomic, strong) TTTopic *topic;
@end
