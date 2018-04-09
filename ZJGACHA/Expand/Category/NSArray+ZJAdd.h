//
//  NSArray+ZJAdd.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/3.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ZJAdd)


/**
 安全获取索引中的对象

 @param index 索引
 @return 对象
 */
- (id)safeObjectAtIndex:(NSUInteger)index;

@end
