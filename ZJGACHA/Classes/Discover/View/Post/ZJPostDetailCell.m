//
//  ZJPostDetailCell.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/5/15.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJPostDetailCell.h"
#import "ZJPostDetailViewController.h"
#import "ZJRelatedPostsModel.h"

@implementation ZJPostDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}

@end


#pragma mark -----------------排行榜Cell-----------------
@implementation ZJPostDetailRankCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self bgImageView];
        [self rankInfoLabel];
        [self iconImageView];
    }
    return self;
}

#pragma mark -----------------lazy-----------------
- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.image = [UIImage imageNamed:@"postDetail_topRank_mainImage"];
        [self.contentView addSubview:_bgImageView];
        [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_offset(0);
        }];
    }
    return _bgImageView;
}

- (UILabel *)rankInfoLabel
{
    if (!_rankInfoLabel) {
        _rankInfoLabel = [[UILabel alloc] init];
        _rankInfoLabel.textColor = [ZJColor blackColor];
        _rankInfoLabel.text = @"5.14/日榜  NO.1";
        _rankInfoLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_rankInfoLabel];
        [_rankInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.mas_equalTo(self.mas_left).with.offset(70);
            make.right.mas_equalTo(self.selectRankLabel.mas_left).with.offset(0);
        }];
    }
    return _rankInfoLabel;
}

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"postDetail_arrow~iphone"];
        _iconImageView.image = image;
        [self.contentView addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
            make.right.mas_equalTo(self.contentView.mas_right).with.offset(-12);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _iconImageView;
}

- (UILabel *)selectRankLabel
{
    if (!_selectRankLabel) {
        _selectRankLabel = [[UILabel alloc] init];
        NSString *str = @"查看排行榜";
        _selectRankLabel.text = str;
        _selectRankLabel.textColor = [ZJColor appSubColor];
        _selectRankLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_selectRankLabel];
        [_selectRankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.iconImageView.mas_left).with.offset(0);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo([NSString getTitleWidth:str withFontSize:12]);
        }];
    }
    return _selectRankLabel;
}

@end

#pragma mark -----------------作者信息-----------------
@implementation ZJPostDetailUserInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [ZJColor whiteColor];
        [self line];
    }
    return self;
}

- (void)setPostDetailModel:(ZJPostDetailModel *)postDetailModel
{
    _postDetailModel = postDetailModel;
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:postDetailModel.avatarFullUrl] placeholder:placeholderAvatarImage];
    self.nameLabel.text = postDetailModel.authorNickName;
    self.dateLabel.text = postDetailModel.createTimeString;
    self.circleNameLabel.text = postDetailModel.circleName;
    [self.dateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([NSString getTitleWidth:postDetailModel.createTimeString withFontSize:13]);
    }];
}

#pragma mark -----------------lazy-----------------
- (UIImageView *)avatarImageView
{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.cornerRadius = 40 * 0.5;
        _avatarImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:_avatarImageView];
        [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.centerY.mas_equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
    }
    return _avatarImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [ZJColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.avatarImageView.mas_right).with.offset(10);
            make.top.mas_equalTo(self.avatarImageView.mas_top).with.offset(2);
            make.right.mas_equalTo(self.addCollectButton.mas_left).with.offset(-10);
        }];
    }
    return _nameLabel;
}

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.font = [UIFont systemFontOfSize:13];
        _dateLabel.textColor = [ZJColor appSupportColor];
        [self.contentView addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.avatarImageView.mas_right).with.offset(10);
            make.bottom.mas_equalTo(self.avatarImageView.mas_bottom).with.offset(-2);
        }];
    }
    return _dateLabel;
}

- (UILabel *)circleNameLabel
{
    if (!_circleNameLabel) {
        _circleNameLabel = [[UILabel alloc] init];
        _circleNameLabel.font = [UIFont systemFontOfSize:13];
        _circleNameLabel.textColor = [ZJColor appSubBlueColor];
        [self.contentView addSubview:_circleNameLabel];
        [_circleNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.dateLabel.mas_right).with.offset(5);
            make.centerY.mas_equalTo(self.dateLabel);
            make.right.mas_equalTo(self.addCollectButton.mas_left).with.offset(-10);
        }];
    }
    return _circleNameLabel;
}
- (UIButton *)addCollectButton
{
    if (!_addCollectButton) {
        _addCollectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addCollectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addCollectButton.userInteractionEnabled = YES;
        _addCollectButton.layer.cornerRadius = 5;
        _addCollectButton.layer.masksToBounds = YES;
        _addCollectButton.layer.borderWidth = 0.5;
        _addCollectButton.layer.borderColor = [ZJColor appMainColor].CGColor;
        [_addCollectButton setTitleColor:[ZJColor appMainColor] forState:UIControlStateNormal];
        _addCollectButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_addCollectButton setTitle:@"＋关注" forState:UIControlStateNormal];
        [self.contentView addSubview:_addCollectButton];
        [_addCollectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(65, 32));
            make.right.mas_equalTo(self.contentView.mas_right).with.offset(-10);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return _addCollectButton;
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = [ZJColor appBottomLineColor];
        [self.contentView addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.right.mas_equalTo(-12);
            make.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _line;
}
@end

#pragma mark -----------------正文cell-----------------
@implementation ZJPostDetailTextContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [ZJColor whiteColor];
    }
    return self;
}

