//
//  ZJDiscoverHotArticleCell.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/11.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverHotArticleCell.h"

@implementation ZJDiscoverHotArticleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self mainView];
    }
    return self;
}


#pragma mark -----------------lazy-----------------
- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
        _mainView.backgroundColor = [ZJColor whiteColor];
         [self.contentView addSubview:_mainView];
        _mainView.width = kScreenWidth;
        _mainView.top = 0;
        _mainView.left = 0;
    }
    return _mainView;
}

- (UIImageView *)thumbImage
{
    if (!_thumbImage) {
        _thumbImage = [[UIImageView alloc] init];
        _thumbImage.backgroundColor = [UIColor redColor];
        _thumbImage.left = 12;
        _thumbImage.size = CGSizeMake(90 * FIT_WIDTH, 110 * FIT_WIDTH);
        [self.mainView addSubview:_thumbImage];
    }
    return _thumbImage;
}

- (YYLabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[YYLabel alloc] init];
        _titleLabel.left = self.thumbImage.right + 10;
        _titleLabel.width = kScreenWidth - 20 - CGRectGetMaxX(_thumbImage.frame) - 10;
        _titleLabel.numberOfLines = 2;
        _titleLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _titleLabel.displaysAsynchronously = YES;
        _titleLabel.ignoreCommonProperties = YES;
        _titleLabel.fadeOnAsynchronouslyDisplay = NO;
        _titleLabel.fadeOnHighlight = NO;
        [self.mainView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (YYLabel *)visitLabel
{
    if (!_visitLabel) {
        _visitLabel = [[YYLabel alloc] init];
        _visitLabel.left = self.thumbImage.right + 10;
        _visitLabel.textColor = [ZJColor appSupportColor];
        _visitLabel.font = [UIFont systemFontOfSize:12];
        [self.mainView addSubview:_visitLabel];
    }
    return _visitLabel;
}

-  (YYLabel *)wordNumLabel
{
    if (!_wordNumLabel) {
        _wordNumLabel = [[YYLabel alloc] init];
        _wordNumLabel.textColor = [ZJColor appSupportColor];
        _wordNumLabel.font = [UIFont systemFontOfSize:12];
        [self.mainView addSubview:_wordNumLabel];
    }
    return _wordNumLabel;
}

- (UIButton *)moreButton
{
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreButton.size = CGSizeMake(80, 30);
        _moreButton.left = self.thumbImage.right + 10;
        _moreButton.layer.borderColor = [ZJColor appMainColor].CGColor;
        _moreButton.layer.borderWidth = 1;
        _moreButton.layer.masksToBounds = YES;
        _moreButton.layer.cornerRadius = 3;
        [_moreButton setTitle:@"阅读更多" forState:UIControlStateNormal];
        [_moreButton setTitleColor:[ZJColor appMainColor] forState:UIControlStateNormal];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.mainView addSubview:_moreButton];
    }
    return _moreButton;
}

- (YYLabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[YYLabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.left = 15;
        _contentLabel.width = kScreenWidth - 30;
        _contentLabel.textVerticalAlignment = YYTextVerticalAlignmentTop;
        _contentLabel.displaysAsynchronously = YES;
        _contentLabel.ignoreCommonProperties = YES;
        _contentLabel.fadeOnAsynchronouslyDisplay = NO;
        _contentLabel.fadeOnHighlight = NO;
        [self.mainView addSubview:_contentLabel];
    }
    return _contentLabel;
}

- (ZJDiscoverHotArticleTagsView *)tagsView
{
    if (!_tagsView) {
        _tagsView = [[ZJDiscoverHotArticleTagsView alloc] init];
        _tagsView.size = CGSizeMake(kScreenWidth - 30, 40);
        _tagsView.left = 12;
        [self.mainView addSubview:_tagsView];
    }
    return _tagsView;
}

- (ZJDiscoverHotArticleProfileView *)profileView
{
    if (!_profileView) {
        _profileView = [[ZJDiscoverHotArticleProfileView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
        [self.mainView addSubview:_profileView];
    }
    return _profileView;
}

- (void)setLayout:(ZJDiscoverHotArticleCellLayout *)layout
{

    _layout = layout;
    self.mainView.height = layout.height - 5;
    self.thumbImage.top = layout.marginTop;
    [self.thumbImage setImageWithURL:[NSURL URLWithString:layout.hotArticleModel.fullThumb] placeholder:placeholderFailImage];

    self.moreButton.top = self.thumbImage.bottom - self.moreButton.height;

    self.titleLabel.top = self.thumbImage.top;
    self.titleLabel.height = layout.titleHeight;
    self.titleLabel.textLayout = layout.titleTextLayout;

    self.visitLabel.top = self.moreButton.top - 10 - layout.visitHeight;
    self.visitLabel.height = layout.visitHeight;
    self.visitLabel.width = layout.visitTextLayout.textBoundingSize.width;
    self.visitLabel.textLayout = layout.visitTextLayout;

    self.wordNumLabel.top = self.moreButton.top - 10 - layout.visitHeight;
    self.wordNumLabel.left = self.visitLabel.right + 10;
    self.wordNumLabel.height = layout.wordNumHeight;
    self.wordNumLabel.width = layout.wordNumTextLayout.textBoundingSize.width;
    self.wordNumLabel.textLayout = layout.wordNumTextLayout;

    self.contentLabel.top = self.thumbImage.bottom;
    self.contentLabel.height = layout.textHeight;
    self.contentLabel.textLayout = layout.textLayout;

    self.tagsView.top = self.contentLabel.bottom;
    [self.tagsView setupUI:layout.hotArticleModel.tags];
    self.profileView.top = self.tagsView.bottom + 10;
    [self.profileView.thumb setImageWithURL:[NSURL URLWithString:layout.hotArticleModel.author.portraitFullUrl] placeholder:placeholderAvatarImage];
    self.profileView.nickLabel.text = layout.hotArticleModel.author.nickName;
    self.profileView.praiseButton.selected = layout.hotArticleModel.hasPraise;
}
@end
