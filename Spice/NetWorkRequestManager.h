//
//  NetWorkRequestManager.h
//  Spice
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 spice. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,RequestType) {
    GET,
    POST
};

typedef void (^RequestFinish)(NSData *data);

typedef void(^RequestError)(NSError *error) ;

@interface NetWorkRequestManager : NSObject

+ (void)requestWithType:(RequestType)type urlString:(NSString *)urlString parDic:(NSDictionary *)parDic finish:(RequestFinish)finish error:(RequestError)error;

@end