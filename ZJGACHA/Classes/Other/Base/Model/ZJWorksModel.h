//
//  ZJWorksModel.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/9.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJBaseModel.h"
#import "ZJAuthorModel.h"
#import "ZJWorkModel.h"

@interface ZJWorksModel : ZJBaseModel

/** 作者 */
@property (nonatomic, strong) ZJAuthorModel  *author;
/** 作品 */
@property (nonatomic, strong) NSMutableArray<ZJWorkModel *> *work;

@end
