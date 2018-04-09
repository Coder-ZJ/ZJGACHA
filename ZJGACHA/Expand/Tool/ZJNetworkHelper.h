//
//  ZJNetworkHelper.h
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/3.
//  Copyright © 2018年 尾灯. All rights reserved.
//  网络请求

#import <Foundation/Foundation.h>

/** 请求成功 */
typedef void(^httpRequestSuccess)(id responseObject);
/** 请求失败 */
typedef void(^httpRequestFailure)(NSError *error);

@interface ZJNetworkHelper : NSObject


/**
 单列

 @return AFHTTPSessionManager 对象
 */
+ (AFHTTPSessionManager *)sharedInstance;


/**
 GET请求

 @param requestURLString 请求URL
 @param parameters 请求参数
 @param success 成功
 @param failure 失败
 */
+ (void) requestGETWithRequestUrl:(NSString *)requestURLString
                   withParameters:(id)parameters
                      withSuccess:(httpRequestSuccess)success
                      withFailure:(httpRequestFailure)failure;

/**
 POST请求

 @param requestURLString 请求URL
 @param parameters 请求参数
 @param success 成功
 @param failure 失败
 */
+ (void) requestPOSTWithRequestUrl:(NSString *)requestURLString
                    withParameters:(id)parameters
                       withSuccess:(httpRequestSuccess)success
                       withFailure:(httpRequestFailure)failure;

@end
