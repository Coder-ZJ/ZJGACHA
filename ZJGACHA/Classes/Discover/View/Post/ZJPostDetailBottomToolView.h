//
//  ZJPostDetailBottomToolView.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/5/15.
//  Copyright © 2018年 尾灯. All rights reserved.
//  详情页底部工具

#import <UIKit/UIKit.h>

@interface ZJPostDetailBottomToolView : UIView

/** 收藏按钮 */
@property (nonatomic, strong) UIButton *collectButton;
/** 评论按钮 */
@property (nonatomic, strong) UIButton *commentButton;
/** 点赞按钮 */
@property (nonatomic, strong) UIButton *praiseButton;
/** 显示点赞数量 */
@property (nonatomic, strong) UILabel *praiseCountLabel;
/** 点赞数量 */
@property (nonatomic, assign) NSInteger count;

/** 收藏回调 */
@property (nonatomic, copy) void (^clickCollectBlock)(BOOL);
/** 评论回调 */
@property (nonatomic, copy) void (^clickCommentBlock)(BOOL);
/** 点赞回调 */
@property (nonatomic, copy) void (^clickPraiseBlock)(BOOL);

@end
