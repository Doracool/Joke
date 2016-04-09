//
//  TTRecommendUserCell.m
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/9.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import "TTRecommendUserCell.h"
#import "TTRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface TTRecommendUserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *sereenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation TTRecommendUserCell

- (void)setUser:(TTRecommendUser *)user
{
    _user = user;
    
    self.sereenNameLabel.text = user.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
