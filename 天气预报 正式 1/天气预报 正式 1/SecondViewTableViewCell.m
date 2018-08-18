//
//  SecondViewTableViewCell.m
//  天气预报 正式 1
//
//  Created by 萨缪 on 2018/8/16.
//  Copyright © 2018年 萨缪. All rights reserved.
//

#import "SecondViewTableViewCell.h"

@implementation SecondViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self ){
        _label1 = [[UILabel alloc] init];
        _label2 = [[UILabel alloc] init];
        
        [self.contentView addSubview:_label1];
        [self.contentView addSubview:_label2];
    }
    return self;
}

- (void)layoutSubviews
{
    _label1.frame = CGRectMake(0, 5, 200, 15);
    _label2.frame = CGRectMake(0, 20, 200, 35);
    
    _label1.font = [UIFont systemFontOfSize:15];
    _label2.font = [UIFont systemFontOfSize:15];
    
    _label1.textColor = [UIColor grayColor];
    _label2.textColor = [UIColor blackColor];
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
