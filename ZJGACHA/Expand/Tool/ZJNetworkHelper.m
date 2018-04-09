//
//  ZJNetworkHelper.m
//  ZJGACHA
//
//  Created by 尾灯 on 2018/4/3.
//  Copyright © 2018年 尾灯. All rights reserved.
//

#import "ZJNetworkHelper.h"
#import <AFNetworkActivityIndicatorManager.h>

static AFHTTPSessionManager *manager;

@implementation ZJNetworkHelper

+ (AFHTTPSessionManager *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //打开状态栏等待菊花
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        manager = [AFHTTPSessionManager manager];
        //manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.requestSerializer.timeoutInterval = 60;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain",@"text/json", @"text/javascript",@"text/html", nil];
    });
    return manager;
}

+ (void)requestGETWithRequestUrl:(NSString *)requestURLString withParameters:(id)parameters withSuccess:(httpRequestSuccess)success withFailure:(httpRequestFailure)failure
{
    [[ZJNetworkHelper sharedInstance] GET:requestURLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        failure(error);
    }];
}

+ (void)requestPOSTWithRequestUrl:(NSString *)requestURLString withParameters:(id)parameters withSuccess:(httpRequestSuccess)success withFailure:(httpRequestFailure)failure
{
    [[ZJNetworkHelper sharedInstance] POST:requestURLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        failure(error);
    }];
}
@end

#ifdef DEBUG
@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    [strM appendString:@")"];

    return strM;
}

@end

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];

    [strM appendString:@"}\n"];

    return strM;
}
@end
#endif
