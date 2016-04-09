//
//  TTRecommendCategoryCell.m
//  百思不得姐
//
//  Created by 李涛涛 on 16/4/9.
//  Copyright © 2016年 李涛涛. All rights reserved.
//

#import "TTRecommendCategoryCell.h"
#import "TTRecommendCategory.h"
@interface TTRecommendCategoryCell ()
//选中时显示的指示器控件
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;
@end
@implementation TTRecommendCategoryCell

- (void)awakeFromNib {
    self.backgroundColor = TTRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = TTRGBColor(219, 21, 26);
#warning cell的selection设置为None是 cell被选中的时候内部的子控件就不会进入高亮状态
}

- (void)setCategory:(TTRecommendCategory *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 重新调整内部textLabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : TTRGBColor(78, 78, 78);
}

@end
