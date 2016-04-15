//
//  TTTopicCell.m
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/14.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import "TTTopicCell.h"
#import "TTTopic.h"
#import <UIImageView+WebCache.h>
#import "TTTopicPictureView.h"
@interface TTTopicCell ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 是否新浪加V */
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;
/** 帖子的文字内容 */
@property (weak, nonatomic) IBOutlet UILabel *text_label;
/** 图片帖子中间的内容 */
@property (nonatomic, weak) TTTopicPictureView *pictureView;
@end

@implementation TTTopicCell

- (TTTopicPictureView *)pictureView
{
    if (!_pictureView) {
        TTTopicPictureView *pictureView = [TTTopicPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    return _pictureView;
}

- (void)awakeFromNib {
    
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    
}

- (void)setTopic:(TTTopic *)topic
{
    _topic = topic;
    
    //新浪加V
    self.sinaVView.hidden = !topic.isSina_v;
    //设置其他控件
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = topic.name;
    self.createTimeLabel.text = topic.create_time;
    
    //设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
    //设置帖子的文字内容
    self.text_label.text = topic.text;
    
    //根据帖子类型添加对应的内容到cell中间
    if (topic.type == TTTopicTypePicture) {
        self.pictureView.topic = topic;
        self.pictureView.frame = topic.pictureF;
    }else if (topic.type == TTTopicTypeVoice){
        
    }
    
}
//
//- (void)testDate:(NSString *)create_time
//{
//    //时间日期格式
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    //设置日期格式(y:年 M:月 d:日 H:时 m:分 s:秒)
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    
//    //当前时间
//    NSDate *now = [NSDate date];
//    
//    //发帖时间
//    NSDate *create = [fmt dateFromString:create_time];
//    
//    TTLog(@"%@",[now deltaFrom:create]);
//}

- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
    }else if (count > 0){
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x = TTTopicCellMargin;
    frame.size.width -= 2 * TTTopicCellMargin;
    frame.size.height -= TTTopicCellMargin;
    frame.origin.y += TTTopicCellMargin;
    
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
