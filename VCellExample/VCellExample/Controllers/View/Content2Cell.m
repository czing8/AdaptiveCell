//
//  Content2Cell.m
//  VCellExample
//
//  Created by Vols on 2015/10/26.
//  Copyright © 2016年 Vols. All rights reserved.
//

#import "Content2Cell.h"

#import "VDateTools.h"

#define  kMarginW 10
#define  kHeaderW 40
#define  kContentFont 14


@interface Content2Cell()

@property (nonatomic, strong) UIImageView * headerImgView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UILabel * dateLabel;
@property (nonatomic, strong) UIView * lineView;

@end


@implementation Content2Cell

#pragma mark - public

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.headerImgView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.dateLabel];
        
        _nameLabel.backgroundColor = [UIColor orangeColor];
        _contentLabel.backgroundColor = [UIColor orangeColor];
        _dateLabel.backgroundColor = [UIColor orangeColor];
        
        [_headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.contentView).offset(10);
            make.size.mas_equalTo(CGSizeMake(kHeaderW, kHeaderW));
        }];
        
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_headerImgView);
            make.left.equalTo(_headerImgView.mas_right).offset(10);
            make.size.mas_equalTo(CGSizeMake(130, 30));
        }];
        
        //跟前一种的主要区别处
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_nameLabel.mas_bottom).offset(10);
            make.left.equalTo(_nameLabel.mas_left);
            make.right.equalTo(_dateLabel);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_nameLabel);
            make.right.mas_equalTo(@(-15));
            make.size.mas_equalTo(CGSizeMake(150, 30));
        }];
    }
    return self;
}

#pragma mark - pravite

- (void)refreshUI:(ContentModel *)model{
    
    _headerImgView.image = [UIImage imageNamed:@"avatar_15"];
    _nameLabel.text = model.user.login;
    _dateLabel.text = [VDateTools dateStringFromTimeInterval:model.published_at];
    _contentLabel.text = model.content;
}

#pragma mark - getter

- (void)setModel:(ContentModel *)model{
    if (_model != model) {
        _model = model;
    }
    [self refreshUI:model];
}

- (UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc] init];
        _headerImgView.image = [UIImage imageNamed:@"avatar_15"];
    }
    return _headerImgView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont systemFontOfSize:kContentFont];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.font = [UIFont systemFontOfSize:14];
    }
    return _dateLabel;
}


//跟前一种的主要区别处
- (void)layoutSubViews {
    [super layoutSubviews];
    [self.contentView  layoutIfNeeded];
    
    self.contentLabel.preferredMaxLayoutWidth = self.contentLabel.bounds.size.width;
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
