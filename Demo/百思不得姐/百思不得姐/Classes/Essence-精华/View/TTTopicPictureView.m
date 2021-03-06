//
//  TTTopicPictureView.m
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/15.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import "TTTopicPictureView.h"
#import "TTTopic.h"
#import <UIImageView+WebCache.h>
@interface TTTopicPictureView ()
/** 图片 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/** gif标识 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/** 查看大图按钮 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
@end

@implementation TTTopicPictureView

+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setTopic:(TTTopic *)topic
{
    _topic = topic;
    
    /**
     *  在不知道图片扩展名的情况下如何知道图片的真实类型
     取出图片数据的第一个字节，就可以判断出图片的真实类型
     */
    //设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    // 判断是否为gif
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    //判断是否显示点击查看全图
    if (topic.isBigPicture) {
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    }else{
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
}
@end