- (void)setPostDetailModel:(ZJPostDetailModel *)postDetailModel
{
    _postDetailModel = postDetailModel;
    self.textContentLabel.height = postDetailModel.richTextHeight;
    self.textContentLabel.textLayout = postDetailModel.richTextLayout;
}

- (YYLabel *)textContentLabel
{
    if (!_textContentLabel) {
        _textContentLabel = [[YYLabel alloc] init];
        _textContentLabel.displaysAsynchronously = YES;
        _textContentLabel.ignoreCommonProperties = YES;
        _textContentLabel.fadeOnAsynchronouslyDisplay = YES;
        _textContentLabel.mj_x= 12;
        _textContentLabel.mj_y = 0;
        _textContentLabel.width = kScreenWidth - 12 * 2;
        [self.contentView addSubview:_textContentLabel];
    }
    return _textContentLabel;
}


@end

#pragma mark -----------------图片列表cell-----------------
@implementation ZJPostDetailImageListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [ZJColor whiteColor];
    }
    return self;
}

- (void)setPostDetailModel:(ZJPostDetailModel *)postDetailModel
{
    _postDetailModel = postDetailModel;
    if (!postDetailModel.downloadImgInfos.count) {
        return;
    }
    //存储所有图片总高度
    CGFloat imageHeight = 0;
    for (int i = 1; i <= postDetailModel.downloadImgInfos.count; i++) {
        ZJImageView *imageView = [self viewWithTag:i * 10];
        CGFloat height = kScreenWidth * [postDetailModel.downloadImgInfos objectAtIndex:i - 1].height / [postDetailModel.downloadImgInfos objectAtIndex:i - 1].width;
        if (!imageView) {
            imageView = [[ZJImageView alloc] init];
            imageView.tag = i * 10;
            imageView.mj_x = 0;
            imageView.mj_y = imageHeight;
            imageView.width = kScreenWidth;
            imageView.height = height;
            imageHeight += height + 5;
            [self.contentView addSubview:imageView];
        }
         NSString *url = [NSString stringWithFormat:@"%@%@?imageView&axis=5_0&enlarge=1&quality=75&thumbnail=%.0fy%.0f&type=webp",HttpImageURLPre,[postDetailModel.imagesID objectAtIndex:i-1],kScreenWidth,height];
        [imageView setAnimationLoadingImage:[NSURL URLWithString:url] placeholder:placeholderFailImage];
    }
}

@end

#pragma mark -----------------标签cell-----------------
@implementation ZJPostDetailTagsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [ZJColor whiteColor];
    }
    return self;
}

- (void)setPostDetailModel:(ZJPostDetailModel *)postDetailModel
{
    _postDetailModel = postDetailModel;
    [self.tagsView setupPostDetailTags:postDetailModel.tags];
}

#pragma mark -----------------lazy-----------------
- (ZJDiscoverHotArticleTagsView *)tagsView
{
    if (!_tagsView) {
        _tagsView = [[ZJDiscoverHotArticleTagsView alloc] init];
        _tagsView.size = CGSizeMake(kScreenWidth, 60);
        _tagsView.mj_x = 0;
        _tagsView.mj_y = 0;
        [self.contentView addSubview:_tagsView];
    }
    return _tagsView;
}

@end

#pragma mark -----------------点赞的人cell-----------------
@implementation ZJPostDetailPraiseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [ZJColor whiteColor];
        self.marginLeft = 0;
        [self praiseCountLabel];
    }
    return self;
}
//系统默认是（375，44）,需要重新frame放过即可
- (void)setFrame:(CGRect)frame
{
    frame.size.width = kScreenWidth;
    [super setFrame:frame];

}

