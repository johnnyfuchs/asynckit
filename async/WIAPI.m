//
// Created by Johnny Sparks on 4/22/15.
// Copyright (c) 2015 We Heart It. All rights reserved.
//

#import "WIAPI.h"



static void WILogURLTask(NSURLSessionDataTask *task) {
    NSMutableString *s = NSMutableString.new;
    if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
        [s appendFormat:@"%i", ((NSHTTPURLResponse *) task.response).statusCode];
    } else {
        [s appendString:@"OK"];
    }
    [s appendFormat:@" (%qi bytes)", task.response.expectedContentLength];
    [s appendFormat:@" %@ %@", task.originalRequest.HTTPMethod, task.originalRequest.URL.absoluteString];
    NSLog(@"%@", s);
}

@interface AFHTTPSessionManager (WIAPI)
// Hack to avoid forking on GET/POST/HEAD/DELETE/PUT
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure;
@end

@interface WIAPI ()
@property(nonatomic, strong) AFHTTPSessionManager *sessionManager;
@end

@implementation WIAPI

+ (instancetype) mainAPISession
{
    static WIAPI *sMainAPISession;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sMainAPISession = [WIAPI new];
    });
    return sMainAPISession;
}

- (AFHTTPSessionManager *)sessionManager
{
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager new];
        [_sessionManager initWithBaseURL:[NSURL URLWithString:@"https://api.weheartit.com"] sessionConfiguration:nil];
        _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
        [_sessionManager.requestSerializer setValue:@"Content-Type" forHTTPHeaderField:@"application/json"];
    }
    return _sessionManager;
}

+ (void)callMethod:(NSString *)method path:(NSString *)path params:(NSDictionary *)inputParams done:(void (^)(NSURLSessionDataTask *, id JSON, NSError *error))done
{
    NSParameterAssert(method);
    NSParameterAssert(path);
    NSParameterAssert(done);

    NSMutableDictionary *params = [@{
            @"access_token" : @"a7cc70dcd6e4293e587449886a03b93193f544e57516a5e3c745d922c34481fc",
    } mutableCopy];

    [params addEntriesFromDictionary:inputParams];

    AFHTTPSessionManager *manager = [[self mainAPISession] sessionManager];
    NSURLSessionDataTask *task = [manager dataTaskWithHTTPMethod:method
                                                       URLString:path
                                                      parameters:params
                                                         success:^(NSURLSessionDataTask *task, id o) {
                                                             WILogURLTask(task);
                                                             done(task, o, nil);
                                                         }
                                                         failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                             WILogURLTask(task);
                                                             done(task, nil, error);
                                                         }];
    [task resume];
}


@end