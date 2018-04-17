//
//  ZJDiscoverHotArticleCellLayout.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/16.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJDiscoverHotArticleCellLayout.h"

@implementation ZJDiscoverHotArticleCellLayout

- (instancetype)initWithStatus:(ZJDiscoverHotArticleModel *)hotArticleModle
{
    self = [super init];
    if (self) {
         _hotArticleModel = hotArticleModle;
        [self layout];
    }
    return self;
}

- (void)layout
{
    _marginTop = 10;
    _titleHeight = 0;
    _textHeight = 0;
    _tagHeight = 30 + 10;
    _profileHeight = 45;
    //10px边距 + 5px 灰色间距
    _marginBottom = 15;
    // 文本排版，计算布局
    [self layoutTitle];
    [self layoutVisit];
    [self layoutWordNumText];
    [self layoutText];
    // 计算高度
    _height = 0;
    _height += _marginTop;
    _height += 110 * FIT_HEIGHT;
    _height += _textHeight;
    _height += _tagHeight;
    _height += _profileHeight;
    _height += _marginBottom;
}

//计算标题高度
- (void)layoutTitle
{
    NSString *titleStr = nil;
    if (_hotArticleModel.title.length) {
        titleStr = _hotArticleModel.title;
    }
    if (!titleStr.length) {
        _titleTextLayout = nil;
        return;
    }

    NSMutableAttributedString *titleAttr = [[NSMutableAttributedString alloc] initWithString:titleStr];
    titleAttr.color = [ZJColor blackColor];
    titleAttr.font = [UIFont boldSystemFontOfSize:15];
    titleAttr.lineBreakMode = NSLineBreakByCharWrapping;

    WBTextLinePositionModifier *modifier = [[WBTextLinePositionModifier alloc] init];
    modifier.paddingTop = 5;
    modifier.paddingBottom = 10;
    modifier.font = [UIFont boldSystemFontOfSize:15];

    YYTextContainer *container = [[YYTextContainer alloc] init];
    container.size = CGSizeMake(kScreenWidth - 10 - 90 * FIT_WIDTH - 10 - 10, HUGE);
    container.linePositionModifier = modifier;
    container.maximumNumberOfRows = 2;
    _titleTextLayout = [YYTextLayout layoutWithContainer:container text:titleAttr];
    _titleHeight = [modifier heightForLineCount:_titleTextLayout.rowCount];
}
//计算浏览次数高度
- (void)layoutVisit
{
    NSString *visitStr = nil;
    if (_hotArticleModel.visit.length) {
        visitStr = _hotArticleModel.visit;
    }
    if (!visitStr.length) {
        _visitTextLayout = nil;
        return;
    }
    NSMutableAttributedString *visitAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"浏览%@次",visitStr]];
    visitAttr.color = [ZJColor appSupportColor];
    visitAttr.font = [UIFont boldSystemFontOfSize:12];
    visitAttr.lineBreakMode = NSLineBreakByCharWrapping;

    WBTextLinePositionModifier *modifier = [[WBTextLinePositionModifier alloc] init];
    modifier.paddingTop = 2;
    modifier.paddingBottom = 2;
    modifier.font = [UIFont boldSystemFontOfSize:12];

    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth, HUGE)];
    container.maximumNumberOfRows = 1;
    _visitTextLayout = [YYTextLayout layoutWithContainer:container text:visitAttr];
    _visitHeight = [modifier heightForLineCount:_visitTextLayout.rowCount];
}
//连载次数高度计算
- (void)layoutWordNumText
{
    NSString *wordNumStr = nil;
    if (_hotArticleModel.wordNum) {
        wordNumStr = [[NSNumber numberWithLongLong:_hotArticleModel.wordNum] stringValue];
    }
    if (!wordNumStr.length) {
        _wordNumTextLayout = nil;
        return;
    }
    NSMutableAttributedString *wordNumAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"连载%@字",wordNumStr]];
    wordNumAttr.color = [ZJColor appSupportColor];
    wordNumAttr.font = [UIFont boldSystemFontOfSize:12];
    wordNumAttr.lineBreakMode = NSLineBreakByCharWrapping;

    WBTextLinePositionModifier *modifier = [[WBTextLinePositionModifier alloc] init];
    modifier.paddingTop = 2;
    modifier.paddingBottom = 2;
    modifier.font = [UIFont boldSystemFontOfSize:12];

    YYTextContainer *container = [YYTextContainer containerWithSize:CGSizeMake(kScreenWidth, HUGE)];
     container.maximumNumberOfRows = 1;
    _wordNumTextLayout = [YYTextLayout layoutWithContainer:container text:wordNumAttr];
    _wordNumHeight = [modifier heightForLineCount:_wordNumTextLayout.rowCount];
}
//正文高度计算
- (void)layoutText
{
    NSString *textStr = nil;
    if (_hotArticleModel.summary.length) {
        textStr = _hotArticleModel.summary;
    }
    if (!textStr.length) {
        _textLayout = nil;
        return;
    }
    NSMutableAttributedString *textAttr = [self textWithStatus:_hotArticleModel fontSize:15 textColor:[ZJColor appSupportColor]];

    WBTextLinePositionModifier *modifier = [[WBTextLinePositionModifier alloc] init];
    modifier.font = [UIFont fontWithName:@"Heiti SC" size:15];
    modifier.paddingTop = 10;
    modifier.paddingBottom = 5;

    YYTextContainer *container = [[YYTextContainer alloc] init];
    container.maximumNumberOfRows = 5;
    container.size = CGSizeMake(kScreenWidth - 30, HUGE);
    container.linePositionModifier = modifier;
    _textLayout = [YYTextLayout layoutWithContainer:container text:textAttr];
    //超过五行 截断 显示省略号
    if (_textLayout.rowCount == 5) {
        //可见字符串长度
        NSInteger visible = _textLayout.visibleRange.length;
        //总长度
        NSInteger sum = textAttr.length;
        //若未有超出屏幕的字符则直接返回
        if (sum - 1 <= visible) {
            return;
        }
        [textAttr replaceCharactersInRange:NSMakeRange(visible - 1, sum - visible + 1) withString:@"..."];
        _textLayout = [YYTextLayout layoutWithContainer:container text:textAttr];
        NSLog(@"超过五行");
    }
    _textHeight = [modifier heightForLineCount:_textLayout.rowCount];
}
- (NSMutableAttributedString *)textWithStatus:(ZJDiscoverHotArticleModel *)status
                                      fontSize:(CGFloat)fontSize
                                     textColor:(UIColor *)textColor {
    if (!status) return nil;

    NSMutableString *string = status.summary.mutableCopy;
    if (string.length == 0) return nil;
    // 字体
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    // 高亮状态的背景
    YYTextBorder *highlightBorder = [YYTextBorder new];
    highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0);
    highlightBorder.cornerRadius = 3;
    highlightBorder.fillColor = [ZJColor colorWithHexString:@"#bfdffe"];

    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:string];
    text.font = font;
    text.color = textColor;
    text.lineBreakMode = NSLineBreakByCharWrapping;
    return text;
}
@end

