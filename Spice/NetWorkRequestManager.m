//
//  NetWorkRequestManager.m
//  Spice
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 spice. All rights reserved.
//

#import "NetWorkRequestManager.h"

@implementation NetWorkRequestManager

+ (void)requestWithType:(RequestType)type urlString:(NSString *)urlString parDic:(NSDictionary *)parDic finish:(RequestFinish)finish error:(RequestError)error{
    NetWorkRequestManager *manager = [[NetWorkRequestManager alloc] init];
    [manager requestWithType:type urlString:urlString parDic:parDic finish:finish error:error];
}

- (void)requestWithType:(RequestType)type urlString:(NSString *)urlString parDic:(NSDictionary *)parDic finish:(RequestFinish)finish error:(RequestError)errorReq{
    //拿到参数后进行请求
    NSURL *url = [NSURL URLWithString:urlString];
    //创建可变的URLRequest
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //如果请求方式的POST需要设置参数和请求方式
    if (type == POST) {
        //设置请求方式
        [request setHTTPMethod:@"POST"];
        if (parDic.count > 0) {
            NSData *data = [self parDicToWithDic:parDic];
            //设置请求参数的body体
            [request setHTTPBody:data];
        }
    }
    //创建session对象
    NSURLSession *session = [NSURLSession sharedSession];
    //通过URL初始化task，在block内处理数据
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                finish(data);
            });
        }else{
            errorReq(error);
        }
    }];
    //启动任务
    [task resume];
}

//把参数字典转化成POST请求所需要的参数体
- (NSData *)parDicToWithDic:(NSDictionary *)dic{
    NSMutableArray *array = [NSMutableArray array];
    //遍历字典得到每一个键，得到所有的key = value类型的字符串
    for (NSString *key in dic) {
        NSString *str = [NSString stringWithFormat:@"%@=%@",key,dic[key]];
        [array addObject:str];
    }
    //数组中的所有key = value 的字符串通过&符号链接
    NSString *parString = [array componentsJoinedByString:@"&"];
    return [parString dataUsingEncoding:NSUTF8StringEncoding];
}







@end
