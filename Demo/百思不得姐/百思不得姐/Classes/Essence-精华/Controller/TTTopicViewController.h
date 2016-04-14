//
//  TTTopicViewController.h
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/14.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    TTTopicTypeAll = 1,
    TTTopicTypePicture = 10,
    TTTopicTypeWord = 29,
    TTTopicTypeVoice = 31,
    TTTopicTypeVideo = 41
} TTTopicType;

@interface TTTopicViewController : UITableViewController
/** 帖子类型(交给子类来实现) */
@property (nonatomic, assign) TTTopicType type;
@end