@implementation WBTextLinePositionModifier

- (instancetype)init {
    self = [super init];

    if (kiOS9Later) {
        _lineHeightMultiple = 1.34;   // for PingFang SC
    } else {
        _lineHeightMultiple = 1.3125; // for Heiti SC
    }

    return self;
}

- (void)modifyLines:(NSArray *)lines fromText:(NSAttributedString *)text inContainer:(YYTextContainer *)container {
    CGFloat ascent = _font.pointSize * 0.86;
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    for (YYTextLine *line in lines) {
        CGPoint position = line.position;
        position.y = _paddingTop + ascent + line.row  * lineHeight;
        line.position = position;
    }
}

- (id)copyWithZone:(NSZone *)zone {
    WBTextLinePositionModifier *one = [self.class new];
    one->_font = _font;
    one->_paddingTop = _paddingTop;
    one->_paddingBottom = _paddingBottom;
    one->_lineHeightMultiple = _lineHeightMultiple;
    return one;
}

- (CGFloat)heightForLineCount:(NSUInteger)lineCount {
    if (lineCount == 0) return 0;
    CGFloat ascent = _font.pointSize * 0.86;
    CGFloat descent = _font.pointSize * 0.14;
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    return _paddingTop + _paddingBottom + ascent + descent + (lineCount - 1) * lineHeight;
}


@end