- (void)setPostDetailModel:(ZJPostDetailModel *)postDetailModel
{
    _postDetailModel = postDetailModel;
    self.praiseCountLabel.text = [NSString stringWithFormat:@"%ld人喜欢",postDetailModel.supportCount];
    [self.praiseCountLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([NSString getTitleWidth:self.praiseCountLabel.text withFontSize:13]);
    }];
    [self.praiseCountLabel.superview layoutIfNeeded];
    //循环次数
    NSInteger count = postDetailModel.supportCount < 10 ? postDetailModel.supportCount : 10;
    for (int i = 1 ; i <= count; i++) {
        UIImageView *imageView = [self viewWithTag:i * 10];
        if (!imageView) {
            //如果图片frame超过右边标签的x就跳过
            if (self.marginLeft + 8 + 28 + 10 > self.praiseCountLabel.mj_x) {
                break;
            }
            imageView = [[UIImageView alloc] init];
            imageView.layer.cornerRadius = 30 * 0.5;
            imageView.layer.masksToBounds = YES;
            [self.contentView addSubview:imageView];

            imageView.tag = i * 10;
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(30, 30));
                make.left.mas_equalTo(self.marginLeft + 12);
                make.centerY.mas_equalTo(self.contentView);
            }];
            [imageView.superview layoutIfNeeded];
            self.marginLeft = self.marginLeft + imageView.size.width + 8;
            ZJPostDetailPraiseAuthorModel *authorModel = [postDetailModel.supportArray safeObjectAtIndex:i - 1];
            [imageView setImageWithURL:[NSURL URLWithString:authorModel.avatarFullUrl] placeholder:placeholderAvatarImage];
        }
    }
}

#pragma mark -----------------lazy-----------------

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        UIImage *image = [UIImage imageNamed:@"postDetail_arrow~iphone"];
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = image;
        [self.contentView addSubview:_arrowImageView];
        [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
            make.right.mas_equalTo(-12);
            make.centerY.mas_equalTo(self.contentView);
        }];
        [_arrowImageView.superview layoutIfNeeded];
    }
    return _arrowImageView;
}

- (UILabel *)praiseCountLabel
{
    if (!_praiseCountLabel) {
        _praiseCountLabel = [[UILabel alloc] init];
        _praiseCountLabel.textColor = [ZJColor appSupportColor];
        _praiseCountLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_praiseCountLabel];
        [_praiseCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.arrowImageView.mas_left).with.offset(-5);
            make.centerY.mas_equalTo(self.contentView);
            make.width.mas_equalTo(50);
        }];
        [_praiseCountLabel.superview layoutIfNeeded];
    }
    return _praiseCountLabel;
}

- (void)layoutSubviews
{
    [super layoutSubviews];


}

@end

#pragma mark -----------------猜你喜欢-----------------
@implementation ZJPostDetailRelatedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [ZJColor whiteColor];
    }
    return self;
}

- (void)setPostDetailModel:(ZJPostDetailModel *)postDetailModel
{
    _postDetailModel = postDetailModel;
    if (postDetailModel.relatedPosts.count) {
        CGFloat width = 0, height = 0;
        width = [postDetailModel.relatedPosts firstObject].cover.realWidth;
        height = [postDetailModel.relatedPosts firstObject].cover.realHeight;
        for (int i = 1; i <= postDetailModel.relatedPosts.count; i++) {
            UIImageView *imageView = [self viewWithTag:i * 100];
            if (!imageView) {
                imageView = [[UIImageView alloc] init];
                imageView.userInteractionEnabled = YES;
                imageView.layer.cornerRadius = 2;
                imageView.layer.masksToBounds = YES;
                imageView.tag = i * 100;
                [self.scrollView addSubview:imageView];
                if (i == 1) {
                    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(12);
                        make.width.mas_equalTo(width);
                        make.top.mas_equalTo(0);
                        make.height.mas_equalTo(self.scrollView.height);
                    }];
                }else{
                    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo((i - 1) * width + 12 + (i - 1) * 8);
                        make.width.mas_equalTo(width);
                        make.top.mas_equalTo(0);
                        make.height.mas_equalTo(self.scrollView.height);
                    }];
                }
                self.marginLeft += imageView.size.width + 8;
                NSString *imageUrl = [postDetailModel.relatedPosts objectAtIndex:i - 1].cover.fullUrl;
                [imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholder:placeholderFailImage];

                //添加点击手势
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)];
                [imageView addGestureRecognizer:tap];
            }
        }
    }
}

- (void)imageViewTap:(UITapGestureRecognizer *)tap
{
    NSInteger tag = tap.view.tag / 100;
    ZJPostDetailViewController *postDetailVC = [[ZJPostDetailViewController alloc] init];
    ZJRelatedPostsModel *relatedModel = [self.postDetailModel.relatedPosts objectAtIndex:tag - 1];
    postDetailVC.postId = relatedModel.postId;
    [self.viewController.navigationController pushViewController:postDetailVC animated:YES];
}
#pragma mark -----------------lazy-----------------
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        [self.contentView addSubview:_scrollView];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(_postDetailModel.relatedPosts.count * [_postDetailModel.relatedPosts firstObject].cover.realWidth + 24 + (_postDetailModel.relatedPosts.count - 1) * 8, 0);
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
        [_scrollView.superview layoutIfNeeded];
    }
    return _scrollView;
}

@end
