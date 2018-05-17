//
//  ZJPostDetailCommentCell.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/5/17.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJPostDetailCommentCell.h"

@implementation ZJPostDetailCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [ZJColor whiteColor];
        [self commentContentView];
    }
    return self;
}
- (void)setCommentModel:(ZJPostDetailCommentModel *)commentModel
{
    _commentModel = commentModel;
    [self.commentUserView.avatarImageView setImageWithURL:[NSURL URLWithString:commentModel.avatarFullUrl] placeholder:placeholderAvatarImage];
    //判断是回复帖子还是回复评论
    NSMutableAttributedString *text = nil;
    if (commentModel.atnickname.length) {
        //回复评论
        NSString *atString = [NSString stringWithFormat:@"  回复了%@",commentModel.atnickname];
        text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@",commentModel.nickname,atString]];
        text.font = [UIFont systemFontOfSize:13];
        [text setColor:[ZJColor appSubColor] range:NSMakeRange(0, commentModel.nickname.length)];
        [text setColor:[ZJColor appSupportColor] range:NSMakeRange(commentModel.nickname.length, atString.length)];
    }else{
        //回复帖子
        text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",commentModel.nickname]];
        text.color = [ZJColor appSubColor];
        text.font = [UIFont systemFontOfSize:13];
    }
    self.commentUserView.nameLabel.attributedText = text;
    self.commentUserView.dateLabel.text = commentModel.createTimeString;
    if (commentModel.likeCount) {
        self.commentUserView.likeCountLabel.text = [NSString stringWithFormat:@"%ld",commentModel.likeCount];
    }else{
        self.commentUserView.likeCountLabel.text = @"";
    }

    //判断是否喜欢
    self.commentUserView.likeButton.selected = commentModel.hasLiked;
    self.commentContentView.contentLabel.height = commentModel.contentHeight;
    self.commentContentView.contentLabel.textLayout = commentModel.contentLayout;
}

#pragma mark -----------------lazy-----------------
- (ZJPostDetailCommentUserView *)commentUserView
{
    if (!_commentUserView) {
        _commentUserView = [[ZJPostDetailCommentUserView alloc] init];
        [self.contentView addSubview:_commentUserView];
        [_commentUserView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(50);
        }];
    }
    return _commentUserView;
}

- (ZJPostDetailCommentContentView *)commentContentView
{
    if (!_commentContentView) {
        _commentContentView = [[ZJPostDetailCommentContentView alloc] init];
        [self.contentView addSubview:_commentContentView];
        [_commentContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.commentUserView.avatarImageView.mas_right).with.offset(10);
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(self.commentUserView.mas_bottom).with.offset(0);
            make.bottom.mas_equalTo(self.contentView).with.offset(0);
        }];
    }
    return _commentContentView;
}

@end


@implementation ZJPostDetailCommentUserView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [ZJColor whiteColor];
        [self likeButton];
        [self topLine];
    }
    return self;
}

#pragma mark -----------------lazy-----------------
- (UIImageView *)avatarImageView
{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        _avatarImageView.layer.cornerRadius = 30 * 0.5;
        _avatarImageView.layer.masksToBounds = YES;
        [self addSubview:_avatarImageView];
        [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.centerY.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
    }
    return _avatarImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [ZJColor appSubColor];
        _nameLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.avatarImageView.mas_top).with.offset(0);
            make.left.mas_equalTo(self.avatarImageView.mas_right).with.offset(10);
            make.right.mas_equalTo(self.likeButton.mas_left).with.offset(10);
        }];
    }
    return _nameLabel;
}

- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = [ZJColor appSupportColor];
        _dateLabel.font = [UIFont systemFontOfSize:11];
        [self addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.nameLabel);
            make.top.mas_equalTo(self.nameLabel.mas_bottom).with.offset(2);
        }];
    }
    return _dateLabel;
}

- (UIButton *)likeButton
{
    if (!_likeButton) {
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"postDetail_comment_notSupport~iphone"];
        [_likeButton setImage:image forState:UIControlStateNormal];
        [_likeButton setImage:[UIImage imageNamed:@"postDetail_comment_supported~iphone"] forState:UIControlStateSelected];
        [self addSubview:_likeButton];
        [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(image.size);
            make.centerY.mas_equalTo(self.likeCountLabel);
            make.right.mas_equalTo(self.likeCountLabel.mas_left).with.offset(-5);
        }];
    }
    return _likeButton;
}

- (UILabel *)likeCountLabel
{
    if (!_likeCountLabel) {
        _likeCountLabel = [[UILabel alloc] init];
        _likeCountLabel.textColor = [ZJColor appSupportColor];
        _likeCountLabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:_likeCountLabel];
        [_likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.nameLabel);
            make.right.mas_equalTo(self.mas_right).with.offset(-20);
        }];
    }
    return _likeCountLabel;
}

- (UIView *)topLine
{
    if (!_topLine) {
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = [ZJColor appBottomLineColor];
        [self addSubview:_topLine];
        [_topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.avatarImageView.mas_left).with.offset(0);
            make.right.top.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _topLine;
}
@end


@implementation ZJPostDetailCommentContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [ZJColor whiteColor];
    }
    return self;
}

#pragma mark -----------------lazy-----------------
- (YYLabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[YYLabel alloc] init];
        _contentLabel.fadeOnAsynchronouslyDisplay = YES;
        _contentLabel.textColor = [ZJColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(0);
        }];
    }
    return _contentLabel;
}

@end

